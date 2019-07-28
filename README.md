# CCD/SSCS Docker :whale:

## Prerequisites

- [Docker](https://www.docker.com)

*Memory and CPU allocations may need to be increased for successful execution of ccd applications altogether. (On Preferences / Advanced)*

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version 2.0.57 
- [jq Json Processor] (https://stedolan.github.io/jq)

## Before you start

In order to authenticate successfully with the local SIDAM, I needed to change the oauth2 username and password from in the sscs-tribunals-case-api local defaults from SSCS_SYSTEM_UPDATE to:

    idam.oauth2.user.email=christopher.moreton@hmcts.net
    idam.oauth2.user.password=Pa55word11
    
You will need to do the same for your email address. I think a better solution here is to add a system update user email address to the CCD definition
so that we use the committed defaults in the application.properties file.

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

### 1. Configure Oauth2 Client of CCD Gateway on SIDAM

***Note*** If you're feeling ambitious, there is a Selenium script in the ***tools*** folder which can be run on a Selenium client such as [Qualys Browser Recorder](https://chrome.google.com/webstore/detail/qualys-browser-recorder/abnnemjpaacaimkkepphpkaiomnafldi).
Using that script will perform all the actions in this section. This should be updated to run on from the command line using Selenium RC in a future update.
 
Login to the IDAM web admin at [http://localhost:8082/login](http://localhost:8082/login) with the following credentials:

    Username: idamOwner@hmcts.net
    Password: Ref0rmIsFun

Navigate to Home > Manage Services > Add a new Service

On the **Add Service** screen the following fields are required for the following two services:
```
label : ccd_gateway
description : ccd_gateway
client_id : ccd_gateway
client_secret : ccd_gateway_secret
redirect_uri : http://localhost:3451/oauth2redirect
```

```
label : sscs
description : sscs
client_id : sscs
client_secret : QM5RQQ53LZFOSIXJ
redirect_uri : https://localhost:3000/authenticated
```

Define the following role for ccd_gateway service (Home > Manage Roles > ccd_gateway):

* ccd-import

<hr>

![Adding the ccd-import role](img/create-ccd-import-role.png "Adding the ccd-import role")

<hr>

Define the following roles for sscs service (Home > Manage Roles > sscs):

* caseworker-sscs
* caseworker-sscs-systemupdate
* caseworker-sscs-clerk
* caseworker
* caseworker-sscs-anonymouscitizen
* caseworker-sscs-callagent
* caseworker-sscs-judge
* caseworker-sscs-dwpresponsewriter
* caseworker-sscs-registrar
* caseworker-sscs-superuser
* caseworker-sscs-panelmember
* caseworker-sscs-bulkscan


### 2. Create Users and SSCS Roles

    ./bin/create-users-and-roles.sh

### 3. Import case definition

Run the following command for your SSCS and Bulk Scan definition spreadsheets.
    
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