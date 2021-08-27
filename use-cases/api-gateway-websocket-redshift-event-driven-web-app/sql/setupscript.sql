DROP TABLE IF EXISTS nyc_yellow_taxi;
CREATE TABLE nyc_yellow_taxi(
    pickup_date      DATE
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

COPY nyc_yellow_taxi FROM 's3://event-driven-app-with-lambda-redshift/nyc_yellow_taxi_raw/' IAM_ROLE '<<your-redshift-IAM-role-with-s3-read-access>>' region 'us-west-2' delimiter '|';