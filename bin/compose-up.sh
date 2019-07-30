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

if [ -z $HMCTS_EMAIL_ADDRESS ]; then
  echo "=========================================================================================="
  echo "Please add your HMCTS email address to the .env file"
  echo "=========================================================================================="
  exit
fi

source ./bin/set-environment-variables.sh

./ccd login

./ccd compose pull

./ccd compose up -d

while [ `./ccd compose ps | grep starting | wc -l` != "0" ]
do
    echo "Waiting for " `./ccd compose ps | grep starting | wc -l` " containers to start."
    sleep 5
done

echo
echo "Everything looks ready."

echo "Creating SIDAM services and roles. This will take around a minute..."

docker exec -t -i compose_selenium-runner_1 sh -c "selenium-side-runner --base-url http://dockerhost:8082 --server http://selenium-server:4444/wd/hub -c \"browserName=chrome\" /SSCS_SIDAM.side"

echo "Creating CCD users and roles..."

bin/create-users-and-roles.sh

echo "Updating CCD defintion with local callback URLs"

cd tools/ReplaceCallbackUrls
echo "Changed directory to $(pwd)"
#./gradlew run
cd -
echo "Changed directory to $(pwd)"

echo "Importing CCD definition..."

./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS

echo "Importing CCD Bulk Scan definition..."

./bin/ccd-import-definition.sh $CCD_BULK_SCAN_CASE_DEFINITION_XLS
