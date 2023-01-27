# Python

## Pre-requisites:

* Lambda function with Python 3.8 runtime. 
* The default Lambda function timeout is set to 3 seconds. Depending on your style of execution, you may have to increase this parameter.
* For this tutorial, we’ll be setting the Lambda Handler as `lambda_function.lambda_handler`
* IAM Role attached to your Redshift cluster having access to S3
* IAM Role attached to your Lambda function having access to `AmazonRedshiftDataFullAccess` role
* For Redshift Serverless latest version of python boto3 library is needed, refer to [this](https://aws.amazon.com/premiumsupport/knowledge-center/lambda-python-runtime-errors/)  article to create a Lambda layer that uses the latest Boto 3 version.
    

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
```json
{
     "redshift_workgroup_name": "<your redshift serverless workgroup name>",
     "redshift_database": "<your redshift serverless database name>",
     "redshift_iam_role": "<your redshift serverless IAM role with correct authorization and access>",
     "run_type": "<synchronous OR asynchronous>"
}
```
Initiate your AWSRedshiftDataAPI client. Additional information can be found [here](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/redshift-data.html).
```python
client = boto3.client('redshift-data')
```

Setup the SQL statements you’re going to execute. We’re going to do CREATE, COPY, UPDATE, DELETE, SELECT on our Redshift Cluster. Additional SQL commands can be found [here](https://docs.aws.amazon.com/redshift/latest/dg/c_SQL_commands.html). 
```python
sql_statements['SELECT'] = "SELECT r_regionkey,r_name  from public.region;"
```

Use `executeStatement()` to access the Redshift Data API. Method documentation can be found [here](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/redshift-data.html#RedshiftDataAPIService.Client.execute_statement).

You can monitor events from your Redshift Data API in Amazon EventBridge. Data API events are sent when the ExecuteStatement API operation sets the WithEvent option to true. The documentation can be found [here](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api-monitoring-events.html)

You can leverage AWS Secrets Manager to enable access to your Amazon Redshift database. This parameter is required when authenticating.

The documentation for `withEvent` and `SecretArn` parameter for your ExecuteStatement can be found [here](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_ExecuteStatement.html).

### Redshift provisioned
```python
res = client.execute_statement(
    Database=redshift_database, DbUser=redshift_user, Sql=query, ClusterIdentifier=redshift_cluster_id)
```

### Redshift serverless
```python
res = client.execute_statement(
    Database=redshift_database, Sql=query, WorkgroupName=redshift_workgroup_name)
```

We can set the run type to be synchronous or asynchronous. Please check the general ReadMe page for more information.
If run type is synchronous, the while loop enforces each SQL execution to be completed before running the next. 

`MAX_WAIT_CYCLES` is set to 20 seconds as a timeout precaution. You may change this based on your requirements.
```python
while not done and isSynchronous and attempts < MAX_WAIT_CYCLES:
    attempts+=1		
    time.sleep(1)
    desc = redshift_data_api_client.describe_statement(Id=query_id)
    query_status = desc["Status"]
    // Other code
    if query_status == "FINISHED":
        logger.info("query status is: {} for query id: {} and command: {}".format(
            query_status, query_id, command))
        done = True
   // Other code
```

If we run the sql statements synchronously, some statements might return results that we’d want to see. 
Add the following code into the while loop when a SQL query is finished. 
```python
if desc['HasResultSet']:
    response = redshift_data_api_client.get_statement_result(
        Id=query_id)
    logger.info(
        "Printing response of {} query --> {}".format(command, response['Records']))
```

Please review the Python file for a holistic point of view.
