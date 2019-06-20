#!/bin/bash

source .env

role=$1

if [ -z "$role" ]
  then
    echo "Usage: ./ccd-add-role.sh role [classification]"
    exit 1
fi

binFolder=$(dirname "$0")

code=$(curl ${CURL_OPTS} -u "${IDAM_USERNAME}:${IDAM_PASSWORD}" -XPOST "${IDAM_URI}/oauth2/authorize?redirect_uri=${REDIRECT_URI}&response_type=code&client_id=${CLIENT_ID}" -d "" | jq -r .code)

userToken=$(curl ${CURL_OPTS} -H "Content-Type: application/x-www-form-urlencoded" -u "${CLIENT_ID}:${CLIENT_SECRET}" -XPOST "${IDAM_URI}/oauth2/token?code=${code}&redirect_uri=${REDIRECT_URI}&grant_type=authorization_code" -d "" | jq -r .access_token)

serviceToken=$(curl --fail --silent --show-error -X POST http://localhost:4502/testing-support/lease -d "{\"microservice\":\"sscs\"}" -H 'content-type: application/json')

echo

curl -XPUT \
  http://localhost:4451/api/user-role \
  -H "Authorization: Bearer ${userToken}" \
  -H "ServiceAuthorization: Bearer ${serviceToken}" \
  -H "Content-Type: application/json" \
  -d '{"role":"'${role}'","security_classification":"PUBLIC"}'

echo
