#!/bin/bash

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