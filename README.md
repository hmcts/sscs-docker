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

### Ready for take-off 🛫

Back to [http://localhost:3451](http://localhost:3451), you can now log in using the email address defined in the .env file (HMCTS_EMAIL_ADDRESS) along with the password `Pa55word11`.

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.