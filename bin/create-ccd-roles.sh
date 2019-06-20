#!/usr/bin/env bash
roles=("ccd-import" "caseworker-sscs-clerk" "caseworker-sscs-dwpresponsewriter" "caseworker-sscs" "citizen" "caseworker-sscs-systemupdate" "caseworker-sscs-anonymouscitizen" "caseworker-sscs-callagent" "caseworker-sscs-judge" "caseworker-sscs-panelmember")

TRY_AGAIN_SECONDS=15
ATTEMPTS=0
for role in "${roles[@]}"
do
  echo "Creating role $role"
  until ./bin/ccd-add-role.sh $role
  do
    echo "Failed to create role. This might be ok - trying again in $TRY_AGAIN_SECONDS seconds"
    sleep $TRY_AGAIN_SECONDS
    ATTEMPTS=$((ATTEMPTS+1))
    if [ $ATTEMPTS = 200 ]; then
       echo "Giving up."
       exit;
    fi
  done
done