#!/bin/bash
## Usage: ./ccd-import-definition.sh path_to_definition
##
## Import the given definition in CCD's definition store.
##
## Prerequisites:
##  - Microservice `ccd_gw` must be authorised to call service `ccd-definition-store-api`

source ./bin/set-environment-variables.sh
source .env
definitionUrl=${CCD_DEFINITION_URL:-http://localhost:4451}

if [ -z "$1" ]
  then
    echo "Usage: ./ccd-import-definition.sh path_to_definition"
    exit 1
elif [ ! -f "$1" ]
  then
    echo "File not found: $1"
    exit 1
fi

echo "Resolving host IP for URL swaps..."
if uname -r | grep -iF -q 'wsl2'; then
  hostIP="http://$(ifconfig eth0 | grep 'inet\b' | awk '{print $2}')"
  echo "WSL2 in use. Using host: $hostIP"
else
  echo "WSL2 not in use, defaulting to host.docker.internal."
  hostIP="http://host.docker.internal"
fi

echo "Updating callback URLs..."
cd tools/ReplaceCallbackUrls
java -jar bin/ReplaceCallbackUrls.jar $1 url-swaps.yml $hostIP
cd -

binFolder=$(dirname "$0")

userToken="$(${binFolder}/utils/idam-user-token.sh)"
serviceToken="$(${binFolder}/utils/lease-service-token.sh ccd_gw)"


curl --silent \
  "${definitionUrl}"/import \
  -H "Authorization: Bearer ${userToken}" \
  -H "ServiceAuthorization: Bearer ${serviceToken}" \
  -F file="@$1"
