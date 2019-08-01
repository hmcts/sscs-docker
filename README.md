# CCD/SSCS Docker :whale:

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version 2.0.57 
- [jq Json Processor] (https://stedolan.github.io/jq)
- [Docker](https://www.docker.com)

You can increase the memory available to Docker from the Preferences|Advanced options on your Docker installation.

Tested on

| Operating System | Processor | RAM | Allocated to Docker  | 
|---|---|---|---|
| OSX | 2.6Ghz i7  | 16g | 8g |
| Ubuntu  | i7-8750H | 32g | 32g |

## Quick start

### Bringing down an existing setup

#### 1. The Regular Way

```bash
./ccd compose down
```

#### 2. The Brute Force Option

If you find yourself in a bit of a mess, you may want to destroy all your containers and images with the following command. This will make bringing it all up again
slower as it will need to download the images again.

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

You can now visit [http://localhost:3451](http://localhost:3451), you can now log in using the email address defined in the .env file (HMCTS_EMAIL_ADDRESS) along with the password `Pa55word11`.

### Optional Compose Containers

Optional compose files can be found in the /compose directory. You can enable any of the optional container setups with a command such as:

    ./ccd enable pdf-service-api
    
And then run the following command:

    ./ccd compose up -d
    
## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.