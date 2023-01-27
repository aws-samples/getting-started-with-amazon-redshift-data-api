import time
import traceback
import boto3
import logging
from collections import OrderedDict

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    # input parameters passed from the caller event
    # Amazon Redshift Serverless Workgroupname
    redshift_workgroup_name=event['redshift_workgroup_name']
    # database name for the Amazon Redshift serverless instance
    redshift_database_name = event['redshift_database']
    # IAM Role of Amazon Redshift sererless instance having access to S3
    redshift_iam_role = event['redshift_iam_role']
    # run_type can be either asynchronous or synchronous; try tweaking based on your requirement
    run_type = event['run_type']

    sql_statements = OrderedDict()
    res = OrderedDict()

    if run_type != "synchronous" and run_type != "asynchronous":
        raise Exception(
            "Invalid Event run_type. \n run_type has to be synchronous or asynchronous.")

    isSynchronous = True if run_type == "synchronous" else False

    # initiate redshift-data redshift_data_api_client in boto3
    redshift_data_api_client = boto3.client('redshift-data')

    sql_statements['CREATE'] = "CREATE TABLE IF NOT EXISTS public.region (" + \
        "R_REGIONKEY bigint NOT NULL," + \
        "R_NAME varchar(25)," + \
        "R_COMMENT varchar(152))" + \
        "diststyle all;"
    sql_statements['COPY'] = "COPY public.region FROM 's3://redshift-immersionday-labs/data/region/region.tbl.lzo' " + \
        "iam_role '" + redshift_iam_role + \
        "' region 'us-west-2' lzop delimiter '|' COMPUPDATE PRESET;"
    sql_statements['UPDATE'] = "UPDATE public.region set r_regionkey = 5 where r_name ='AFRICA';"
    sql_statements['DELETE'] = "DELETE From public.region where r_name = 'MIDDLE EAST';"
    sql_statements['SELECT'] = "SELECT r_regionkey,r_name from public.region;"
    logger.info("Running sql queries in {} mode!\n".format(run_type))

    try:
        for command, query in sql_statements.items():
            logging.info("Example of {} command :".format(command))
            res[command + " STATUS: "] = execute_sql_data_api(redshift_data_api_client, redshift_database_name, command, query,
                                                              redshift_workgroup_name, isSynchronous)

    except Exception as e:
        raise Exception(str(e) + "\n" + traceback.format_exc())
    return res


def execute_sql_data_api(redshift_data_api_client, redshift_database_name, command, query, redshift_workgroup_name, isSynchronous):

    MAX_WAIT_CYCLES = 20
    attempts = 0
    # Calling Redshift Data API with executeStatement()
    res = redshift_data_api_client.execute_statement(
        Database=redshift_database_name, WorkgroupName=redshift_workgroup_name, Sql=query)
    query_id = res["Id"]
    desc = redshift_data_api_client.describe_statement(Id=query_id)
    query_status = desc["Status"]
    logger.info(
        "Query status: {} .... for query-->{}".format(query_status, query))
    done = False

    # Wait until query is finished or max cycles limit has been reached.
    while not done and isSynchronous and attempts < MAX_WAIT_CYCLES:
        attempts += 1
        time.sleep(1)
        desc = redshift_data_api_client.describe_statement(Id=query_id)
        query_status = desc["Status"]

        if query_status == "FAILED":
            raise Exception('SQL query failed:' +
                            query_id + ": " + desc["Error"])

        elif query_status == "FINISHED":
            logger.info("query status is: {} for query id: {} and command: {}".format(
                query_status, query_id, command))
            done = True
            # print result if there is a result (typically from Select statement)
            if desc['HasResultSet']:
                response = redshift_data_api_client.get_statement_result(
                    Id=query_id)
                logger.info(
                    "Printing response of {} query --> {}".format(command, response['Records']))
        else:
            logger.info(
                "Current working... query status is: {} ".format(query_status))

    # Timeout Precaution
    if done == False and attempts >= MAX_WAIT_CYCLES and isSynchronous:
        logger.info("Limit for MAX_WAIT_CYCLES has been reached before the query was able to finish. We have exited out of the while-loop. You may increase the limit accordingly. \n")
        raise Exception("query status is: {} for query id: {} and command: {}".format(
            query_status, query_id, command))

    return query_status