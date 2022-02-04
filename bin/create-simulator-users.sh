#!/bin/bash

source ./bin/set-environment-variables.sh
source .env

./bin/simulator-create-caseworker.sh ccd-import ccd.docker.default@hmcts.net Pa55word11 Default CCD_Docker
./bin/simulator-create-caseworker.sh caseworker-sscs,caseworker,caseworker-sscs-superuser,caseworker-wa-task-configuration,caseworker-wa,caseworker-ia-caseofficer local.test@example.com ##ia temp again
./bin/simulator-create-caseworker.sh caseworker-sscs-systemupdate,caseworker-sscs,caseworker,caseworker-wa-task-configuration,caseworker-wa system.update@hmcts.net
./bin/simulator-create-caseworker.sh caseworker-wa,caseworker-wa-task-configuration wa-system-user@fake.hmcts.net System01 WaUser WASystem


./bin/simulator-create-caseworker.sh caseworker,caseworker-sscs,caseworker-sscs-dwpresponsewriter dwpuser@example.com Pa55word11 DWP user
./bin/simulator-create-caseworker.sh caseworker,caseworker-sscs,caseworker-sscs-judge judge@example.com Pa55word11 Judge user

./bin/simulator-create-caseworker.sh citizen sscs-citizen2@hmcts.net

./bin/simulator-create-caseworker.sh manage-user data.store.idam.system.user@gmail.com
