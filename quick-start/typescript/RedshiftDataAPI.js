"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __values = (this && this.__values) || function(o) {
    var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
    if (m) return m.call(o);
    if (o && typeof o.length === "number") return {
        next: function () {
            if (o && i >= o.length) o = void 0;
            return { value: o && o[i++], done: !o };
        }
    };
    throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
};
var __read = (this && this.__read) || function (o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
};
var __spreadArray = (this && this.__spreadArray) || function (to, from) {
    for (var i = 0, il = from.length, j = to.length; i < il; i++, j++)
        to[j] = from[i];
    return to;
};
exports.__esModule = true;
exports.handler = void 0;
var AWS = require('aws-sdk');
var handler = function (event) { return __awaiter(void 0, void 0, void 0, function () {
    var redshiftClusterId, redshiftDatabaseName, redshiftUser, redshiftIAMRole, runType, responses, isSynchronous, sqlStatements, redshiftDataApiClient, sqlStatements_1, sqlStatements_1_1, _a, command, query, res, e_1_1;
    var e_1, _b;
    return __generator(this, function (_c) {
        switch (_c.label) {
            case 0:
                redshiftClusterId = event.redshift_cluster_id, redshiftDatabaseName = event.redshift_database, redshiftUser = event.redshift_user, redshiftIAMRole = event.redshift_iam_role, runType = event.run_type;
                responses = new Map();
                if (runType !== 'synchronous' && runType !== 'asynchronous') {
                    throw new Error('Invalid Event run_type. \n run_type has to be synchronous or asynchronous.');
                }
                isSynchronous = (runType === 'synchronous');
                sqlStatements = populateSqlStatementSet(redshiftIAMRole);
                console.log("Running sql queries in " + runType + " mode. \n");
                redshiftDataApiClient = new AWS.RedshiftData({ region: 'us-east-1' });
                _c.label = 1;
            case 1:
                _c.trys.push([1, 6, 7, 8]);
                sqlStatements_1 = __values(sqlStatements), sqlStatements_1_1 = sqlStatements_1.next();
                _c.label = 2;
            case 2:
                if (!!sqlStatements_1_1.done) return [3 /*break*/, 5];
                _a = __read(sqlStatements_1_1.value, 2), command = _a[0], query = _a[1];
                console.log("Example of " + command + " mode.");
                return [4 /*yield*/, executeSqlDataApi(redshiftDataApiClient, redshiftClusterId, redshiftDatabaseName, redshiftUser, command, query, isSynchronous)];
            case 3:
                res = _c.sent();
                responses.set(command + " STATUS: ", res);
                _c.label = 4;
            case 4:
                sqlStatements_1_1 = sqlStatements_1.next();
                return [3 /*break*/, 2];
            case 5: return [3 /*break*/, 8];
            case 6:
                e_1_1 = _c.sent();
                e_1 = { error: e_1_1 };
                return [3 /*break*/, 8];
            case 7:
                try {
                    if (sqlStatements_1_1 && !sqlStatements_1_1.done && (_b = sqlStatements_1["return"])) _b.call(sqlStatements_1);
                }
                finally { if (e_1) throw e_1.error; }
                return [7 /*endfinally*/];
            case 8: return [2 /*return*/, {
                    statusCode: 200,
                    body: __spreadArray([], __read(responses))
                }];
        }
    });
}); };
exports.handler = handler;
var executeSqlDataApi = function (redshiftDataApiClient, redshiftClusterId, redshiftDatabaseName, redshiftUser, command, query, isSynchronous) { return __awaiter(void 0, void 0, void 0, function () {
    var queryId, input, queryStatus;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                queryId = '';
                input = {
                    ClusterIdentifier: redshiftClusterId,
                    Database: redshiftDatabaseName,
                    DbUser: redshiftUser,
                    Sql: query
                };
                // Calling Redshift Data API with executeStatement()
                return [4 /*yield*/, redshiftDataApiClient.executeStatement(input).promise()
                        .then(function (response) {
                        (queryId = response.Id);
                    })["catch"](function (error) {
                        console.log('ExecuteStatement has failed.');
                        throw new Error(error.message);
                    })];
            case 1:
                // Calling Redshift Data API with executeStatement()
                _a.sent();
                return [4 /*yield*/, getDescribeStatement(redshiftDataApiClient, queryId)];
            case 2:
                queryStatus = (_a.sent()).Status;
                console.log("Executed command: " + command + " | Query Status: " + queryStatus + " | QueryId: " + queryId);
                if (!isSynchronous) return [3 /*break*/, 4];
                return [4 /*yield*/, executeSynchronousWait(redshiftDataApiClient, queryStatus, queryId, command)];
            case 3:
                queryStatus = _a.sent();
                _a.label = 4;
            case 4: return [2 /*return*/, queryStatus];
        }
    });
}); };
var executeSynchronousWait = function (redshiftDataApiClient, queryStatus, queryId, command) { return __awaiter(void 0, void 0, void 0, function () {
    var attempts, MAX_WAIT_CYCLES, describeStatementResult, descStatError, descStateHasResultSet;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                attempts = 0;
                MAX_WAIT_CYCLES = 20;
                _a.label = 1;
            case 1:
                if (!(attempts < MAX_WAIT_CYCLES)) return [3 /*break*/, 9];
                attempts++;
                return [4 /*yield*/, sleep(1)];
            case 2:
                _a.sent();
                return [4 /*yield*/, getDescribeStatement(redshiftDataApiClient, queryId)];
            case 3:
                describeStatementResult = _a.sent();
                descStatError = describeStatementResult.Error, descStateHasResultSet = describeStatementResult.HasResultSet;
                (queryStatus = describeStatementResult.Status);
                if (!(queryStatus === 'FAILED')) return [3 /*break*/, 4];
                throw new Error("SQL query failed: " + queryId + ": \n Error: " + descStatError);
            case 4:
                if (!(queryStatus === 'FINISHED')) return [3 /*break*/, 7];
                console.log("Query status is: " + queryStatus + " for query id: " + queryId + " and command: " + command);
                if (!descStateHasResultSet) return [3 /*break*/, 6];
                return [4 /*yield*/, redshiftDataApiClient.getStatementResult({ Id: queryId }).promise()
                        .then(function (statementResult) {
                        console.log("Printing response for query: " + command + " --> " + JSON.stringify(statementResult.Records));
                    })["catch"](function (error) {
                        console.log('GetStatementResult has failed.');
                        throw new Error(error.message);
                    })];
            case 5:
                _a.sent();
                _a.label = 6;
            case 6: return [3 /*break*/, 9];
            case 7:
                console.log("Currently working... query status is " + queryStatus);
                _a.label = 8;
            case 8:
                if (attempts >= MAX_WAIT_CYCLES) {
                    throw new Error("Limit for MAX_WAIT_CYCLES has been reached before the query was able to finish. We have exited out of the while-loop. You may increase the limit accordingly. \n Query status is: %s for query id: " + queryId + " and command: " + command);
                }
                return [3 /*break*/, 1];
            case 9: return [2 /*return*/, queryStatus];
        }
    });
}); };
var getDescribeStatement = function (redshiftDataApiClient, queryId) { return __awaiter(void 0, void 0, void 0, function () {
    return __generator(this, function (_a) {
        return [2 /*return*/, redshiftDataApiClient
                .describeStatement({ Id: queryId })
                .promise()
                .then(function (response) {
                return response;
            })["catch"](function (error) {
                console.log('DescribeStatement has failed.');
                throw new Error(error.message);
            })];
    });
}); };
var populateSqlStatementSet = function (redshiftIAMRole) {
    var sqlStatements = new Map();
    sqlStatements.set('CREATE', 'CREATE TABLE IF NOT EXISTS public.region (\n' + '  R_REGIONKEY bigint NOT NULL,\n' +
        '  R_NAME varchar(25),\n' + '  R_COMMENT varchar(152))\n' + 'diststyle all;');
    sqlStatements.set('COPY', "COPY region FROM 's3://redshift-immersionday-labs/data/region/region.tbl.lzo'\n" +
        "iam_role '" + redshiftIAMRole + "' \n" + "region 'us-west-2' lzop delimiter '|' COMPUPDATE PRESET;");
    sqlStatements.set('UPDATE', "UPDATE public.region SET r_regionkey= 5 WHERE r_name ='AFRICA';");
    sqlStatements.set('DELETE', "DELETE FROM public.region where r_name = 'MIDDLE EAST';");
    sqlStatements.set('SELECT', 'SELECT r_regionkey, r_name FROM public.region;');
    return sqlStatements;
};
var sleep = function (seconds) {
    return new Promise(function (resolve) { return setTimeout(resolve, seconds * 1000); });
};
