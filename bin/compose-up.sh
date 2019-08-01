#!/bin/bash

set -e

source .env



echo "Creating SIDAM services and roles. This will take around a minute..."

if [ $MANUAL_SIDAM_ROLE_ENTRY == "y" ]; then
    echo "Please install the Selenium IDE browser extension, then load the tools/SSCS_SIDAM.side script against http://localhost:8082"
    echo "Press ENTER when done..."
    read
else
    sleep 10
    docker exec -t -i compose_selenium-runner_1 sh -c "selenium-side-runner --base-url http://dockerhost:8082 --server http://selenium-server:4444/wd/hub -c \"browserName=chrome\" /SSCS_SIDAM.side"
fi

echo "Creating CCD users and roles..."

bin/create-users-and-roles.sh

echo "Updating CCD defintion with local callback URLs"

cd tools/ReplaceCallbackUrls
echo "Changed directory to $(pwd)"
./gradlew run --args="$CCD_CASE_DEFINITION_XLS url-swaps.yml"
./gradlew run --args="$CCD_BULK_SCAN_CASE_DEFINITION_XLS url-swaps.yml"
cd -

echo "Changed directory to $(pwd)"

echo "Importing CCD definition..."

./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS

echo "Importing CCD Bulk Scan definition..."

./bin/ccd-import-definition.sh $CCD_BULK_SCAN_CASE_DEFINITION_XLS
