
#####################################################################################
# DB_USERNAME and DB_PASSWORD should be set in the .env file
#####################################################################################
source .env

#####################################################################################
# Get the user's email address
# Ignore if set in .env file
#####################################################################################
if [ -z $CCD_CASE_DEFINITION_XLS ]; then
  echo "================================================================================"
  echo "Please add the location of your CCD case definition spreadsheet to the .env file"
  echo "================================================================================"
  exit
fi

if [ -z $HMCTS_EMAIL_ADDRESS ]; then
  read -p "Enter your hmcts.net email address: " HMCTS_EMAIL_ADDRESS
fi

read -p "Would you like to attempt to destroy all ALL Docker images and containers (not just SSCS ones) on your machine? [y/n] " FULL_CLEAN

if [ $FULL_CLEAN == "y" ]; then
	docker rm $(docker ps -a -q)
	docker rmi $(docker images -q)
fi

#####################################################################################
# Take down containers and remove volumes
#####################################################################################
./ccd compose down -v

#####################################################################################
# Pull the latest images
#####################################################################################
./ccd enable frontend backend dm-store
./ccd compose pull

#####################################################################################
# Start the containers
#####################################################################################
./ccd compose up --build -d

echo "Starting docker containers..."
while [ `./ccd compose ps | grep starting | wc -l` != "0" ]
do
    echo "Waiting for " `./ccd compose ps | grep starting | wc -l` " containers to start."
    sleep 5
done

#####################################################################################
# Create Blob Store in Azurite
#####################################################################################

./bin/document-management-store-create-blob-store-container.sh

#####################################################################################
# Initialise the database
#####################################################################################
DB_USERNAME=$DB_USERNAME DB_PASSWORD=$DB_PASSWORD sh ./database/init-db.sh

#####################################################################################
# Create the CCD roles
#####################################################################################
roles=("caseworker-sscs" "caseworker-sscs-systemupdate" "caseworker-sscs-anonymouscitizen" "caseworker-sscs-callagent" "caseworker-sscs-judge")

for role in "${roles[@]}"
do
  echo "Creating role $role"
  until ./bin/ccd-add-role.sh $role
  do
    echo "Failed to create role, trying again in a few seconds"
    sleep 5
  done
done

#####################################################################################
# Create a case worker with your email address
#####################################################################################
./bin/idam-create-caseworker.sh caseworker-sscs,caseworker-sscs-systemupdate,caseworker-sscs-anonymouscitizen,caseworker-sscs-callagent $HMCTS_EMAIL_ADDRESS

#####################################################################################
# Import the CCD definition files
# Modify these commands to point to your local definition files
#####################################################################################

until ./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS
do
    echo "Failed to import definition, trying again in a few seconds"
done

if [ -n $CCD_BULK_SCANNING_DEFINITION_XLS ]; then
  until ./bin/ccd-import-definition.sh $CCD_BULK_SCANNING_DEFINITION_XLS
  do
    echo "Failed to import definition, trying again in a few seconds"
  done
fi


