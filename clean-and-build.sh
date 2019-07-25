#@IgnoreInspection BashAddShebang

source .env

set -e
###########################################################################
# Have we got what it needs?
###########################################################################
./bin/check-dependencies.sh

###########################################################################
# Log into Azure and the Azure Container Registry
###########################################################################
az login
./ccd login

###########################################################################
# Clean up any previous instances
###########################################################################
./bin/destroy-containers.sh
./ccd compose down -v

###########################################################################
# Bring it up
###########################################################################
./bin/pull-latest-images.sh
./ccd compose up --build -d
./bin/wait-for-containers-to-be-ready.sh

./bin/document-management-store-create-blob-store-container.sh

###########################################################################
# Create roles and case workers
###########################################################################
./bin/create-idam-service-and-role.sh
./bin/create-ccd-roles.sh
./bin/ccd-add-role.sh "caseworker-sscs-panelmember" PRIVATE
./bin/idam-create-caseworker.sh caseworker-sscs-systemupvdate,caseworker-sscs,caseworker-sscs-callagent $HMCTS_EMAIL_ADDRESS
./bin/idam-create-caseworker.sh citizen sscs-citizen@hmcts.net

###########################################################################
# Import definitions
###########################################################################
./bin/create-import-user.sh
./bin/import-ccd-definitions.sh
