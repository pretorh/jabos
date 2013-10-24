#! /bin/bash
set -e
set -o pipefail

if [ -z "$3" ] ; then
    echo "Need: client_id client_secret refresh_token"
    exit 1
fi

client_id=$1
client_secret=$2
refresh_token=$3

curl https://accounts.google.com/o/oauth2/token \
    -F "refresh_token=$refresh_token" \
    -F "client_id=$client_id" \
    -F "client_secret=$client_secret" \
    -F "grant_type=refresh_token" \
    --progress-bar \
    | grep access_token \
    | sed "s/.*: \"\(.*\)\",/\1/"
