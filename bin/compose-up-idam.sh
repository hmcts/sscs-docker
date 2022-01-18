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

if [ ! -f $CCD_CASE_DEFINITION_XLS ]; then
  echo "=========================================================================================="
  echo "CCD definition not found."
  echo "Please check the CCD_CASE_DEFINITION_XLS value in  your .env file"
  echo "Location is currently set to $CCD_CASE_DEFINITION_XLS"
  echo "=========================================================================================="
  exit
fi

if [ ! -f $CCD_BULK_SCAN_CASE_DEFINITION_XLS ]; then
  echo "=========================================================================================="
  echo "CCD Bulk Scan definition not found."
  echo "Please check the CCD_BULK_SCAN_CASE_DEFINITION_XLS value in  your .env file"
  echo "Location is currently set to $CCD_BULK_SCAN_CASE_DEFINITION_XLS"
  echo "=========================================================================================="
  exit
fi

source ./bin/set-environment-variables.sh

echo "Forcing re-creation of shared-db container to ensure SIDAM roles are cleared"

./ccd compose down

docker rm compose_shared-db_1 || true
docker rm compose_ccd-shared-database_1 || true

./ccd compose pull

./ccd compose up -d

echo "Is idam-api up and running http://localhost:5000/health ??"
echo "if you can not get it healthy then run: sudo docker restart compose_idam-api_1"
echo "Press ENTER when http://localhost:5000/health is UP."
read

./ccd compose up -d

echo "Press ENTER when CCD definition store and CCD data store are up and running."
read

./bin/document-management-store-create-blob-store-container.sh

while [ `./ccd compose ps | grep starting | wc -l` != "0" ]
do
    echo "Waiting for " `./ccd compose ps | grep starting | wc -l` " containers to start."
    sleep 5
done

echo
echo "Everything looks ready."

echo "Creating SIDAM services and roles. This will take around a minute..."

echo "Creating Service Clients..."

bin/idam-client-setup.sh

echo "Creating CCD users and roles..."

bin/create-users-and-roles.sh

echo "Changed directory to $(pwd)"

echo "Importing CCD definition..."

./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS

echo

echo "Importing CCD Bulk Scan definition..."

./bin/ccd-import-definition.sh $CCD_BULK_SCAN_CASE_DEFINITION_XLS

echo "Success! Remember to update to latest definition if required"

echo
