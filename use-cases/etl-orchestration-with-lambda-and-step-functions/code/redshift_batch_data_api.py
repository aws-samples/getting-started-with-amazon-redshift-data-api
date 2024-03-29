import os
import sys
import json
from pathlib import Path
from pip._internal import main
# install latest version of boto3
main(['install', '-I', '-q', 'boto3', '--target', '/tmp/','--no-cache-dir', '--disable-pip-version-check'])
sys.path.insert(0, '/tmp/')   
import boto3

redshift_client = boto3.client('redshift-data') 
s3_client  = boto3.client('s3')

def get_sql_script_from_s3(script_s3_path):
    bucket, key = script_s3_path.replace("s3://", "").split("/", 1)
    obj = s3_client.get_object(Bucket=bucket, Key=key)
    return obj['Body'].read().decode('utf-8')
    
def split_sql_statement(script_s3_path, job_run_date):
    script = get_sql_script_from_s3(script_s3_path).format(job_run_date=job_run_date)
    
    sql_statements = list(filter(None, script.split(';')))
    return sql_statements

def run_batch_sql(redshift_config, sql_statements, statement_name):
    # execute the input SQL statement in the specified Amazon Redshift cluster
    api_response = redshift_client.batch_execute_statement(ClusterIdentifier=redshift_config["redshift_cluster_id"]
                                                          ,Database=redshift_config["redshift_database"]
                                                          ,DbUser=redshift_config["redshift_user"]
                                                          ,Sqls=sql_statements
                                                          ,StatementName=statement_name)

    # return the sql_batch_id (a universally unique identifier generated by Amazon Redshift Data API)
    sql_batch_id = api_response["Id"]
    return sql_batch_id
    
def get_sql_status(sql_id):
    desc = redshift_client.describe_statement(Id=sql_id)
    status = desc["Status"]

    if status == "FAILED":
        raise Exception('SQL query failed:' + sql_id + ": " + desc["Error"])
    return status.strip('"')         

def handler(event, context):
    # action to be taken by the lambda function. 
    # Allowed values: [setup_sales_data_pipeline, run_sales_data_pipeline, get_sql_status"]
    action = event['Input'].get('action')
    
    try:
        if action in ('setup_sales_data_pipeline','run_sales_data_pipeline'):
            redshift_config = {}
            
            # Get Database Credentials
            # cluster identifier for the Amazon Redshift cluster
            redshift_config["redshift_cluster_id"] = os.getenv('redshift_cluster_identifier')
            # database name for the Amazon Redshift cluster
            redshift_config["redshift_database"] = os.getenv('redshift_database_name')
            # database user in the Amazon Redshift cluster with access to execute relevant SQL queries
            redshift_config["redshift_user"] = os.getenv('redshift_database_user')
            
            # Get details to run the script
            job_run_date = os.getenv('job_run_date')
            etl_script_s3_path = event['Input'].get('etl_script_s3_path')
            sql_statements = split_sql_statement(etl_script_s3_path, job_run_date)
            statement_name = Path(etl_script_s3_path).name
            
            # execute the input SQL statement in the specified Amazon Redshift cluster
            sql_batch_id = run_batch_sql(redshift_config, sql_statements, statement_name)
            api_response = {'sql_batch_id': sql_batch_id}
        elif action == "get_sql_status":
            # sql_batch_id to input for action get_sql_status
            sql_batch_id = event['Input'].get('sql_batch_id')            
            # get status of a previously executed data api call
            api_status = get_sql_status(sql_batch_id)
            
            api_response = {'status': api_status}
        else:
            raise ValueError("Invalid Action: " + action)
    except NameError as error:
        raise NameError(error)
    except Exception as exception:
        error_message = "Encountered exeption on:" + action + ":" + str(exception)
        raise Exception(error_message)          
    return api_response