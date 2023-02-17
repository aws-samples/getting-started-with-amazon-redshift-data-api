# Go

The sample Go code given is leveraging AWS SDK version 1.x for Go. For more information on the RedshiftDataAPIServiceAPI class, please check out the [documentation](https://docs.aws.amazon.com/sdk-for-go/api/service/redshiftdataapiservice/).

## Go Preparation

Although this tutorial is aimed for you to better handle Amazon Redshift Data API, here are the instructions to deploy to a Go runtime lambda function. 

1. Creating a Go Lambda functions with .zip file archives: [Link](https://docs.amazonaws.cn/en_us/lambda/latest/dg/golang-package.html)
2. Understand what an AWS Lambda function handler is: [Link](https://docs.amazonaws.cn/en_us/lambda/latest/dg/golang-handler.html)
3. After creating your "Hello Name" greeting deployment package with the function handler, upload .zip file to Lambda to test it out. 
4. Make sure to configure your Lambda setting's handler to match the Go file name.

## Pre-requisites

* Lambda function with Go 1.x runtime. 
* The default Lambda function timeout is set to 3 seconds. Depending on your style of execution, you may have to increase this parameter.
* IAM Role attached to your Redshift cluster having access to S3
* IAM Role attached to your Lambda function having access to `AmazonRedshiftDataFullAccess` role
* IAM Role attached to your Lambda function having access to `AmazonRedshiftFullAccess` role

## Walk-through

The AWS Lambda event handler JSON object should be this structure. Replace the values for placeholder according to your redshift cluster and IAM Role configuration. 

### Redshift provisioned
```json
{
    "redshift_cluster_id": "<your redshift cluster identifier>",
    "redshift_database": "<your redshift database name>",
    "redshift_user": "<your redshift database user>",
    "redshift_iam_role": "<your redshift IAM role with correct authorization and access>",
    "run_type": "<synchronous OR asynchronous>"
}
```
### Redshift serverless

Rename the file "main_sl.go" to "main.go" and use it as the main file.

```json
{
    "redshift_workgroup_name": "<your redshift serverless workgroup name>",
    "redshift_database": "<your redshift database name>",
    "redshift_iam_role": "<your redshift IAM role with correct authorization and access>",
    "run_type": "<synchronous OR asynchronous>"
}
```

Initiate your RedshiftDataAPIServiceAPI client. Additional information can be found [here](https://docs.aws.amazon.com/sdk-for-go/api/service/redshiftdataapiservice/).

```Go 
// Declare redshiftclient client
var redshiftclient redshiftdataapiserviceiface.RedshiftDataAPIServiceAPI
// Other code
// Initialize the redshift client
redshiftclient = redshiftdataapiservice.New(sess)
// Other code
```

Setup the SQL statements you’re going to execute. We’re going to do CREATE, COPY, UPDATE, DELETE, SELECT on our Redshift Cluster. Additional SQL commands can be found [here](https://docs.aws.amazon.com/redshift/latest/dg/c_SQL_commands.html). 

```Go
sql_statements.Set("SELECT", "SELECT r_regionkey, r_name FROM public.region;");
```

Use `ExecuteStatement()` to access the Redshift Data API. The documentation can be found [here](https://docs.aws.amazon.com/sdk-for-go/api/service/redshiftdataapiservice/#RedshiftDataAPIService.ExecuteStatement).
You can monitor events from your Redshift Data API in Amazon EventBridge. Data API events are sent when the ExecuteStatement API operation sets the WithEvent option to true. The documentation can be found [here](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api-monitoring-events.html).

You can leverage AWS Secrets Manager to enable access to your Amazon Redshift database. This parameter is required when authenticating. 

The documentation for `withEvent` and `SecretArn` parameter for your ExecuteStatement can be found [here](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_ExecuteStatement.html). 


```Go
// Calling Redshift Data API with ExecuteStatement()      
execstmt_req, execstmt_err:= redshiftclient.ExecuteStatement(&redshiftdataapiservice.ExecuteStatementInput{
    ClusterIdentifier: aws.String(redshift_cluster_id),
    DbUser: aws.String(redshift_user),
    Database: aws.String(redshift_database),
    Sql: aws.String(query),
})
```

We can set the run type to be synchronous or asynchronous. Please check the general ReadMe page for more information. 

If run type is synchronous, the while loop enforces each SQL execution to be completed before running the next. 

`max_wait_cycles` is set to 20 seconds as a timeout precaution. You may change this based on your requirements.


```Go
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
// Other code
```

If we run the sql statements synchronously, some statements might return results that we’d want to see. 
Add the following code into the while loop when a SQL query is finished. 

```Go
if *descstmt_req.HasResultSet {
    getresult_req, getresult_err:= redshiftclient.GetStatementResult(&redshiftdataapiservice.GetStatementResultInput{
        Id: execstmt_req.Id,
    }) 

    if getresult_err != nil{
        // logs error and exists 
        log.Fatal(getresult_err)
        }

    log.Print(getresult_req.Records) 
}
```

Please review the Go file for a holistic point of view.

## Frequently Asked Questions (FAQ)

1. Download Go packages locally to your desktop, use `go get github.com/aws/aws-lambda-go/lambda`
If above command fails then run `GOPROXY=direct go get -v github.com/aws/aws-lambda-go/lambda`

2. Go Build command, use `GOOS=linux GOARCH=amd64 go build -o main`
If above command fails with `xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun`, then run below command.
`xcode-select --install` and again run build command `GOOS=linux GOARCH=amd64 go build -o main`

3. Build command (Above Step 2) creates a main file in your current directory, compress to zip and upload to Lambda as zip

4. Update an existing Go package, use `go get -u package_name` command.
