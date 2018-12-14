#!/usr/bin/env bash

set -e

DB_USERNAME=ccd
DB_PASSWORD=ccd

if [ -z "$DB_USERNAME" ] || [ -z "$DB_PASSWORD" ]; then
  echo "ERROR: Missing environment variable. Set value for both 'DB_USERNAME' and 'DB_PASSWORD'."
  exit 1
fi

# Create roles and databases
psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=$DB_USERNAME --set PASSWORD=$DB_PASSWORD <<-EOSQL
  CREATE USER :USERNAME WITH PASSWORD ':PASSWORD';
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=sscsjobscheduler --set PASSWORD=sscsjobscheduler <<-EOSQL
  CREATE USER :USERNAME WITH PASSWORD ':PASSWORD';
EOSQL

for service in idam ccd_user_profile ccd_definition ccd_data evidence; do
  echo "Database $service: Creating..."
psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=$DB_USERNAME --set PASSWORD=$DB_PASSWORD --set DATABASE=$service <<-EOSQL
  CREATE DATABASE :DATABASE
    WITH OWNER = :USERNAME
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
EOSQL
  echo "Database $service: Created"
done

psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=sscsjobscheduler --set PASSWORD=sscsjobsceduler --set DATABASE=sscsjobscheduler <<-EOSQL
  CREATE DATABASE :DATABASE
    WITH OWNER = :USERNAME
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
EOSQL
echo "Database sscsjobsceduler: Created"
