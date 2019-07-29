#!/bin/bash

source ./bin/set-environment-variables.sh

echo -n "Enter your HMCTS email address: "
read EMAIL

./bin/idam-create-caseworker.sh ccd-import ccd.docker.default@hmcts.net Pa55word11 Default CCD_Docker
./bin/add-sscs-ccd-roles.sh
./bin/idam-create-caseworker.sh caseworker-sscs-systemupdate,caseworker-sscs,caseworker-sscs-clerk,caseworker,caseworker-sscs-superuser $EMAIL
./bin/idam-create-caseworker.sh caseworker-sscs-systemupdate,caseworker system.update@hmcts.net

./bin/idam-create-caseworker.sh citizen sscs-citizen@hmcts.net