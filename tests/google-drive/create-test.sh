#! /bin/bash
set -e

access_token=`xmlstarlet sel -t -v "/settings/google/access-token" ../testdata.xml`
echo "using access token $access_token"
parent_id=`xmlstarlet sel -t -v "/settings/google/upload-to-id" ../testdata.xml`
echo "using parent id $parent_id"

url=`../../google-drive/create.sh $access_token $parent_id create-test.sh 'create test shell script'`
if [ -z "$url" ] ; then
    echo "no url returned"
    exit 1
fi
echo "uploading via $url"

json_result=`../../google-drive/upload.sh "$url" "access_token" "create-test.sh"`
if [ -z "$json_result" ] ; then
    echo "no json result file returned"
    exit 1
fi
echo "json results saved in $json_result"
