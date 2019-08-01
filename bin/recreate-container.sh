#!/usr/bin/env bash
./ccd compose stop $1
docker rm compose_$1_1
./ccd compose up -d $1

