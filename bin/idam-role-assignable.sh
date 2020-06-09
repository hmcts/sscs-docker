#!/bin/sh

IDAM_URI="http://localhost:5000"
role=$1
description=${2:-Test}

if [ -z "$role" ]
  then
    echo "Usage: ./idam-role.sh role [role] [description]"
    exit 1
fi
authToken=$(curl -H 'Content-Type: application/x-www-form-urlencoded' -XPOST "${IDAM_URI}/loginUser?username=idamOwner@hmcts.net&password=Ref0rmIsFun" | jq -r .api_auth_token)

curl --request POST \
  --url "${IDAM_URI}/roles" \
  --header "Authorization: AdminApiAuthToken ${authToken}" \
  --header "Content-Type: application/json" \
  --data '{"id": "'${role}'","name": "'${role}'","description": "'${description}'","assignableRoles": ["ccd-import", "caseworker", "caseworker-divorce-courtadmin-la", "caseworker-divorce", "caseworker-divorce-superuser", "caseworker-divorce-courtadmin", "caseworker-divorce-solicitor", "caseworker-divorce-courtadmin_beta", "caseworker-bulkscan", "caseworker-divorce-systemupdate", "caseworker-divorce-bulkscan", "payment"],"conflictingRoles": []}'
