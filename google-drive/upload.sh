set -e

upload_url=$1
access_token=$2
file=$3

curl $upload_url \
    -X PUT \
    -H "Authorization: Bearer $access_token" \
    --data-binary @$file \
    --progress-bar \
    --output $file.json
echo "$file.json"
