#! /bin/bash
set -e
set -o pipefail

if [ -z "$3" ] ; then
    echo "Need: access_token parent_id file [title]"
    exit 1
fi

access_token=$1
parent_id=$2
file=$3
title=$4
if [ -z "$title" ] ; then title=$file; fi
file_size=$(stat -c%s "$file")

data='{"title":"'$title'","parents":[{"id": "'$parent_id'"}]}'
echo $data 1>&2

curl https://www.googleapis.com/upload/drive/v2/files?uploadType=resumable \
    -H "Authorization: Bearer $access_token" \
    -H "Content-Type: application/json; charset=UTF-8" \
    -H "X-Upload-Content-Length: $file_size" \
    --data "$data" \
    -i \
    --progress-bar \
    | grep "Location" \
    | sed "s/Location: \(.*\)$/\1/"
