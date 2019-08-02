#!/usr/bin/env bash
./ccd compose stop shared-db
docker rm compose_shared-db_1
./ccd compose up -d
bin/wait-for-up.sh
docker exec -t -i compose_selenium-runner_1 sh -c "selenium-side-runner --base-url http://dockerhost:8082 --server http://selenium-server:4444/wd/hub -c \"browserName=chrome\" /SSCS_SIDAM.side"