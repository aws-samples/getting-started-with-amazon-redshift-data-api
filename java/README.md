# Java

The sample Java code given is leveraging AWS SDK version 1.x for Java. For more information on the AWSRedshiftDataAPIClient class, please check out the [documentation](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/redshiftdataapi/AWSRedshiftDataAPIClient.html).

If you are using AWS SDK version 2.x for Java, please checkout this [documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/redshiftdata/RedshiftDataClient.html) on leveraging RedshiftDataClient. 

## Java Preparation

Although this tutorial is aimed for you to better handle Amazon Redshift Data API, here are the instructions to deploy to a Java runtime lambda function using Eclipse. 

1. Creating a deployment package using Eclipse and Maven: [Link](https://docs.amazonaws.cn/en_us/lambda/latest/dg/java-package-eclipse.html)
2. Understand what an AWS Lambda function handler is: [Link](https://docs.aws.amazon.com/lambda/latest/dg/java-handler.html)
3. After creating your “hello-world” deployment package with the function handler, upload the .jar or .zip file to Lambda to test it out. 
4. Make sure to configure your Lambda setting's handler to match the Java file name.

## Pre-requisites

* Lambda function with Java 11 (Corretto) runtime. 
* The default Lambda function timeout is set to 3 seconds. Depending on your style of execution, you may have to increase this parameter.
* For this tutorial, we’ll be setting the Lambda Handler as `example.RedshiftDataAPI`
* IAM Role attached to your Redshift cluster having access to S3
* IAM Role attached to your Lambda function having access to `AmazonRedshiftDataFullAccess` role


## Walk-through

The AWS Lambda event handler JSON object should be this structure. Replace the values for placeholder according to your redshift cluster and IAM Role configuration. 

```json
{
    "redshift_cluster_id": "<your redshift cluster identifier>",
    "redshift_database": "<your redshift database name>",
    "redshift_user": "<your redshift database user>",
    "redshift_iam_role": "<your redshift IAM role with correct authorization and access>",
    "run_type": "<synchronous OR asynchronous>"
}
```


Initiate your AWSRedshiftDataAPI client. Additional information can be found [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/redshiftdataapi/AWSRedshiftDataAPIClient.html).

```java 
AWSRedshiftDataAPI redshiftDataApiClient = AWSRedshiftDataAPIClient.builder().build();
```

Setup the SQL statements you’re going to execute. We’re going to do CREATE, COPY, UPDATE, DELETE, SELECT on our Redshift Cluster. Additional SQL commands can be found [here](https://docs.aws.amazon.com/redshift/latest/dg/c_SQL_commands.html). 

```java
sqlStatements.put("SELECT", "SELECT r_regionkey, r_name FROM public.region;");
```

Use `executeStatement()` to access the Redshift Data API. The documentation can be found [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/redshiftdataapi/AWSRedshiftDataAPIClient.html#executeStatement-com.amazonaws.services.redshiftdataapi.model.ExecuteStatementRequest-). 

You can monitor events from your Redshift Data API in Amazon EventBridge. Data API events are sent when the ExecuteStatement API operation sets the WithEvent option to true. The documentation can be found [here](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api-monitoring-events.html).

You can leverage AWS Secrets Manager to enable access to your Amazon Redshift database. This parameter is required when authenticating. 

The documentation for `withEvent` and `SecretArn` parameter for your ExecuteStatement can be found [here](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_ExecuteStatement.html). 


```java
ExecuteStatementRequest statementRequest = new ExecuteStatementRequest();
statementRequest.setClusterIdentifier(redshiftClusterId);
statementRequest.setDbUser(redshiftUser);
statementRequest.setDatabase(redshiftDatabaseName);
statementRequest.setSql(query);
ExecuteStatementResult resp = redshiftDataApiClient.executeStatement(statementRequest);
```

We can set the run type to be synchronous or asynchronous. Please check the general ReadMe page for more information. 

If run type is synchronous, the while loop enforces each SQL execution to be completed before running the next. 

`MAX_WAIT_CYCLES` is set to 20 seconds as a timeout precaution. You may change this based on your requirements.


```java
int attempts = 0;
// Other code
while (done == false && isSynchronous && attempts++ < MAX_WAIT_CYCLES) {
    TimeUnit.SECONDS.sleep(1);
    describeResult = redshiftDataApiClient.describeStatement(describeRequest);
    queryStatus = describeResult.getStatus(); 
    // Other Code
    if (queryStatus.equals("FINISHED")) {
        logger.log(String.format("Query status is: %s for query id: %s and command: %s\n", queryStatus,
                            queryId, command));
        done = true;
        // Other code
    }
    // Other code
}
```

If we run the sql statements synchronously, some statements might return results that we’d want to see. 
Add the following code into the while loop when a SQL query is finished. 

```java
if (describeResult.isHasResultSet()) {
    GetStatementResultRequest statementResultRequest = new GetStatementResultRequest();
    statementResultRequest.setId(queryId);
    GetStatementResultResult sqlresult = redshiftDataApiClient
            .getStatementResult(statementResultRequest);
    logger.log(String.format("Printing response of query: %s --> %s", command,
            sqlresult.getRecords().toString()));
}
```

Please review the Java file for a holistic point of view. 

