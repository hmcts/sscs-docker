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

echo "Creating SIDAM services and roles. This will take around a minute..."

docker exec -t -i compose_selenium-runner_1 sh -c "selenium-side-runner --base-url http://dockerhost:8082 --server http://selenium-server:4444/wd/hub -c \"browserName=chrome\" /SSCS_SIDAM.side"

echo "Creating CCD users and roles..."

bin/create-users-and-roles.sh
