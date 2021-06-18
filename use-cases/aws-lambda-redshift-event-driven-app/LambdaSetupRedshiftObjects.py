import json
import boto3
import cfnresponse
import logging

logging.basicConfig()
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def handler(event, context):
  logger.info(json.dumps(event))
  lambda_arn = event['ResourceProperties']['lambda_arn']
  redshift_cluster_id = event['ResourceProperties']['redshift_cluster_id']
  redshift_database = event['ResourceProperties']['redshift_database']
  redshift_user = event['ResourceProperties']['redshift_user']
  redshift_cluster_iam_role = event['ResourceProperties']['redshift_cluster_iam_role']
  sns_topic_arn = event['ResourceProperties']['sns_topic_arn']

  if event['RequestType'] == 'Delete':
    sql_text = '''
            DROP PROCEDURE execute_elt_process();
            DROP MATERIALIZED VIEW IF EXISTS  nyc_yellow_taxi_volume_analysis;
            DROP TABLE IF EXISTS nyc_yellow_taxi;
            '''
    response = invoke_redshift_data_api_lambda(lambda_arn, redshift_cluster_id, redshift_database, redshift_user, sql_text, sns_topic_arn)
    logger.info(response)
    cfnresponse.send(event, context, cfnresponse.SUCCESS, {'Data': 'Delete complete'})
  else:
    sql_text = '''
            CREATE TABLE IF NOT EXISTS nyc_yellow_taxi
            (pickup_date        DATE
            , pickup_datetime  TIMESTAMP
            , dropoff_datetime TIMESTAMP
            , ratecode         SMALLINT
            , passenger_count  SMALLINT
            , trip_distance    FLOAT4
            , fare_amount      FLOAT4
            , total_amount     FLOAT4
            , payment_type     SMALLINT
            , vendorid         VARCHAR(20))
            SORTKEY(pickup_date);

            DROP MATERIALIZED VIEW IF EXISTS  nyc_yellow_taxi_volume_analysis;

            CREATE MATERIALIZED VIEW nyc_yellow_taxi_volume_analysis
            AS
            SELECT
              DATE_TRUNC('mon',pickup_date) pickup_month
            , ROUND(AVG(trip_distance),2) avg_distance
            , ROUND(AVG(fare_amount),2) avg_fare
            , COUNT(1) total_trips
            , SUM(trip_distance) total_distance_per_month
            , SUM(fare_amount) total_fare_per_month
            FROM nyc_yellow_taxi
            GROUP BY 1;

            CREATE OR REPLACE PROCEDURE execute_elt_process()
            AS $$
            BEGIN
              truncate table nyc_yellow_taxi;
              COPY nyc_yellow_taxi FROM 's3://event-driven-app-with-lambda-redshift/nyc_yellow_taxi_raw/'
              IAM_ROLE '{}'
              region 'us-west-2' delimiter '|';
              REFRESH MATERIALIZED VIEW nyc_yellow_taxi_volume_analysis;
            END;
            $$ LANGUAGE plpgsql;
            '''
    sql_text = sql_text.format(redshift_cluster_iam_role)
    response = invoke_redshift_data_api_lambda(lambda_arn, redshift_cluster_id, redshift_database, redshift_user, sql_text, sns_topic_arn)
    logger.info(response)
    cfnresponse.send(event, context, cfnresponse.SUCCESS, {'Data': 'Create complete'})

def invoke_redshift_data_api_lambda(lambda_arn, redshift_cluster_id, redshift_database, redshift_user, sql_text, sns_topic_arn):
    client = boto3.client('lambda')

    lambda_payload = {
      "Input": {
          "redshift_cluster_id": redshift_cluster_id,
          "redshift_database": redshift_database,
          "redshift_user": redshift_user,
          "action": "execute_sql",
          "sql_text": sql_text,
          "sns_topic_arn": sns_topic_arn
      }
    }
    response = client.invoke(
        FunctionName=lambda_arn,
        InvocationType='Event',
        Payload=json.dumps(lambda_payload)
    )
    return response
