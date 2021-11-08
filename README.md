# CCD/SSCS Docker :whale:

- [Quick start](#Quick start)
- [Elastic search](#elastic-search)

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version 2.0.57 
- [jq Json Processor] (https://stedolan.github.io/jq)
- [Docker](https://www.docker.com)
- [Java 8](https://www.java.com)

You can increase the memory available to Docker from the Preferences|Advanced options on your Docker installation. We recommend allocating 12G. The SIDAM containers
are quite hungry.

## Tip

***Note*** If you find yourself in a bit of a mess, you may want to destroy all your containers and images with the following command. This will make bringing it all up again slower as it will need to download the images again.

```bash
./bin/docker-clean.sh
```

## Getting Started

The first time you set up, you will need to create the CCD network 

```bash
docker network create ccd-network
```

Also, ensure all environment variables are copied from `.env.example` to `.env` and update any variables that are unique to your envinroment (e.g. CCD_CASE_DEFINITION_XLS)

#### Using idam simulator (Default):

Ensure the value `rse-idam-simulator` is in the `./compose/defaults.conf` file

In your /etc/hosts file add a value for `127.0.0.1       rse-idam-simulator`

Ensure the service_started conditions for ccd-test-stubs-service are commented out and rse-idam-simulator are uncommented in `./compose/backend.yaml` (This should be set by default)

Uncomment the following variables in your .env file
```bash
export IDAM_STUB_SERVICE_NAME=http://rse-idam-simulator:5000
export IDAM_STUB_LOCALHOST=http://rse-idam-simulator:5000
```

Bring up the containers
```bash
source .env
./bin/compose-up-simulator.sh
```

After all the containers are up and running you may get an Invalid AccessProfile error when the definition is imported, if so run these commands to fix:

```bash
./bin/add-sscs-ccd-roles.sh
./bin/create-simulator-users.sh
```

Then after the roles and users are created, reimport the definition file manually this should import the definition successfully.

#####SYA and IdamSimulator:

To get SYA running with simulator you must make the following changes to SYA:

first you must change the uri in accessToken.js found in this folder (node_modules/@hmcts/div-idam-express-middleware/wrapper/accessToken.js)

change from:
```bash
uri: `${args.idamApiUrl}/oauth2/token`
```
to this:
```bash
uri: `${args.idamApiUrl}/oauth2/token?client_id=${args.idamClientID}&client_secret=${args.idamSecret}`
```

now you should be able to login and submit an appeal using idam simulator and SYA with user:

```bash
sscs-citizen2@hmcts.net
Testing123
```

#####MYA and IdamSimulator:

For MYA to run with simulator you will need to change the following uri found in file app/server/services/idam.ts.

change from:
```bash
`${this.apiUrl}/oauth2/token`
```
to this:
```bash
uri: `${this.apiUrl}/oauth2/token?client_id=sscs&client_secret=${this.appSecret}`
```

Then in file app/server/controllers/login.ts at line 70 the following line must be added:

 ```bash
 else {
       idamUrl.searchParams.append('state', '');
     }
 ```

Before running MYA, when exporting variables change IDAM_URL port to 5000 instead of 3501:

```bash
export SSCS_API_URL=http://localhost:8080
export COH_URL=http://coh-cor-aat.service.core-compute-aat.internal
export S2S_SECRET=AAAAAAAAAAAAAAAC
export S2S_URL=http://localhost:4502
export IDAM_API_URL=http://localhost:5000
export IDAM_URL=http://localhost:5000
export HTTP_PROTOCOL=http
export TRIBUNALS_API_URL=http://localhost:8080
export IDAM_CLIENT_SECRET=QM5RQQ53LZFOSIXJ
export NODE_ENV=preview
export MYA_FEATURE_FLAG=true
export EVIDENCE_UPLOAD_QUESTION_PAGE_OVERRIDE_ALLOWED=true
export EVIDENCE_UPLOAD_QUESTION_PAGE_ENABLED=false
export ADDITIONAL_EVIDENCE_FEATURE_FLAG=true
export POST_BULK_SCAN=true
```
Now you should be redirected to idam simulator login page when using MYA.

#### Using real idam:

To set up real idam first the idam images will need to be added to defualts.conf and idam simulator will need to be removed:

```bash
backend
frontend
dm-store
xui
sidam
sidam-local
sidam-local-ccd
pdf-service-api
elasticsearch
logstash
stitching-api
rpa-em-ccd-orchestrator
case-document-am
```

Next in the backend.yml file the following lines need to be commented out for both ccd-data-store-api and ccd-definition-store-api:

```bash
#rse-idam-simulator:
 #condition: service_started
```

Then real idam needs to be uncommented for both ccd-data-store-api and ccd-definition-store-api:

```bash
idam-api:
  condition: service_started
```

In the stitching-api.yml file under both the depends_on and links section, rse-idam-simulator needs to be commented out and idam-api needs to be uncommented

Now the containers can be started using:

```bash
source .env
./bin/compose-up-idam.sh
```

Each subsequent time after you can just run this to restart the containers:

```bash
./ccd compose up -d
```

#### Using idam stub (Check setup instructions in section below before following this):

Using the idam stub for first time:

```bash
./bin/compose-up-stub.sh
```

Each subsequent time after you can just run this to restart the containers:

```bash
./ccd compose up -d
```

Now import the CCD case definition locally. Please follow instructions in the sscs-ccd-definitions README. 

Please read instructions below on how to switch between the real idam and idam stub

#### Potential startup problems

Network ccd-network declared as external, but could not be found error?
Run `docker network create ccd-network` and try again.

Authentication required error or error pulling images? try:

```bash
az acr login -n hmctspublic
./ccd login
```

Pulling from sscs-logstash error? 
Try opening the ccd-logstash project and running the `./bin/build-logstash-instances.sh` script.

Error accessing CCD or XUI? 
Ensure all environment variables are copied from .env.example to .env

## Importing CCD case definition

To import the CCD case definition locally, run the `./bin/import-local-definition.sh` script. 
This builds a local version of the AAT CCD definition from your sscs-ccd-definitions project (assuming your directory structure matches the script. If your structure is different then follow the Readme in sscs-ccd-definitions project for details on how to import). 

## Switching between Idam stub and Idam
It's possible to disable the Idam containers and run CCD with an Idam Stub provided by ccd-test-stubs-service. This is useful as a back up plan for when docker Idam is broken or when you local machine is running low on memory and you don't want to spin up the whole Idam containers

### Enable Idam Stub

#### Step 1 - Disable Sidam containers

make sure 'sidam', 'sidam-local', 'sidam-local-ccd' docker compose files are not enabled. How you do that depends on your currently active compose files.
When no active compose files are present, the default ones are executed. But if there's any active, then the default ones are ignored. For example:

```bash
./ccd enable show

Currently active compose files:
backend
dm-store
frontend
sidam
sidam-local
sidam-local-ccd
xui

Default compose files:
backend
dm-store
frontend
sidam
sidam-local
sidam-local-ccd
xui
```

In this case sidam is currently explicitly enabled. To disable it either remove from `defaults.conf` or:

```bash
./ccd disable sidam sidam-local sidam-local-ccd
```

If you are instead running with the default compose file as in:
```bash
./ccd enable show

Default compose files:
backend
dm-store
frontend
sidam
sidam-local
sidam-local-ccd
xui
```

You must explicitly enable only CCD compose files but exclude sidam:

```bash
./ccd enable backend dm-store frontend xui
./ccd enable show

Currently active compose files:
backend
dm-store
frontend
xui

Default compose files:
backend
dm-store
frontend
sidam
sidam-local
sidam-local-ccd
xui
```

#### Step 2 - Setup Env Vars

in the '.env' file, uncomment:

```yaml
#IDAM_STUB_SERVICE_NAME=http://ccd-test-stubs-service:5555
#IDAM_STUB_LOCALHOST=http://localhost:5555
```

To allow definition imports to work ('ccd-import-definition.sh') you need to:

```bash
export IDAM_STUB_LOCALHOST=http://localhost:5555
```

:warning: Please note: remember to unset 'IDAM_STUB_LOCALHOST' when switching back to the real Idam, otherwise definition import won't work

```bash
unset IDAM_STUB_LOCALHOST
```

#### Step 3 - (Optional) Customise IDAM roles

IDAM Stub comes with a predefined IDAM user.\
To permanently customise the stub user info such as its roles follow the instructions in 'backend.yml' -> ccd-test-stubs-service\
To modify the user info at runtime, see https://github.com/hmcts/ccd-test-stubs-service#idam-stub

#### Step 4 - Enable stub service dependency

Enable ccd-test-stubs-service dependency on ccd-data-store-api and ccd-definition-store-api in 'backend.yml' file.

Uncomment the below lines in 'backend.yml' file for ccd-definition-store-api and ccd-data-store-api
```yaml 
      #      ccd-test-stubs-service:
      #        condition: service_started
```

Comment the below lines in 'backend.yml' file for ccd-definition-store-api and ccd-data-store-api
```yaml 
      idam-api:
        condition: service_started
```


#### Step 5 - bringing it up

Before bringing up the containers, if switching from the real idam to idam stub, please check all idam containers are stopped before continuing.

To bring up the containers, run the following from the root directory of the cloned repository:

```bash
./bin/compose-up-stub.sh
```

#### Step 6 - import CCD definition

To import the CCD definition locally, please follow instructions in the sscs-ccd-definitions README. 


### Revert to Idam

#### Step 1 - Enable Sidam containers

```bash
./ccd enable sidam sidam-local sidam-local-ccd
```

or just revert to the default:

```bash
./ccd enable default
```

#### Step 2 - Setup Env Vars

in the '.env' file, make sure the following env vars are commented:

```yaml
#IDAM_STUB_SERVICE_NAME=http://ccd-test-stubs-service:5555
#IDAM_STUB_LOCALHOST=http://localhost:5555
```

then from the command line:

```bash
unset IDAM_STUB_LOCALHOST
```

#### Step 3 - Disable stub service dependency

Disable ccd-test-stubs-service dependency on ccd-data-store-api and ccd-definition-store-api in 'backend.yml' file.

Comment the below lines in 'backend.yml' file
```yaml 
    #   ccd-test-stubs-service:
    #       condition: service_started
```

Uncomment the below lines in 'backend.yml' file
```yaml 
      idam-api:
        condition: service_started
```

#### Step 4 - bringing it up

To bring up the containers, run the following from the root directory of the cloned repository:

```bash
./bin/compose-up-idam.sh
```

#### Step 5 - import CCD definition

To import the CCD definition locally, please follow instructions in the sscs-ccd-definitions README. 


### Switching between Idam and Idam Stub Example

```bash
#assuming no containers running and Idam is enabled

#start with Idam
./ccd compose up -d

#services started

./ccd compose stop

#enable Idam Stub follwing the steps in 'Enable Idam Stub'

#start with Idam Stub
./ccd compose up -d

#services started

you also can issue a 'down' when Idam Stub is enabled without risking of losing Idam data, since it's disabled
./ccd compose down

enable Idam following the steps in 'Revert to Idam'

#start with Idam. This will now create new CCD containers and reuse the old Idam ones
./ccd compose up -d
```

NOTE: :warning: always use 'compose up' rather than 'compose start' when switching between Idam and Idam Stub to have docker compose pick up env vars changes.


### Ready for take-off 🛫

You can now visit [http://localhost:3451](http://localhost:3451) (for CCD) or [http://localhost:3455](http://localhost:3455) (for Expert UI).

If not using the idam stub, you can log in using
 
    local.test@example.com
    Pa55word11

### Optional Compose Containers

Optional compose files can be found in the /compose directory. You can enable any of the optional container setups with a command such as:

    ./ccd enable pdf-service-api
    
And then run the following command:

    ./ccd compose up -d

### Replace Callback Urls

To manually replace the callback URLs you can run this script:

    ./gradlew run --args="~/defintions/CCD_SSCSDefinition_v5.1.01_AAT.xlsx url-swaps.yml"

### Import Case Definition

To manually import the case definition you can run this script:

    ./bin/ccd-import-definition.sh ~/defintions/CCD_SSCSDefinition_v5.1.01_AAT.xlsx
    
##Elastic Search

Some parts of the SSCS service require Elastic Search to be running in order to find cases. However, it is not recommended that this is always running as it uses a significant amount of RAM and can cause performance problems on your local environment.

The following use cases need Elastic Search:

- When submitting a case through SYA or Bulk scan, Elastic Search is required for the duplicate case check (same Mrn date/benefit type/nino)
- Logging into MYA (with appeal ref number in link) for an appellant, appointee, rep or joint party
- Linking a case to other similar cases (e.g. same nino, different mrn) for SYA and Bulk scan
- Case loader when it can't find a case by case id so instead uses the GAPS case reference 

### Starting Elastic Search and Logstash for Development

  1.  Set the ES_ENABLED_DOCKER environment variable to true in your `.env` file

  2. Enable Elastic Search and logstash containers by adding `elasticsearch` and `logstash` to `defaults.conf` in SSCS-Docker

  3. Restart all docker containers. (Note: the first time I tried this it did not work and I had to restart my laptop in order for Elastic Search to be picked up)
    
  4. Reimport CCD definition file. When adding a CCD definition file elastic search indexes will be created. To verify, you can hit the elastic search api directly on localhost:9200 with the following command. It will return all stored indexes:
```shell script
curl -X GET http://localhost:9200/benefit_cases-000001
```

Note: if you start elastic search after having existing cases, these cases will not be searchable using ES.

### Useful Elastic Search commands:

The following command will return all cases currently indexed:
```shell script
curl -X GET http://localhost:9200/benefit_cases-000001/_search
```

The following command will return all indices on Elastic Search:
```shell script
curl -X GET http://localhost:9200/_cat/indices
```

This is an example of an Elastic Search query looking for a case reference of 1234: 
```shell script
curl -X GET "localhost:9200/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "reference": "1234"
    }
  }
}
'
```

### CoreCaseDataApi Elastic Search Endpoint
    
You can search on local envs using this endpoint: `localhost:4452/searchCases?ctid=case_type`

An example of a JSON search query which would return any cases where the reference is 1234:
```json
{
    "query": {
        "match" : {
          "reference" : "1234"
        }
    }
}
```

Please see [ES docs - start searching](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-search.html) for more
examples of search queries.

Example curl:
```shell script
curl --location --request POST 'localhost:4452/searchCases?ctid=case_type' \
--header 'Content-Type: application/json' \
--header 'Authorization: <auth-token> \
--header 'ServiceAuthorization: <service-auth-token> \
--data-raw '{
  "query": {
    "match" : {
      "reference" : "1234"
    }
  }
}'
```

Example response:
```json
{
    "total": 1,
    "cases": [
        {
            "id": 1234,
            "jurisdiction": "jurisdiction",
            "state": "Open",
            "version": null,
            "case_type_id": "case_type",
            "created_date": "2020-03-09T16:05:01.742",
            "last_modified": "2020-03-09T16:05:01.745",
            "security_classification": "PUBLIC",
            "case_data": {},
            "data_classification": {
                "creatorId": "PUBLIC"
            },
            "after_submit_callback_response": null,
            "callback_response_status_code": null,
            "callback_response_status": null,
            "delete_draft_response_status_code": null,
            "delete_draft_response_status": null,
            "security_classifications": {
                "creatorId": "PUBLIC"
            }
        }
    ]
}
```

## Bundling

To run the bundling service locally, open up the rpa-em-ccd-orchestrator project and run :

```
./gradlew build
./gradlew installDist
docker-compose build
```

Point the rpa-em-ccd-orchestrator image at:

```
em-ccd-orchestrator_rpa-em-ccd-orchestrator:latest
```

Then restart 'rpa-em-ccd-orchestrator'


### WA Kube Environment ###
The WA Kube Environment is [here](https://github.com/hmcts/wa-kube-environment).
Once it has been setup, we can add users, roles and upload a definition.
```bash
./bin/create-simulator-users.sh # To create SSCS users
./bin/add-sscs-ccd-roles.sh # To add SSCS roles
./bin/ccd-import-definition.sh <Path to definition file> # to upload a CCD definition file
```

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
