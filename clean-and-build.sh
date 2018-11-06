# This script will tear down everything and rebuild

echo "Please enter your hmcts.net email address: "
read email

./ccd compose down -v

./ccd enable frontend backend dm-store
./ccd compose pull

DB_USERNAME=ccd DB_PASSWORD=password ./ccd compose up --build -d

echo "Starting docker containers..."
while [ `./ccd compose ps | grep starting | wc -l` != "0" ]
do
    echo "Waiting... for " `./ccd compose ps | grep starting | wc -l` " containers to start."
    sleep 5
done

./bin/document-management-store-create-blob-store-container.sh

DB_USERNAME=ccd DB_PASSWORD=password sh ./database/init-db.sh

docker exec -ti compose_ccd-shared-database_1 psql -U postgres -c "CREATE DATABASE evidence"

roles=("caseworker-sscs" "caseworker-sscs-systemupdate" "caseworker-sscs-anonymouscitizen" "caseworker-sscs-callagent")

for role in "${roles[@]}"
do
  echo "Creating role $role"
  until ./bin/ccd-add-role.sh $role
  do
    echo "Failed to create role, trying again in a few seconds"
    sleep 5
  done
done

./bin/idam-create-caseworker.sh caseworker-sscs,caseworker-sscs-systemupdate,caseworker-sscs-anonymouscitizen,caseworker-sscs-callagent $email

#####################################################################################
# Modify these commands to point to your local definition files
#####################################################################################
./bin/ccd-import-definition.sh ../CCD_SSCSDefinition_v4.0.3_AAT.xlsx
./bin/ccd-import-definition.sh ../CCD_BulkScanningDefinition_P1P2_v1.0.1_AAT.xlsx
