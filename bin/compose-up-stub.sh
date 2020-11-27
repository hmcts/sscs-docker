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

./ccd login

echo "Forcing re-creation of shared-db container to ensure SIDAM roles are cleared"

./ccd compose down

docker rm compose_shared-db_1 || true
docker rm compose_ccd-shared-database_1 || true

./ccd compose pull

./ccd compose up -d

./bin/document-management-store-create-blob-store-container.sh

while [ `./ccd compose ps | grep starting | wc -l` != "0" ]
do
    echo "Waiting for " `./ccd compose ps | grep starting | wc -l` " containers to start."
    sleep 5
done

echo "Adding roles "

./bin/add-roles.sh

echo
echo "Everything looks ok. Please wait 5 - 10 minutes whilst all services start..."
echo
echo "Remember to update to latest definition if required"


