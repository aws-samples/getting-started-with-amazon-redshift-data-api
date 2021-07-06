
const AWS = require('aws-sdk');

// If using Lambda layers, uncomment the line below to import the module
// import { RedshiftData } from "@aws-sdk/client-redshift-data";

interface ExecuteStatementInput {
  ClusterIdentifier: string,
  Database: string,
  DbUser: string,
  Sql: string
}
interface EventInput {
  redshift_cluster_id: string,
  redshift_database: string,
  redshift_user: string,
  redshift_iam_role: string,
  run_type: string,
}

interface ExecuteStatementResult {
  ClusterIdentifier: undefined | string,
  CreatedAt: Date,
  Database: undefined | string,
  DbUser: undefined | string,
  Id: undefined | string,
  SecretArn: undefined | string
}

interface DescribeStatementResult {
  ClusterIdentifier: undefined | string,
  CreatedAt: Date,
  Database: undefined | string,
  DbUser: undefined | string,
  Duration: undefined | number,
  Error: undefined | string,
  HasResultSet: undefined | false | true,
  Id: string | undefined,
  QueryString: undefined | string,
  RedshiftPid: undefined | number,
  RedshiftQueryId: undefined | number,
  ResultRows: undefined | number,
  ResultSize: undefined | number,
  SecretArn: undefined | string,
  Status: StatusString | string,
  UpdatedAt: Date
}

interface StatusString{
  ABORTED: string,
  ALL: string,
  FAILED: string,
  FINISHED: string,
  PICKED: string,
  STARTED: string,
  SUBMITTED: string
}

interface GetStatementResult{
  //More information on Records: https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-data/interfaces/getstatementresultcommandoutput.html
  Records: [][] | undefined,
  NextToken: undefined | string,
  TotalNumRows: undefined | number
  //ColumnMetadata: ColumnMetadata[]: https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-data/modules/columnmetadata.html
}

interface LambdaHandlerResponse {
  statusCode: number,
  body: [string, string | StatusString][]
}

export const handler = async (event: EventInput): Promise<LambdaHandlerResponse> => {
  const {
    // input parameters passed from the caller event
    // cluster identifier for the Amazon Redshift cluster
    redshift_cluster_id: redshiftClusterId,
    // database name for the Amazon Redshift cluster
    redshift_database: redshiftDatabaseName,
    // database user in the Amazon Redshift cluster with access to execute relevant SQL queries
    redshift_user: redshiftUser,
    // IAM Role of Amazon Redshift cluster having access to S3
    redshift_iam_role: redshiftIAMRole,
    // run_type can be either asynchronous or synchronous; try tweaking based on your requirement
    run_type: runType,
  } = event;

  const responses: Map<string, StatusString | string>= new Map();

  if (runType !== 'synchronous' && runType !== 'asynchronous') {
    throw new Error('Invalid Event run_type. \n run_type has to be synchronous or asynchronous.');
  }

  const isSynchronous: boolean = (runType === 'synchronous');

  // returns a Map(), ES6+ preserves insertion ordering
  const sqlStatements: Map<string, string> = populateSqlStatementSet(redshiftIAMRole);

  console.log(`Running sql queries in ${runType} mode. \n`);

  // Initiate RedshiftData client
  const redshiftDataApiClient: AWS.RedshiftData = new AWS.RedshiftData({ region: 'us-east-1' });

  // If using Lambda layers, uncomment the line below
  // const redshiftDataApiClient: RedshiftData = new RedshiftData({ region: "us-east-1" });

  for (const [command, query] of sqlStatements) {
    console.log(`Example of ${command} mode.`);
    const res: StatusString | string = await executeSqlDataApi(redshiftDataApiClient, redshiftClusterId, redshiftDatabaseName, redshiftUser, command, query, isSynchronous);

    responses.set(`${command} STATUS: `, res);
  }

  return {
    statusCode: 200,
    body: [...responses]
  };
};




