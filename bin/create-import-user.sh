#!/bin/bash

set -e

source .env

curl -XPOST -H "Content-Type: application/json" ${IDAM_URI}/testing-support/accounts -d "{
    \"email\": \"${IMPORTER_USERNAME}\",
    \"forename\": \"Ccd\",
    \"surname\": \"Importer\",
    \"id\": \"sscs\",
    \"levelOfAccess\": 0,
    \"userGroup\": {
      \"code\": \"ccd-import\"
    },
    \"roles\": [{ \"code\": \"ccd-import\" }],
    \"activationDate\": \"\",
    \"lastAccess\": \"\",
    \"password\": \"${IMPORTER_PASSWORD}\"
}"
