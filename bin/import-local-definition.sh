#!/bin/bash

## Usage: ./import-local-definition.sh
##
## Import a local version of the AAT definition into CCD's definition store. The path to the definition is set in field CCD_CASE_DEFINITION_XLS in the .env file.
##
## Prerequisites:
##  - Microservice `ccd_gw` must be authorised to call service `ccd-definition-store-api`
##
## To create prod definitions and run them locally run ./import-local-definition.sh prod

ENV=${1}

if [ -z "${ENV}" ]; then
    ENV="local"
fi

echo "Importing ${ENV} Definitions"

source .env

if [ ! -f $CCD_CASE_DEFINITION_XLS ]; then
  echo "=========================================================================================="
  echo "CCD definition not found."
  echo "Please check the CCD_CASE_DEFINITION_XLS value in  your .env file"
  echo "Location is currently set to $CCD_CASE_DEFINITION_XLS"
  echo "=========================================================================================="
  exit
fi

cd ../sscs-ccd-definitions/benefit
docker build -t hmctspublic.azurecr.io/sscs/ccd-definition-importer-benefit:dev -f ../docker/importer.Dockerfile .
cd ../

export CCD_CASE_DEFINITION_XLS=${CCD_CASE_DEFINITION_XLS%/*}/CCD_SSCSDefinition_vdev_${ENV^^}.xlsx
./bin/create-xlsx.sh benefit dev ${ENV}
echo "Resolved enviroment ${ENV}, Replacing Current CCD Definition path to ${CCD_CASE_DEFINITION_XLS}"

cd ../sscs-docker
./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS ${ENV}
