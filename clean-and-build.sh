#####################################################################################
# DB_USERNAME and DB_PASSWORD should be set in the .env file
#####################################################################################
source .env

command -v az >/dev/null 2>&1 || { 
    echo "################################################################################################"
    echo >&2 "Please install Azure CLI - instructions in README.md"
    echo "################################################################################################"
    exit 1 
}

#####################################################################################
# Login to Azure
#####################################################################################

if az account show | grep -i "hmcts.net"; then
  echo "You are logged into HMCTS Azure Portal"
else
  echo "Logging into the HMCTS Azure Portal. Please check your web browser."
  az login
fi

echo "Logging into the HMCTS Azure Container Registry"
./ccd login

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

if [ -z $DESTROY_ALL_DOCKER_IMAGES_AND_CONTAINERS ]; then
  read -p "Would you like to attempt to destroy all Docker images and containers on your machine? This will remove all images and containers (not just SSCS ones) and can be slow, so only do this if this is your first time running this setup, or you're having difficulties getting the setup working. [y/n] " DESTROY_ALL_DOCKER_IMAGES_AND_CONTAINERS
fi

if [ -z $INCLUDE_DM_STORE ]; then
  read -p "Include Document Store in new configuration? [y/n] " INCLUDE_DM_STORE
fi

if [ -z $INCLUDE_CASE_API ]; then
  read -p "Tribunals Case API? [y/n] " INCLUDE_CASE_API
fi

if [ -z $INCLUDE_BULK_SCAN ]; then
  read -p "Bulk Scanning API? [y/n] " INCLUDE_BULK_SCAN
fi

if [ $DESTROY_ALL_DOCKER_IMAGES_AND_CONTAINERS == "y" ]; then
  docker container stop $(docker container ls -a -q)
  docker system prune -a -f --volumes
fi

#####################################################################################
# Take down containers and remove volumes
#####################################################################################
./ccd compose down -v

#####################################################################################
# Pull the latest images
#####################################################################################
rm .tags.env
./ccd enable frontend backend 

if [ $INCLUDE_DM_STORE == "y" ]; then
  ./ccd enable dm-store
fi

if [ $INCLUDE_CASE_API == "y" ]; then
  ./ccd enable case-api
fi

if [ $INCLUDE_BULK_SCAN == "y" ]; then
  ./ccd enable bulk-scan
fi

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
# Create the CCD roles
#####################################################################################
roles=("caseworker-sscs" "citizen" "caseworker-sscs-systemupdate" "caseworker-sscs-anonymouscitizen" "caseworker-sscs-callagent" "caseworker-sscs-judge" "caseworker-sscs-panelmember")

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

#####################################################################################
# Create a case worker with your email address
#####################################################################################
./bin/idam-create-caseworker.sh caseworker-sscs,caseworker-sscs-callagent $HMCTS_EMAIL_ADDRESS
./bin/idam-create-caseworker.sh citizen sscs-citizen@hmcts.net

#####################################################################################
# Import the CCD definition files
# Modify these commands to point to your local definition files
#####################################################################################
ATTEMPTS=0
until ./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS
do
    echo "Failed to import definition, trying again in a few seconds"
    sleep $TRY_AGAIN_SECONDS
    ATTEMPTS=$((ATTEMPTS+1))
    if [ $ATTEMPTS = 200 ]; then
       echo "Giving up."
       exit;
    fi
done

if [ ! -z $CCD_BULK_SCANNING_DEFINITION_XLS ]; then
  if [ ! -f $CCD_BULK_SCANNING_DEFINITION_XLS ]; then
    echo "$CCD_BULK_SCANNING_DEFINITION_XLS not found"
  else
    ATTEMPTS=0
    until ./bin/ccd-import-definition.sh $CCD_BULK_SCANNING_DEFINITION_XLS
    do
      echo "Failed to import definition, trying again in a few seconds"
      sleep $TRY_AGAIN_SECONDS
      ATTEMPTS=$((ATTEMPTS+1))
      if [ $ATTEMPTS = 200 ]; then
         echo "Giving up."
         exit;
      fi
    done
  fi
fi


