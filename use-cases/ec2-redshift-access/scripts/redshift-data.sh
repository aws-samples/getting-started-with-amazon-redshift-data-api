set -e
REDSHIFT_CLUSTER_ENDPOINT=""
REDSHIFT_USER_NAME=""
sql=$1

splitByDot=(${REDSHIFT_CLUSTER_ENDPOINT//./ })
cluster_identifier=${splitByDot[0]}
splitBySlash=(${REDSHIFT_CLUSTER_ENDPOINT//// })
database=${splitBySlash[1]}
COUNTER=100
# echo $cluster_identifier
# echo $database
# echo $sql

statement_id=$(aws redshift-data execute-statement --cluster-identifier $cluster_identifier --database $database --db-user $REDSHIFT_USER_NAME --sql "$sql"|jq -r '.Id')

for i in `seq 1 $COUNTER`
do
        sleep 1
        describe_output=$(aws redshift-data describe-statement --id $statement_id)
        status=$(jq -r '.Status' <<< $describe_output)
        if [ $status = "FAILED" ]; then
          jq -r '.Error' <<< $describe_output
          exit 1
        elif [ $status = "FINISHED" ]; then
          if [ $(jq -r '.HasResultSet' <<< $describe_output) = "true" ]; then
            aws redshift-data get-statement-result --id $statement_id --output yaml
          else
            echo "statement completed"
          fi
          break
        fi
done
