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

waitForHealthy () {
  local host=$1
  local port=$2
  echo "Waiting for http://$host:$port/health to be healthy"
  while [[ $(curl "http://$host:$port/health" 2>/dev/null | jq -r '.status' ) != "UP" ]]
  do
      printf '.'
      sleep 5
      if [[ $(./ccd compose ps 2>/dev/null | grep stopped | wc -l) != "0" ]]; then
        ./ccd compose start -d
      fi
  done
  printf '\n'
}

waitForContainers () {
  local status=$1
  while [[ $(./ccd compose ps | grep $status | wc -l) != "0" ]]
  do
      numLeft=$(./ccd compose ps 2>/dev/null | grep $status | wc -l)
      echo "Waiting for $numLeft containers to start."
      sleep 5
  done
}

source ./bin/set-environment-variables.sh

echo "Forcing re-creation of shared-db container to ensure SIDAM roles are cleared"

./ccd compose down

docker rm compose_shared-db_1 || true
docker rm compose_ccd-shared-database_1 || true

./ccd compose pull

./ccd compose up -d

./bin/document-management-store-create-blob-store-container.sh

waitForContainers starting

./ccd compose up -d

echo "Is ccd-definition-store-api up and http://localhost:4451/health is UP"
echo "if you can not get it healthy then run: sudo docker restart compose_ccd-definition-store-api_1"
waitForHealthy localhost 4451

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


