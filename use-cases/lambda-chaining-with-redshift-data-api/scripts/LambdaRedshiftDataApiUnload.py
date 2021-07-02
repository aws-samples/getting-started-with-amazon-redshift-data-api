import json
import time
import unicodedata
import traceback
import sys
from pip._internal import main
# install latest version of boto3
main(['install', '-I', '-q', 'boto3', '--target', '/tmp/',
      '--no-cache-dir', '--disable-pip-version-check'])
sys.path.insert(0, '/tmp/')
import boto3
  # initiate redshift-data client in boto3
client = boto3.client("redshift-data")

def handler(event, context):
        print(event)
        # input parameters passed from the caller event
        # cluster identifier for the Amazon Redshift cluster
        redshift_cluster_id = event['Input'].get('redshift_cluster_id')
        # database name for the Amazon Redshift cluster
        redshift_database = event['Input'].get('redshift_database')
        # database user in the Amazon Redshift cluster with access to run relevant SQL queries
        redshift_user = event['Input'].get('redshift_user')
        # Amazon SNS topic to be used to publish notifications to end-users
        sns_topic_arn = event['Input'].get('sns_topic_arn')
        # action to be taken by the lambda function. Allowed values: [run_sql, status_check, notify]
        action = event['Input'].get('action')
        # sql text to be run. e.g. call my_stored_procedure(input_params)
        sql_text = event['Input'].get('sql_text')
        # subject line to be used while publishing message through Amazon SNS
        subject = event['Input'].get('subject')
        # detailed body to be used while publishing message through Amazon SNS
        body = event['Input'].get('body')
        # query_id to input for action status_check
        query_id = event['Input'].get('query_id')
        try:
            if action == 'run_sql':
                # s3_bucket to unload redshift data
                s3_bucket = event['Input'].get('s3bucketname')
                redshift_iam_role = event['Input'].get('redshift_iam_role')

                # run the input SQL statement in the specified Amazon Redshift cluster
                # sql text to be run. e.g. call my_stored_procedure(input_params)
                sql_text = "unload ('select * from nyc_yellow_taxi_volume_analysis where pickup_month=''2015-12-01 00:00:00'' ')" + \
                    " to '" + s3_bucket + "'" + " iam_role '" + redshift_iam_role + "' FORMAT PARQUET " + \
                    " ALLOWOVERWRITE PARTITION BY (PICKUP_MONTH); "

                res = run_sql(client, sql_text, redshift_database,
                              redshift_user, redshift_cluster_id)
            elif action == "status_check":
                # check status of a previously run query
                res = status_check(client, query_id)
            elif action == "notify":
                # notify to end-users by publishing message in Amazon SNS service
                res = notify(sns_topic_arn, subject, body)
            else:
                raise ValueError("Invalid Action: " + action)
        except Exception as e:
            subject = "Error:" + action + ":" + str(e)
            body = traceback.format_exc()
            notify(sns_topic_arn, subject, body)
            raise
        return {'statusCode': 200, 'body': json.dumps(res)}

def run_sql(client, sql_text, redshift_database, redshift_user, redshift_cluster_id, with_event=True):
        MAX_WAIT_CYCLES = 20
        attempts = 0
        print("Executing: {}".format(sql_text))
        res = client.execute_statement(Database=redshift_database, DbUser=redshift_user, Sql=sql_text,
                                       ClusterIdentifier=redshift_cluster_id, WithEvent=with_event)
        print(res)
        query_id = res["Id"]

        while attempts < MAX_WAIT_CYCLES:
            attempts += 1
            time.sleep(1)
            status = status_check(client, query_id)
            if status in ("STARTED", "FAILED", "FINISHED"):
                print("status is: {}".format(status))
                break
        return query_id

def status_check(client, query_id):
        desc = client.describe_statement(Id=query_id)
        status = desc["Status"]
        if status == "FAILED":
            raise Exception('SQL query failed:' +
                            query_id + ": " + desc["Error"])
        return status.strip('"')

def notify(sns_topic_arn, subject, body):
        subject = (
            "".join(ch for ch in subject if unicodedata.category(ch)[0] != "C"))[0:99]
        body = str(body)
        sns_client = boto3.client('sns')
        response = sns_client.publish(
            TargetArn=sns_topic_arn,
            Message=json.dumps({'default': json.dumps("{}"),
                                'sms': subject,
                                'email': body}),
            Subject=subject,
            MessageStructure='json'
        )
        return "message sent"
