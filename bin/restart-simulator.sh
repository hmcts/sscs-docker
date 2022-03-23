#!/bin/bash

set -e

source .env

command -v az >/dev/null 2>&1 || {
    echo "=========================================================================================="
    echo >&2 "Please install Azure CLI - instructions in README.md"
    echo "=========================================================================================="
    exit 1
}

command -v docker-compose >/dev/null 2>&1 || {
    echo "=========================================================================================="
    echo >&2 "Please install Docker Compose - instructions in README.md"
    echo "=========================================================================================="
    exit 1
}

command -v jq >/dev/null 2>&1 || {
    echo "=========================================================================================="
    echo >&2 "Please install jq - instructions in README.md"
    echo "=========================================================================================="
    exit 1
}

command -v java >/dev/null 2>&1 || {
    echo "=========================================================================================="
    echo >&2 "Please install java - instructions in README.md"
    echo "=========================================================================================="
    exit 1
}

source ./bin/set-environment-variables.sh

./ccd compose restart

./bin/document-management-store-create-blob-store-container.sh

while [ `./ccd compose ps | grep starting | wc -l` != "0" ]
do
    echo "Waiting for " `./ccd compose ps | grep starting | wc -l` " containers to start."
    sleep 5
done

./ccd compose start

echo "Is ccd-definition-store-api up and running http://localhost:4451/health ??"
echo "if you can not get it healthy then run: sudo docker restart compose_ccd-definition-store-api_1"
echo "Press ENTER when http://localhost:4451/health is UP."
read

echo "Creating CCD roles..."


./bin/add-sscs-ccd-roles.sh

echo "Creating CCD users..."
./bin/create-simulator-users.sh

echo "Importing CCD definition..."

./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS

echo

echo "Importing CCD Bulk Scan definition..."

./bin/ccd-import-definition.sh $CCD_BULK_SCAN_CASE_DEFINITION_XLS

echo
echo "Everything looks ok. Please wait a few minutes whilst all services start..."
echo
echo "Remember to update to latest definition if required"


