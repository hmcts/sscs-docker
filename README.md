# CCD/SSCS Docker :whale:

## Prerequisites

- [Docker](https://www.docker.com)

*Memory and CPU allocations may need to be increased for successful execution of ccd applications altogether. (On Preferences / Advanced)*

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version 2.0.57 
- [jq Json Processor] (https://stedolan.github.io/jq)

## Quick start

**Note** If you find yourself in a real mess, you can run the following script to clean up all docker images and containers:

```bash
./bin/docker-clean.sh
```

To bring up the containers, run the following from the root directory of the cloned repository:

```bash
./bin/compose-up.sh
```
    
## Using CCD

Once the containers are running, CCD's frontend can be accessed at [http://localhost:3451](http://localhost:3451).

However, some more steps are required to correctly configure SIDAM and CCD before it can be used for SSCS services.

TODO: What is the url for this? on the confluence link is it clear you need to go to the Idam Api section?

### 1. Configure Oauth2 Client of CCD Gateway on SIDAM

An oauth2 client should be configured for ccd-gateway application, on SIDAM Web Admin.
You need to login to the SIDAM Web Admin with the URL and logic credentials here: https://tools.hmcts.net/confluence/x/eQP3P

Navigate to Home > Manage Services > Add a new Service

On the **Add Service** screen the following fields are required for the following two services:
```
label : ccd_gateway
description : ccd_gateway
client_id : ccd_gateway
client_secret : ccd_gateway_secret
redirect_uri : http://localhost:3451/oauth2redirect
```
Define "ccd-import" role (Home > Manage Roles > select your service).
 
### 2. Create Users and SSCS Roles

TODO: This script doesn't seem to add the correct roles
    ./bin/create-users-and-roles.sh

### 3. Import case definition

TODO: This is not correct anymore. Can be multiple callback services
On the CaseEvent tab of the definition spreadsheet, modify the TYA Notification callback URLs to be

    http://dockerhost:8081/send

Then run the following command:
    
```bash
./bin/ccd-import-definition.sh <path_to_definition>
```

**Note:** For CCD to work, the definition must contain the caseworker's email address created at step 2.

### Ready for take-off 🛫

Back to [http://localhost:3451](http://localhost:3451), you can now log in using your email and password `Pa55word11`.

## Enabling and Disabling Services

You can enable and disable containers using a command such as:

```bash
./ccd enable sscs-tribunals-case-api
```

You can see, and modify these in the .tags.env file if you prefer that to using the ./ccd enable and disable commands.

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.