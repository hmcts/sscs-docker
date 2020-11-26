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

./ccd compose stop

./ccd compose up -d

echo "Is idam-api up and running http://localhost:5000/health ??"
echo "if you can not get it healthy then run: sudo docker restart compose_sidam-api_1"
echo "Press ENTER when http://localhost:5000/health is UP"
read
echo "Press ENTER when CCD definition store and CCD data store are up and running"
read
echo
echo "Success! Ensure latest definition is imported"

