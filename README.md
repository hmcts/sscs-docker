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

## Quick start

First...

	cp .env.example .env

Then make the necessary changes at the top of the file.

***Note*** If you find yourself in a bit of a mess, you may want to destroy all your containers and images with the following command. This will make bringing it all up again slower as it will need to download the images again.

```bash
./bin/docker-clean.sh
```

### Bringing it up

To bring up the containers, run the following from the root directory of the cloned repository:

```bash
./bin/compose-up.sh
```

### Ready for take-off 🛫

If all went well, the above script will have performed the following tasks:

* Pulled the latest docker images
* Bring up the docker containers using docker-compose
* Created the SIDAM services and roles using a Selenium script against SIDAM admin frontend.
* Created the import user and the caseworker user specified in the .env file
* Replace the AAT callback URLS in the CCD defintions to point to local services
* Imported the CCD defintions specified in the .env file

You can now visit [http://localhost:3451](http://localhost:3451), you can log in using
 
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

### Starting Elastic Search for Development

- Set the ES_ENABLED_DOCKER environment variable to true in your `.env` file

- By default, ccd-logstash filters out SSCS cases. Therefore, we need to point logstash to the sscs config, build a local docker image and point sscs-docker at this new ccd-logstash image. To do this:
  
  1. Check out the https://github.com/hmcts/ccd-logstash project
  
  2. Change this line: https://github.com/hmcts/ccd-logstash/blob/master/Dockerfile#L3 to `ARG conf=ccdsscs_logstash.conf.in`
  
  3. Build the local docker image using `docker build -t ccd/sscs-logstash:1.0 .` This should create an image called ccd/sscs-logstash:1.0
  
  4. Update your ccd-logstash to use this local image by going to `elasticsearch.yaml` and setting the image to `image: "ccd/sscs-logstash:1.0"`
  
- Enable Elastic Search and logstash containers by adding `elasticsearch` to `tags.env`

- Restart all docker containers. (Note: the first time I tried this it did not work and I had to restart my laptop in order for Elastic Search to be picked up)
    
- When adding a CCD definition file elastic search indexes will be created. To verify, you can hit the elastic search api directly on localhost:9200 with the following command. It will return all stored indexes:
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

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
