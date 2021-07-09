# input your redshift cluster endpoint and existing user on that cluster
REDSHIFT_CLUSTER_ENDPOINT=""
REDSHIFT_USER_NAME=""
SQL_SCRIPT_S3_PATH=""

import boto3
import time
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

session = boto3.session.Session()
region = session.region_name


def run_sql(sql_text):
    client = boto3.client("redshift-data")
    res = client.execute_statement(Database=REDSHIFT_CLUSTER_ENDPOINT.split('/')[1], DbUser=REDSHIFT_USER_NAME, Sql=sql_text,
                                   ClusterIdentifier=REDSHIFT_CLUSTER_ENDPOINT.split('.')[0])
    query_id = res["Id"]
    done = False
    while not done:
        time.sleep(1)
        status_description = client.describe_statement(Id=query_id)
        status = status_description["Status"]
        if status == "FAILED":
            raise Exception('SQL query failed:' + query_id + ": " + status_description["Error"])
        elif status == "FINISHED":
            if status_description['ResultSize']>0:
                results = client.get_statement_result(Id=query_id)
                column_labels = []
                for i in range(len(results["ColumnMetadata"])): column_labels.append(results["ColumnMetadata"][i]['label'])
                records = []
                for record in results.get('Records'):
                    records.append([list(rec.values())[0] for rec in record])
                df = pd.DataFrame(np.array(records), columns=column_labels)
                return df
            else:
                return query_id


def get_script_from_s3():

    bucket, key = SQL_SCRIPT_S3_PATH.replace("s3://", "").split("/", 1)
    obj = boto3.client('s3').get_object(Bucket=bucket, Key=key)
    scripts = obj['Body'].read().decode('utf-8')
    split_scripts = scripts.split(';')[:-1]
    return split_scripts


# Run script in Redshift
script = get_script_from_s3()
for sql_text in script:
    df=run_sql(sql_text);
print(df)
