#!/bin/sh
##Create all the role
./bin/idam-role.sh caseworker
./bin/idam-role.sh caseworker-sscs
./bin/idam-role.sh caseworker-sscs-systemupdate
./bin/idam-role.sh caseworker-sscs-clerk
./bin/idam-role.sh caseworker-sscs-anonymouscitizen
./bin/idam-role.sh caseworker-sscs-callagent
./bin/idam-role.sh caseworker-sscs-judge
./bin/idam-role.sh caseworker-sscs-dwpresponsewriter
./bin/idam-role.sh caseworker-sscs-registrar
./bin/idam-role.sh caseworker-sscs-superuser
./bin/idam-role.sh caseworker-sscs-panelmember
./bin/idam-role.sh caseworker-sscs-bulkscan
./bin/idam-role-assignable.sh ccd-import
