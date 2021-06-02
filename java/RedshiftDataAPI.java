package example;

import java.util.LinkedHashMap;
import java.util.Map;

import java.util.concurrent.TimeUnit;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.redshiftdataapi.AWSRedshiftDataAPI;
import com.amazonaws.services.redshiftdataapi.AWSRedshiftDataAPIClient;
import com.amazonaws.services.redshiftdataapi.model.DescribeStatementRequest;
import com.amazonaws.services.redshiftdataapi.model.DescribeStatementResult;
import com.amazonaws.services.redshiftdataapi.model.ExecuteStatementRequest;
import com.amazonaws.services.redshiftdataapi.model.ExecuteStatementResult;
import com.amazonaws.services.redshiftdataapi.model.GetStatementResultRequest;
import com.amazonaws.services.redshiftdataapi.model.GetStatementResultResult;
import com.amazonaws.services.redshiftdataapi.model.AWSRedshiftDataAPIException;

public class RedshiftDataAPI implements RequestHandler<Map<String, String>, String> {

    private static final int MAX_WAIT_CYCLES = 20;

    public String handleRequest(Map<String, String> event, Context context) {
        LambdaLogger logger = context.getLogger();
        // Cluster identifier for the Amazon Redshift cluster
        String redshiftClusterId = event.get("redshift_cluster_id");
        // Database name for the Amazon Redshift cluster
        String redshiftDatabaseName = event.get("redshift_database");
        // Database user in the Amazon Redshift cluster with access to execute relevant
        // SQL queries
        String redshiftUser = event.get("redshift_user");
        // IAM Role of Amazon Redshift cluster having access to S3
        String redshiftIamRole = event.get("redshift_iam_role");
        // run_type can be either asynchronous or synchronous; try tweaking based on
        // your requirement
        String run_type = event.get("run_type");

        Map<String, String> sqlStatements = new LinkedHashMap<String, String>();
        Map<String, String> responses = new LinkedHashMap<String, String>();

        logger.log(event.toString() + "\n");

        if (!run_type.equals("synchronous") && !run_type.equals("asynchronous")) {
            logger.log("Invalid Event run_type. \n run_type has to be synchronous or asynchronous.");
            System.exit(1);
        }

        boolean isSynchronous = (run_type.equals("synchronous")) ? true : false;

        // Initiate AWSRedshiftDataAPI client
        AWSRedshiftDataAPI redshiftDataApiClient = AWSRedshiftDataAPIClient.builder().build();

        sqlStatements.put("CREATE", "CREATE TABLE IF NOT EXISTS public.region (\n" + "  R_REGIONKEY bigint NOT NULL,\n"
                + "  R_NAME varchar(25),\n" + "  R_COMMENT varchar(152))\n" + "diststyle all;");

        sqlStatements.put("COPY", "COPY region FROM 's3://redshift-immersionday-labs/data/region/region.tbl.lzo'\n"
                + "iam_role '" + redshiftIamRole + "' \n" + "region 'us-west-2' lzop delimiter '|' COMPUPDATE PRESET;");

        sqlStatements.put("UPDATE", "UPDATE public.region SET r_regionkey= 5 WHERE r_name ='AFRICA';");

        sqlStatements.put("DELETE", "DELETE FROM public.region where r_name = 'MIDDLE EAST';");

        sqlStatements.put("SELECT", "SELECT r_regionkey, r_name FROM public.region;");

        logger.log(String.format("Running sql queries in %s mode. \n", run_type));

        sqlStatements.forEach((command, query) -> {
            try {
                logger.log(String.format("Example of %s mode!\n", command));
                responses.put(command + " STATUS: ", executeSqlDataApi(redshiftDataApiClient, redshiftClusterId,
                        redshiftDatabaseName, redshiftUser, command, query, isSynchronous, logger));

            } catch (InterruptedException e) {

                logger.log(e.getStackTrace().toString() + "\n");
                logger.log(e.getMessage() + "\n");
                logger.log(String.format("%s has failed. \n", command));
                System.exit(1);
            }
        });

        return responses.toString();

    }

    private String executeSqlDataApi(AWSRedshiftDataAPI redshiftDataApiClient, String redshiftClusterId,
            String redshiftDatabaseName, String redshiftUser, String command, String query, boolean isSynchronous,
            LambdaLogger logger) throws InterruptedException {
        String queryStatus = "";
        int attempts = 0;
        try {

            ExecuteStatementRequest statementRequest = new ExecuteStatementRequest();
            DescribeStatementRequest describeRequest = new DescribeStatementRequest();

            statementRequest.setClusterIdentifier(redshiftClusterId);
            statementRequest.setDbUser(redshiftUser);
            statementRequest.setDatabase(redshiftDatabaseName);
            statementRequest.setSql(query);

            // Calling Redshift Data API with executeStatement()
            ExecuteStatementResult resp = redshiftDataApiClient.executeStatement(statementRequest);

            String queryId = resp.getId();
            boolean done = false;

            describeRequest.setId(queryId);

            DescribeStatementResult describeResult = redshiftDataApiClient.describeStatement(describeRequest);
            queryStatus = describeResult.getStatus();

            // Wait until query is finished or max cycles limit has been reached.
            while (done == false && isSynchronous && attempts++ < MAX_WAIT_CYCLES) {
                TimeUnit.SECONDS.sleep(1);

                describeResult = redshiftDataApiClient.describeStatement(describeRequest);
                queryStatus = describeResult.getStatus();

                if (queryStatus.equals("FAILED")) {
                    logger.log(String.format("SQL query failed, query id: %s \n Error: %s", queryId,
                            describeResult.getError().toString()));
                    System.exit(1);
                } else if (queryStatus.equals("FINISHED")) {
                    logger.log(String.format("Query status is: %s for query id: %s and command: %s\n", queryStatus,
                            queryId, command));
                    done = true;

                    // Print query response if available (typically from Select SQL statements)
                    if (describeResult.isHasResultSet()) {
                        GetStatementResultRequest statementResultRequest = new GetStatementResultRequest();
                        statementResultRequest.setId(queryId);
                        GetStatementResultResult sqlresult = redshiftDataApiClient
                                .getStatementResult(statementResultRequest);
                        logger.log(String.format("Printing response of query: %s --> %s", command,
                                sqlresult.getRecords().toString()));
                    }

                } else {
                    logger.log(String.format("Currently working... query status is: %s \n", queryStatus));
                }

            }

            if (done == false && attempts >= MAX_WAIT_CYCLES && isSynchronous) {
                logger.log(
                        "Limit for MAX_WAIT_CYCLES has been reached before the query was able to finish. We have exited out of the while-loop. You may increase the limit accordingly. \n");
                logger.log(String.format("Query status is: %s for query id: %s and command: %s\n", queryStatus, queryId,
                        command));
                System.exit(1);
            }

        } catch (AWSRedshiftDataAPIException e) {
            logger.log(e.getStackTrace().toString());
            System.exit(1);

        }
        return queryStatus;

    }

}
