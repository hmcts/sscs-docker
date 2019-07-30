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

npm install -g selenium-side-runner

cd tools
selenium-side-runner SSCS_SIDAM.side
cd ..

echo "Creating CCD users and roles..."

bin/create-users-and-roles.sh