const executeSqlDataApi = async (redshiftDataApiClient: AWS.RedshiftData, redshiftClusterId: string, redshiftDatabaseName: string, redshiftUser: string, command: string, query: string, isSynchronous: boolean) => {
  let queryId: string | undefined = '';

  
  const input: ExecuteStatementInput = {
    ClusterIdentifier: redshiftClusterId,
    Database: redshiftDatabaseName,
    DbUser: redshiftUser,
    Sql: query
  };

  // Calling Redshift Data API with executeStatement()
  await redshiftDataApiClient.executeStatement(input).promise()
    .then((response: ExecuteStatementResult) => {
      ({Id: queryId} = response)
    })
    .catch((error: Error) => {
      console.log('ExecuteStatement has failed.');
      throw new Error(error.message);
    });

  let { Status: queryStatus } : {Status: StatusString | string } = await getDescribeStatement(redshiftDataApiClient, queryId);

  console.log(`Executed command: ${command} | Query Status: ${queryStatus} | QueryId: ${queryId}`);

  if (isSynchronous) {
    queryStatus = await executeSynchronousWait(redshiftDataApiClient, queryStatus, queryId, command);
  }

  return queryStatus;
};

const executeSynchronousWait = async (redshiftDataApiClient: AWS.RedshiftData, queryStatus: StatusString | string, queryId: string, command: string): Promise<StatusString | string> => {
  let attempts = 0;
  const MAX_WAIT_CYCLES = 20;

  // Wait until query is finished or max cycles limit has been reached.
  while (attempts < MAX_WAIT_CYCLES) {
    attempts++;
    await sleep(1);

    const describeStatementResult: DescribeStatementResult = await getDescribeStatement(redshiftDataApiClient, queryId);
    const {Error: descStatError, HasResultSet: descStateHasResultSet} = describeStatementResult;
    ({Status: queryStatus} = describeStatementResult)

    if (queryStatus === 'FAILED') {
      throw new Error(`SQL query failed: ${queryId}: \n Error: ${descStatError}`);
    } else if (queryStatus === 'FINISHED') {
      console.log(`Query status is: ${queryStatus} for query id: ${queryId} and command: ${command}`);

      // Print query response if available (typically from Select SQL statements)
      if (descStateHasResultSet) {
        await redshiftDataApiClient.getStatementResult({ Id: queryId }).promise()
          .then((statementResult: GetStatementResult) => {
            console.log(`Printing response for query: ${command} --> ${JSON.stringify(statementResult.Records)}`);
          })
          .catch((error: Error) => {
            console.log('GetStatementResult has failed.');
            throw new Error(error.message);
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

const getDescribeStatement = async (redshiftDataApiClient: AWS.RedshiftData, queryId: string): Promise<DescribeStatementResult> => redshiftDataApiClient
  .describeStatement({ Id: queryId })
  .promise()
  .then((response: DescribeStatementResult) => {
    return response;
  })
  .catch((error: Error) => {
    console.log('DescribeStatement has failed.');
    throw new Error(error.message);
  });

const populateSqlStatementSet = (redshiftIAMRole: string): Map<string, string> => {
  const sqlStatements: Map<string, string> = new Map();
  sqlStatements.set('CREATE', 'CREATE TABLE IF NOT EXISTS public.region (\n' + '  R_REGIONKEY bigint NOT NULL,\n' +
                                '  R_NAME varchar(25),\n' + '  R_COMMENT varchar(152))\n' + 'diststyle all;');

  sqlStatements.set('COPY', "COPY region FROM 's3://redshift-immersionday-labs/data/region/region.tbl.lzo'\n" +
                            "iam_role '" + redshiftIAMRole + "' \n" + "region 'us-west-2' lzop delimiter '|' COMPUPDATE PRESET;");

  sqlStatements.set('UPDATE', "UPDATE public.region SET r_regionkey= 5 WHERE r_name ='AFRICA';");

  sqlStatements.set('DELETE', "DELETE FROM public.region where r_name = 'MIDDLE EAST';");

  sqlStatements.set('SELECT', 'SELECT r_regionkey, r_name FROM public.region;');
  return sqlStatements;
};

const sleep = (seconds: number) => {
  return new Promise(resolve => setTimeout(resolve, seconds * 1000));
};
