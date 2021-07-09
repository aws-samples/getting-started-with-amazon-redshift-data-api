# Please input your SQL script path, redshift cluster endpoint and existing user on that cluster
SQL_SCRIPT_S3_PATH=""
REDSHIFT_CLUSTER_ENDPOINT=""
REDSHIFT_USER_NAME=""
DEFAULT_OUTPUT_LIMIT="100"

import json
import boto3
import psycopg2
import time
import pandas
from sqlalchemy import create_engine
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import as_completed
from urllib.parse import quote_plus as urlquote
import urllib

def connect_to_redshift(host,username):
    client = boto3.client('redshift')
    cluster_creds = client.get_cluster_credentials(DbUser=username,
                                                   DbName=REDSHIFT_CLUSTER_ENDPOINT.split('/')[1],
                                                   ClusterIdentifier=REDSHIFT_CLUSTER_ENDPOINT.split('.')[0])


    connection_string='postgresql://'+ urlquote(cluster_creds['DbUser']) + ':'+ urlquote(cluster_creds['DbPassword']) + '@'+ REDSHIFT_CLUSTER_ENDPOINT
    return create_engine(connection_string,pool_size=0, max_overflow=-1)

def get_json_config_from_s3(script_s3_path):
    bucket, key = script_s3_path.replace("s3://", "").split("/", 1)
    obj = boto3.client('s3').get_object(Bucket=bucket, Key=key)
    return json.loads(obj['Body'].read().decode('utf-8'))


def get_concurrency_scripts_from_s3(cluster_identifier,number_of_parallel_sessions):

    bucket, key = SQL_SCRIPT_S3_PATH.replace("s3://", "").split("/", 1)
    obj = boto3.client('s3').get_object(Bucket=bucket, Key=key)
    scripts = obj['Body'].read().decode('utf-8')
    # scripts = scripts.format(redshift_iam_role=redshift_iam_role, bucket_name=bucket_name,cluster_identifier=cluster_identifier)
    split_scripts = scripts.split(';')[:-1]
    if len(split_scripts) < number_of_parallel_sessions:
        while len(split_scripts) < number_of_parallel_sessions:
            split_scripts.extend(split_scripts)
    return split_scripts


def get_sql(engine, script, sequence_number):
    df = None
    sql = "set enable_result_cache_for_session to false;" + script[sequence_number];
    df = pandas.read_sql(sql, engine)
    return df


def run_concurrency_test(number_of_parallel_sessions):
    engine=connect_to_redshift(REDSHIFT_CLUSTER_ENDPOINT,REDSHIFT_USER_NAME)
    script = get_concurrency_scripts_from_s3(REDSHIFT_CLUSTER_ENDPOINT.split('.')[0], number_of_parallel_sessions)
    start_time = time.time()
    try:
        with ThreadPoolExecutor(max_workers=number_of_parallel_sessions) as executor:
            futures = []
            for sequence_number in range(number_of_parallel_sessions):
                futures.append(executor.submit(
                    get_sql, engine, script, sequence_number))
            for future in as_completed(futures):
                rs = future.result()

    except Exception as e:
        raise e
    elapsed_time_in_secs = (time.time() - start_time)
    print("--- %s seconds ---" % elapsed_time_in_secs)
    return elapsed_time_in_secs

################################################################################################################
# Please input the desired parallel threads below. By default, it runs five times with 1, 20, 40, 50 threads
# Average of 5 runs of concurrency testing is taken as the final outcome.
################################################################################################################
for number_of_parallel_sessions in [1,20]:
    print("running %s parallel threads .." % number_of_parallel_sessions)
    tm = []
    # try 5 times for each thread count
    for j in range(0, 5):
        tm.append(run_concurrency_test(number_of_parallel_sessions))
    avg = sum(tm)/len(tm)
    print(f"average of five runs with {number_of_parallel_sessions} parallel sessions: {avg}")
