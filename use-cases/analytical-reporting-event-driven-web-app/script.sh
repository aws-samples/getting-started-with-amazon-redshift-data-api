#!/bin/sh
#--installing jq
sudo yum install jq -y

#--running the cloud formation stack
aws_region="us-east-1"
aws_user_pool_name="MyUserPool"
aws_client_app_name="MyPoolClientApp"
aws cloudformation create-stack   --template-body file://cognito-setup.yaml   --stack-name CognitoSetup   --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM   --parameters     ParameterKey=UserPoolName,ParameterValue=$aws_user_pool_name     ParameterKey=UserPoolClientName,ParameterValue=$aws_client_app_name

#-- getting the output of cloud formation stack

status="start";

while [ "$status" != "CREATE_COMPLETE" ]
do
   aws cloudformation describe-stacks --stack-name CognitoSetup > output.json
   status=$(jq '.Stacks[].StackStatus' output.json | sed -e 's/^"//' -e 's/"$//')
done
aws cloudformation describe-stacks --stack-name CognitoSetup > output.json

UserPoolClientId=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="UserPoolClientId")' output.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')   
UserPoolId=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="UserPoolId")' output.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')
UserGitURL=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="UserGitURL")' output.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')
UserGitARN=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="UserGitARN")' output.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')
UserPoolARN=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="UserPoolARN")' output.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')

#--running the cloud formation stack
aws_redshift_cluster_ep="redshift-cluster-1.ceoxukbfhxkk.us-east-1.redshift.amazonaws.com:5439/dev"
aws_dbuser_name="awsuser"
aws_ddbtable_name="client_connections_a"
aws_wsep_param_name="REDSHIFT_WSS_ENDPOINT_a"
aws_rapiep_param_name="REDSHIFT_REST_API_ENDPOINT_a"
aws_ddl_script_path="s3://api-gateway-scripts/setupscript.sql"
aws_query_script_path="s3://api-gateway-scripts/queryscript.sql"

aws cloudformation create-stack   --template-body file://backend-setup.yaml   --stack-name BackendSetup   --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM CAPABILITY_IAM   --parameters     ParameterKey=RedshiftClusterEndpoint,ParameterValue=$aws_redshift_cluster_ep     ParameterKey=DbUsername,ParameterValue=$aws_dbuser_name     ParameterKey=DDBTableName,ParameterValue=$aws_ddbtable_name     ParameterKey=WebSocketEndpointSSMParameterName,ParameterValue=$aws_wsep_param_name     ParameterKey=RestApiEndpointSSMParameterName,ParameterValue=$aws_rapiep_param_name     ParameterKey=DDLScriptS3Path,ParameterValue=$aws_ddl_script_path     ParameterKey=QueryScriptS3Path,ParameterValue=$aws_query_script_path     ParameterKey=UserPoolARN,ParameterValue=$UserPoolARN

#-- getting the output of cloud formation stack

status="start";

while [ "$status" != "CREATE_COMPLETE" ]
do
   aws cloudformation describe-stacks --stack-name BackendSetup > output1.json
   status=$(jq '.Stacks[].StackStatus' output.json | sed -e 's/^"//' -e 's/"$//')
done
aws cloudformation describe-stacks --stack-name BackendSetup > output1.json

RedshiftDataApiWebSocketEndpoint=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="RedshiftDataApiWebSocketEndpoint")' output1.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')
RedshiftDataApiRestApiEndpoint=$(jq '.Stacks[].Outputs[] | select(.OutputKey=="RedshiftDataApiRestApiEndpoint")' output1.json | jq '.OutputValue' | sed -e 's/^"//' -e 's/"$//')

echo $UserPoolClientId
echo $UserPoolId
echo $UserGitURL
echo $UserGitARN
echo $UserPoolARN
echo $RedshiftDataApiWebSocketEndpoint
echo $RedshiftDataApiRestApiEndpoint

git clone $UserGitURL
cp -R Src_directory/* DemoApp 
cd DemoApp/js
search1="userPoolIdValue"
search2="userPoolClientIdValue"
search3="userRegionValue"
search4="userWebSURL"
search5="userRestURL"
sed -i "s|$search1|$UserPoolId|g" config.js
sed -i "s|$search2|$UserPoolClientId|g" config.js
sed -i "s|$search3|$aws_region|g" config.js
sed -i "s|$search4|$RedshiftDataApiWebSocketEndpoint|g" config.js
sed -i "s|$search5|$RedshiftDataApiRestApiEndpoint|g" config.js
cd ..
git add .
git commit -m 'new'
git push
cd ..
#--running the cloud formation stack
aws cloudformation create-stack   --template-body file://webapp-setup.yaml   --stack-name WebappSetup   --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM   --parameters     ParameterKey=UserGitURL,ParameterValue=$UserGitURL ParameterKey=UserGitARN,ParameterValue=$UserGitARN

echo "Task Completed"