# CCD Docker :whale:

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

Checkout `sscs-docker` project:

```bash
git clone git@github.com:hmcts/sscs-docker.git
```

Get into the root of the repo:

```bash
cd sscs-docker
```

Login to the Azure Container registry:

```bash
./ccd login
```

Pulling latest Docker images:

```bash
./ccd compose pull
```

Creating and starting the containers:

```bash
./bin/compose-up.sh
```

## Setting up environment variables
Environment variables for CCD Data Store API and CCD Definition Store API can be done by executing the following script.

#### Mac or Linux

    source ./bin/set-environment-variables.sh
    
#### Windows

***Note*** This command may appear to work on a Mac/Linux machine, but it won't set the env vars in the current shell, so please use
the above "source" command for Mac and Linux.

    ./bin/set-environment-variables.sh
    
## Using CCD

Once the containers are running, CCD's frontend can be accessed at [http://localhost:3451](http://localhost:3451).

However, seven more steps are required to correctly configure SIDAM and CCD before it can be used for SSCS services.

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

    ./bin/idam-create-caseworker.sh ccd-import ccd.docker.default@hmcts.net Pa55word11 Default CCD_Docker
    ./bin/add-sscs-ccd-roles.sh
    ./bin/idam-create-caseworker.sh caseworker-sscs-systemupdate,caseworker-sscs,caseworker-sscs-callagent example@hmcts.net
    ./bin/idam-create-caseworker.sh citizen sscs-citizen@hmcts.net

### 3. Import case definition

On the CaseEvent tab of the definition spreadsheet, modify the TYA Notification callback URLs to be

    http://dockerhost:8081/send

Then run the following command:
    
```bash
./bin/ccd-import-definition.sh <path_to_definition>
```

**Note:** For CCD to work, the definition must contain the caseworker's email address created at [step 1](#1-create-a-caseworker-user).

If the import fails with an error of the form:

```
Validation errors occurred importing the spreadsheet.

- Invalid IdamRole 'caseworker-cmc-loa1' in AuthorisationCaseField tab, case type 'MoneyClaimCase', case field 'submitterId', crud 'CRUD'
```

Then the indicated role, here `caseworker-cmc-loa1`, must be added to CCD (See [2. Add roles](#2-add-roles)).

### Ready for take-off 🛫

Back to [http://localhost:3451](http://localhost:3451), you can now log in with the email and password defined at [step 1](#1-create-a-caseworker-user).
If you left the password out when creating the caseworker, by default it's set to: `Pa55word11`.

## Enabling and Disabling Services

You can enable and disable containers using a command such as:

```bash
./ccd enable sscs-tribunals-case-api
```

You can see, and modify these in the .tags.env file if you prefer that to using the ./ccd enable and disable commands.

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.