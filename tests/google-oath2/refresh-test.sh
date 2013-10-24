#! /bin/bash
set -e

client_id=`xmlstarlet sel -t -v "/settings/google/client-id" ../testdata.xml`
client_secret=`xmlstarlet sel -t -v "/settings/google/client-secret" ../testdata.xml`
refresh_token=`xmlstarlet sel -t -v "/settings/google/refresh-token" ../testdata.xml`

echo "refresh access token:"
token=`../../google-oath2/refresh.sh $client_id $client_secret $refresh_token`
echo $token

echo "token info:"
info=`../../google-oath2/token-info.sh $token`
tinfo=(${info//\n/ })
echo $info
echo "0="${tinfo[0]}
echo "1="${tinfo[1]}
