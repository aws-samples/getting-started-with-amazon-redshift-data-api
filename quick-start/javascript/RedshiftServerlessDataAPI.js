'use strict';

const AWS = require('aws-sdk');

// If using Lambda layers, uncomment the line below to import the module
// import { RedshiftData } from "@aws-sdk/client-redshift-data";

exports.handler = async (event) => {
  const {
    // input parameters passed from the caller event
	// Amazon Redshift Serverless Workgroupname
	redshift_workgroup_name: redshiftWorkgroupName,
    // database name for the Amazon Redshift cluster
    redshift_database: redshiftDatabaseName,
    // IAM Role of Amazon Redshift cluster having access to S3
    redshift_iam_role: redshiftIAMRole,
    // run_type can be either asynchronous or synchronous; try tweaking based on your requirement
    run_type: runType
  } = event;

  const responses = new Map();

  if (runType !== 'synchronous' && runType !== 'asynchronous') {
    throw new Error('Invalid Event run_type. \n run_type has to be synchronous or asynchronous.');
  }

  const isSynchronous = (runType === 'synchronous');

  // returns a Map(), ES6+ preserves insertion ordering
  const sqlStatements = await populateSqlStatementSet(redshiftIAMRole);

  console.log(`Running sql queries in ${runType} mode. \n`);

  // Initiate RedshiftData client
  const redshiftDataApiClient = new AWS.RedshiftData({ region: 'us-east-1' });

  // If using Lambda layers, uncomment the line below
  // const redshiftDataApiClient = new RedshiftData({ region: "us-east-1" });

  for (const [command, query] of sqlStatements.entries()) {
    console.log(`Example of ${command} mode.`);
    const res = await executeSqlDataApi(redshiftDataApiClient, redshiftWorkgroupName, redshiftDatabaseName, command, query, isSynchronous);

    responses.set(`${command} STATUS: `, res);
  }

  return {
    statusCode: 200,
    body: [...responses.entries()]
  };
};

const executeSqlDataApi = async (redshiftDataApiClient, redshiftWorkgroupName, redshiftDatabaseName, command, query, isSynchronous) => {
  let queryId = '';

  const executeStatementInput = {
    WorkgroupName: redshiftWorkgroupName,
    Database: redshiftDatabaseName,
    Sql: query
  };

  // Calling Redshift Data API with executeStatement()
  await redshiftDataApiClient.executeStatement(executeStatementInput).promise()
    .then((response) => {
      queryId = response.Id;
    })
    .catch((error) => {
      console.log('ExecuteStatement has failed.');
      throw new Error(error);
    });

  let { Status: queryStatus } = await getDescribeStatement(redshiftDataApiClient, queryId);

  console.log(`Executed command: ${command} | Query Status: ${queryStatus} | QueryId: ${queryId}`);

  if (isSynchronous) {
    queryStatus = await executeSynchronousWait(redshiftDataApiClient, queryStatus, queryId, command);
  }

  return queryStatus;
};

const executeSynchronousWait = async (redshiftDataApiClient, queryStatus, queryId, command) => {
  let attempts = 0;
  const MAX_WAIT_CYCLES = 20;
  let describeStatementInfo = {};

  // Wait until query is finished or max cycles limit has been reached.
  while (attempts < MAX_WAIT_CYCLES) {
    attempts++;
    await sleep(1);

    ({ Status: queryStatus, ...describeStatementInfo } = await getDescribeStatement(redshiftDataApiClient, queryId));

    if (queryStatus === 'FAILED') {
      throw new Error(`SQL query failed: ${queryId}: \n Error: ${describeStatementInfo.Error}`);
    } else if (queryStatus === 'FINISHED') {
      console.log(`Query status is: ${queryStatus} for query id: ${queryId} and command: ${command}`);

      // Print query response if available (typically from Select SQL statements)
      if (describeStatementInfo.HasResultSet) {
        await redshiftDataApiClient.getStatementResult({ Id: queryId }).promise()
          .then((statementResult) => {
            console.log(`Printing response for query: ${command} --> ${JSON.stringify(statementResult.Records)}`);
          })
          .catch((error) => {
            console.log('GetStatementResult has failed.');
            throw new Error(error);
          });
      }

      break;
    } else {
      console.log(`Currently working... query status is ${queryStatus}`);
    }

    if (attempts >= MAX_WAIT_CYCLES) {
      throw new Error(`Limit for MAX_WAIT_CYCLES has been reached before the query was able to finish. We have exited out of the while-loop. You may increase the limit accordingly. \n Query status is: %s for query id: ${queryId} and command: ${command}`);
    }
  }
  return queryStatus;
};

const getDescribeStatement = async (redshiftDataApiClient, queryId) => redshiftDataApiClient
  .describeStatement({ Id: queryId })
  .promise()
  .then(response => {
    return response;
  })
  .catch((error) => {
    console.log('DescribeStatement has failed.');
    throw new Error(error);
  });

const populateSqlStatementSet = async (redshiftIAMRole) => {
  const sqlStatements = new Map();
  sqlStatements.set('CREATE', 'CREATE TABLE IF NOT EXISTS public.region (\n' + '  R_REGIONKEY bigint NOT NULL,\n' +
                                '  R_NAME varchar(25),\n' + '  R_COMMENT varchar(152))\n' + 'diststyle all;');

  sqlStatements.set('COPY', "COPY region FROM 's3://redshift-immersionday-labs/data/region/region.tbl.lzo'\n" +
                            "iam_role '" + redshiftIAMRole + "' \n" + "region 'us-west-2' lzop delimiter '|' COMPUPDATE PRESET;");

  sqlStatements.set('UPDATE', "UPDATE public.region SET r_regionkey= 5 WHERE r_name ='AFRICA';");

  sqlStatements.set('DELETE', "DELETE FROM public.region where r_name = 'MIDDLE EAST';");

  sqlStatements.set('SELECT', 'SELECT r_regionkey, r_name FROM public.region;');
  return sqlStatements;
};

const sleep = (seconds) => {
  return new Promise(resolve => setTimeout(resolve, seconds * 1000));
};
