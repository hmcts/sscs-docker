#!/bin/bash
## Usage: ./ccd-import-definition.sh path_to_definition
##
## Import the given definition in CCD's definition store.
##
## Prerequisites:
##  - Microservice `ccd_gw` must be authorised to call service `ccd-definition-store-api`

source ./bin/set-environment-variables.sh
source .env

if [ -z "$1" ]
  then
    echo "Usage: ./ccd-import-definition.sh path_to_definition"
    exit 1
elif [ ! -f "$1" ]
  then
    echo "File not found: $1"
    exit 1
fi

echo "Updating callback URLs..."
cd tools/ReplaceCallbackUrls
java -jar bin/ReplaceCallbackUrls.jar $1 url-swaps.yml
cd -

binFolder=$(dirname "$0")

userToken="$(${binFolder}/utils/idam-user-token.sh)"
serviceToken="$(${binFolder}/idam-service-token.sh ccd_gw)"

curl --silent \
  http://localhost:4451/import \
  -H "Authorization: Bearer ${userToken}" \
  -H "ServiceAuthorization: Bearer ${serviceToken}" \
  -F file="@$1"
