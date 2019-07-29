#!/bin/bash

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

#docker cp tools/sscs-sidam.sql compose_shared-db_1:/sscs-sidam.sql
#docker exec -ti compose_shared-db_1 psql -U openidm -d openidm -c "\i /sscs-sidam.sql"

#docker cp tools/test_createccdgatewayandsscsservices.py compose_selenium_1:/test_createccdgatewayandsscsservices.py
#docker exec -t -i compose_selenium_1 python /test_createccdgatewayandsscsservices.py
