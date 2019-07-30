# CCD/SSCS Docker :whale:

## Prerequisites

- [Docker](https://www.docker.com)

*Memory and CPU allocations may need to be increased for successful execution of ccd applications altogether. (On Preferences / Advanced)*

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version 2.0.57 
- [jq Json Processor] (https://stedolan.github.io/jq)

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

Back to [http://localhost:3451](http://localhost:3451), you can now log in using the email address defined in the .env file (HMCTS_EMAIL_ADDRESS) along with the password `Pa55word11`.

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.