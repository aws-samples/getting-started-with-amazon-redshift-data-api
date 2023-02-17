package main

import (
	"context"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/redshiftdataapiservice"
	"github.com/aws/aws-sdk-go/service/redshiftdataapiservice/redshiftdataapiserviceiface"
	"github.com/cevaris/ordered_map"
	log "github.com/sirupsen/logrus"
	"time"
)

// Declare redshiftclient client
var redshiftclient redshiftdataapiserviceiface.RedshiftDataAPIServiceAPI

type Redshift_Event struct {
	Redshift_workgroup_name string `json:"redshift_workgroup_name"`
	Redshift_database       string `json:"redshift_database"`
	Redshift_iam_role       string `json:"redshift_iam_role"`
	Run_type                string `json:"run_type"`
}

func main() {
	// Create session
	var sess = session.Must(session.NewSession())
	// Initialize the redshift client
	redshiftclient = redshiftdataapiservice.New(sess)
	//Calling Handler Function
	lambda.Start(HandleRequest)
}

func HandleRequest(ctx context.Context, name Redshift_Event) (string, error) {
	log.Print("Inside Go Handler function!")
	//var responses2 = make(map[string]string);
	final_resp := ""
	responses := ordered_map.NewOrderedMap()
	// Cluster identifier for the Amazon Redshift cluster
	// redshift_cluster_id := name.Redshift_cluster_id
	// Cluster identifier for the Amazon Redshift cluster
	redshift_workgroup_name := name.Redshift_workgroup_name
	// Database name for the Amazon Redshift cluster
	redshift_database := name.Redshift_database
	// Database user in the Amazon Redshift cluster with access to execute relevant SQL queries
	// redshift_user := name.Redshift_user
	// IAM Role of Amazon Redshift cluster having access to S3
	redshift_iam_role := name.Redshift_iam_role
	// run_type can be either asynchronous or synchronous; try tweaking based on your requirement
	run_type := name.Run_type

	if run_type != "synchronous" && run_type != "asynchronous" {
		// Fatal functions call os.Exit(1) after writing the log message
		log.Fatal("Invalid Event run_type. \n run_type has to be synchronous or asynchronous.")
	}

	isSynchronous := false
	if run_type == "synchronous" {
		isSynchronous = true
	} else {
		isSynchronous = false
	}
	log.Print("Run-Type Mode ", run_type)

	// Initiate OrderedMap key value pair for query and its type
	sql_statements := ordered_map.NewOrderedMap()
	sql_statements.Set("CREATE", "CREATE TABLE IF NOT EXISTS public.region (\n"+
		"  R_REGIONKEY bigint NOT NULL,\n"+
		"  R_NAME varchar(25),\n"+"  R_COMMENT varchar(152))\n"+"diststyle all;")
	sql_statements.Set("COPY", "COPY region FROM 's3://redshift-immersionday-labs/data/region/region.tbl.lzo'\n"+
		"iam_role '"+redshift_iam_role+"' \n"+"region 'us-west-2' lzop delimiter '|' COMPUPDATE PRESET;")
	sql_statements.Set("UPDATE", "UPDATE public.region SET r_regionkey= 5 WHERE r_name ='AFRICA';")
	sql_statements.Set("DELETE", "DELETE FROM public.region where r_name = 'MIDDLE EAST';")
	sql_statements.Set("SELECT", "SELECT r_regionkey, r_name FROM public.region;")
	log.Print("Running sql queries in ", run_type, " mode!")

	// Iterating over ordered map to execute each sql statement
	iter := sql_statements.IterFunc()
	for kv, ok := iter(); ok; kv, ok = iter() {
		command := kv.Key.(string)
		query := kv.Value.(string)
		log.Print("Example of ", command, ":")
		log.Print("Running Query ", query)
		responses.Set(command, execute_sql_data_api(redshift_database, command, query, redshift_workgroup_name, isSynchronous))
	}

	// returning resultset in execution ordered fashion
	iter1 := responses.IterFunc()
	for kv, ok := iter1(); ok; kv, ok = iter1() {
		command := kv.Key.(string)
		status := kv.Value.(string)
		final_resp += command + ":" + status + " | "
	}

	return final_resp, nil
}

func execute_sql_data_api(redshift_database string, command string, query string, redshift_workgroup_name string, isSynchronous bool) string {
	var max_wait_cycles = 20
	var attempts = 0
	var query_status = ""
	done := false

	// Calling Redshift Data API with executeStatement()
	execstmt_req, execstmt_err := redshiftclient.ExecuteStatement(&redshiftdataapiservice.ExecuteStatementInput{
		WorkgroupName: aws.String(redshift_workgroup_name),
		Database:      aws.String(redshift_database),
		Sql:           aws.String(query),
	})

	if execstmt_err != nil {
		// logs error and exists
		log.Fatal(execstmt_err)
	}

	descstmt_req, descstmt_err := redshiftclient.DescribeStatement(&redshiftdataapiservice.DescribeStatementInput{
		Id: execstmt_req.Id,
	})
	query_status = aws.StringValue(descstmt_req.Status)

	if descstmt_err != nil {
		// logs error and exists
		log.Fatal(descstmt_err)
	}

	//Wait until query is finished or max cycles limit has been reached.
	for done == false && isSynchronous && attempts < max_wait_cycles {
		attempts += 1
		time.Sleep(1 * time.Second)
		descstmt_req, descstmt_err := redshiftclient.DescribeStatement(&redshiftdataapiservice.DescribeStatementInput{
			Id: execstmt_req.Id,
		})
		query_status = aws.StringValue(descstmt_req.Status)

		if query_status == "FAILED" {
			// Fatal functions call os.Exit(1) after writing the log message
			log.Fatal("Query status: ", query_status, " .... for query--> ", query)
		} else if query_status == "FINISHED" {
			log.Print("Query status: ", query_status, " .... for query--> ", query)
			done = true

			if *descstmt_req.HasResultSet {
				getresult_req, getresult_err := redshiftclient.GetStatementResult(&redshiftdataapiservice.GetStatementResultInput{
					Id: execstmt_req.Id,
				})

				if getresult_err != nil {
					// logs error and exists
					log.Fatal(getresult_err)
				}

				log.Print(getresult_req.Records)
			}
		} else {
			log.Print("Currently working... query status: ", query_status, " .... for query--> ", query)
		}

		if descstmt_err != nil {
			// logs error and exists
			log.Fatal(descstmt_err)
		}
	}

	//Timeout Precaution
	if done == false && attempts >= max_wait_cycles && isSynchronous {
		log.Print("Query status: ", query_status, " .... for query--> ", query)
		// Fatal functions call os.Exit(1) after writing the log message
		log.Fatal("Limit for max_wait_cycles has been reached before the query was able to finish. We have exited out of the while-loop. You may increase the limit accordingly.")
	}

	return query_status
}
