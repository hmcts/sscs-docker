#!/bin/bash

source .env



echo "Updating CCD defintion with local callback URLs"

cd tools/ReplaceCallbackUrls
echo "Changed directory to $(pwd)"
./run.sh
cd -
echo "Changed directory to $(pwd)"


echo "Importing CCD definition..."

./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS

echo "Importing CCD Bulk Scan definition..."

./bin/ccd-import-definition.sh $CCD_BULK_SCAN_CASE_DEFINITION_XLS
