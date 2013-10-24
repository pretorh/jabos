#! /bin/bash
set -e
set -o pipefail

if [ -z "$1" ] ; then
    echo "Need: access_token"
    exit 1
fi

access_token=$1

curl https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$access_token \
    --progress-bar \
    | tr "\n" " " \
    | sed 's/.*"scope": "\(.*\)",.*"expires_in": \(.*\),.*/\2\n\1\n/'
