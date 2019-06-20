# CCD Docker :whale:

- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Using CCD](#using-ccd)
- [Compose branches](#compose-branches)
- [Compose projects](#compose-projects)
- [Under the hood](#under-the-hood-speedboat)
- [Containers](#containers)
- [Local development](#local-development)
- [Variables](#variables)
- [Remarks](#remarks)
- [License](#license)

## Prerequisites

- [Docker](https://www.docker.com)
- [Docker Compose](https://docs.docker.com/compose/)

*The following documentation assumes that the current directory is `sscs-docker`.*

## Quick start

Checkout `sscs-docker` project:

```bash
git clone git@github.com:hmcts/sscs-docker.git
```

Create the .env file

```bash
cd sscs-docker
cp .env.example .env
```

Populate the following keys in the .env file

```
HMCTS_EMAIL_ADDRESS=
CCD_CASE_DEFINITION_XLS=
```

There are also some optional keys that can be populated.

The case definition file can be found on Confluence at [https://tools.hmcts.net/confluence/display/SSCS/Case+Definitions](https://tools.hmcts.net/confluence/display/SSCS/Case+Definitions)

You will need to add your email address to the UserProfile tab.

Run the build script

```bash
./clean-and-build.sh
```

The script will pull the latest images and create the Docker environment. It will wait for the containers to be healthy and will keep attempting to create the CCD roles until it succeeds (even when the containers are healthy, it takes a while before they are ready).

## Callbacks to host machine

To reference the host machine from within a docker container, use http://dockerhost[:port]/

## Additional Information

The following information explains the process that the clean and build script goes through.

Pulling latest Docker images:

```bash
./ccd enable frontend backend dm-store
./ccd compose pull
```

Creating and starting the containers:

NOTE: Include the --build argument only the first time you run the command. It should be omitted on subsequent runs.

```bash
./ccd compose up --build -d
```

Create Blob Store in Azurite:

```bash
./bin/document-management-store-create-blob-store-container.sh
```

Initialise the DB
```bash
sh ./database/init-db.sh
```

If necessary, you can create the evidence database manually by entering the Postgres command line of the container:

```bash
docker exec -ti compose_ccd-shared-database_1 psql -U postgres -c "CREATE DATABASE evidence;"
```

Usage and commands available:

```bash
./ccd
```

You can check the status of the containers with:

```
./ccd compose ps
```

## Using CCD

Once the containers are running, CCD's frontend can be accessed at [http://localhost:3451](http://localhost:3451).

However, 3 more steps are required to correctly configure IDAM and CCD before it can be used:

### 1. Create a caseworker user

A caseworker user can be created in IDAM using the following command:

```bash
./bin/idam-create-caseworker.sh <roles> <email> [password] [surname] [forename]
```

Parameters:
- `roles`: a comma-separated list of roles. Roles must be existing IDAM roles for the CCD domain. Every caseworker requires at least it's coarse-grained jurisdiction role (`caseworker-<jurisdiction>`).
- `email`: Email address used for logging in.
- `password`: Optional. Password for logging in. Defaults to `password`.

For SSCS, use the following command:

```bash
./bin/idam-create-caseworker.sh caseworker-sscs,caseworker-sscs-systemupdate,caseworker-sscs-anonymouscitizen,caseworker-sscs-callagent,caseworker-sscs-judge,citizen,caseworker-sscs-clerk,caseworker-sscs-dwpresponsewriter,caseworker-sscs-bulkscan <your.email@hmcts.net>
```

### 2. Add roles

Before a definition can be imported, roles referenced in a case definition Authorisation tabs must be defined in CCD using:

```bash
./bin/ccd-add-role.sh <role> [classification]
```

Parameters:
- `role`: Name of the role, e.g: `caseworker-divorce`.
- `classification`: Optional. One of `PUBLIC`, `PRIVATE` or `RESTRICTED`. Defaults to `PUBLIC`.

For SSCS:

```bash
./bin/ccd-add-role.sh caseworker-sscs
./bin/ccd-add-role.sh caseworker-sscs-systemupdate
./bin/ccd-add-role.sh caseworker-sscs-anonymouscitizen
./bin/ccd-add-role.sh caseworker-sscs-callagent
./bin/ccd-add-role.sh caseworker-sscs-judge
./bin/ccd-add-role.sh caseworker-sscs-panelmember PRIVATE
./bin/ccd-add-role.sh citizen
./bin/ccd-add-role.sh caseworker-sscs-clerk
./bin/ccd-add-role.sh caseworker-sscs-dwpresponsewriter
./bin/ccd-add-role.sh caseworker-sscs-registrar
./bin/ccd-add-role.sh caseworker-sscs-superuser
./bin/ccd-add-role.sh caseworker-sscs-teamleader
./bin/ccd-add-role.sh caseworker-sscs-bulkscan
```

### 3. Import case definition

To reduce impact on performances, case definitions are imported via the command line rather than using CCD's dedicated UI:

```bash
./bin/ccd-import-definition.sh <path_to_definition>
```

Parameters:
- `path_to_definition`: Path to `.xlsx` file containing the case definition.

**Note:** For CCD to work, the definition must contain the caseworker's email address created at [step 1](#1-create-a-caseworker-user).

If the import fails with an error of the form:

```
Validation errors occurred importing the spreadsheet.

- Invalid IdamRole 'caseworker-cmc-loa1' in AuthorisationCaseField tab, case type 'MoneyClaimCase', case field 'submitterId', crud 'CRUD'
```

Then the indicated role, here `caseworker-cmc-loa1`, must be added to CCD (See [2. Add roles](#2-add-roles)).

### Ready for take-off 🛫

Back to [http://localhost:3451](http://localhost:3451), you can now log in with the email and password defined at [step 1](#1-create-a-caseworker-user).
If you left the password out when creating the caseworker, by default it's set to: `password`.

## Compose branches

By default, all CCD containers are running with the `latest` tag, built from the `master` branch.

### Switch to a branch

Using the `set` command, branches can be changed per project.

Usage of the command is:

```bash
./ccd set <project> <branch>
```

* `<project>` must be one of:
  * ccd-data-store-api
  * ccd-definition-store-api
  * ccd-user-profile-api
  * ccd-api-gateway
  * ccd-case-management-web
* `<branch>` must be an existing **remote** branch for the selected project.

Branches for a project can be listed using:

```bash
./ccd branches <project>
```

### Apply

When switching to a branch, a Docker image is built locally and the Docker compose configuration is updated.

However, to make that configuration effective, the Docker containers must be updated using:

```bash
./ccd compose up -d
```

### Revert to `master`

When a project has been switched to a branch, it can be reverted to `master` in 2 ways:

```bash
./ccd set <project> master
```

or

```bash
./ccd unset <project> [<projects...>]
```

The only difference is that `unset` allows for multiple projects to be reset to `master`.

In both cases, like with the `set` command, for the reset to be effective it requires the containers to be updated:

```bash
./ccd compose up -d
```

### Current branches

To know which branches are currently used, the `status` command can be used:

```bash
./ccd status
```

The 2nd part of the output indicates the current branches.
The output can either be of the form:

> No overrides, all using master

when no branches are used; or:

> Current overrides:
> ccd-case-management-web branch:RDM-2414 hash:ced648d

when branches are in use.

:information_source: *In addition to the `status` command, the current status is also displayed for every `compose` commands.*

## Compose projects

By default, `ccd-docker` runs the most commonly used backend and frontend projects required:

* Back-end:
  * **idam-api**: Identity and access control
  * **service-auth-provider-api**: Service-to-service security layer
  * **ccd-user-profile-api**: Users/jurisdictions association and usage preferences
  * **ccd-definition-store-api**: CCD's dynamic case definition repository
  * **ccd-data-store-api**: CCD's cases repository
* Front-end:
  * **authentication-web**: IDAM's login UI
  * **ccd-api-gateway**: Proxy with IDAM and S2S integration
  * **ccd-case-management-web**: Caseworker UI

In the future, optional compose files will allow other projects to be enabled on demand using the `enable` and `disable` commands.

* To enable **document-management-store-app**
  * `./ccd enable backend frontend dm-store`
  * run docker-compose `./ccd compose up -d`
  * create Blob Store in Azurite `./bin/document-management-store-create-blob-store-container.sh`

## Under the hood :speedboat:

### Set

#### Non-`master` branches

When switching to a branch with the `set` command, the following actions take place:

1. The given branch is cloned in the temporary `.workspace` folder
2. If required, the project is built
3. A docker image is built
4. The Docker image is tagged as `hmcts/<project>:<branch>-<git hash>`
5. An entry is added to file `.tags.env` exporting an environment variable `<PROJECT>_TAG` with a value `<branch>-<git hash>` matching the Docker image tag

The `.tags.env` file is sourced whenever the `ccd compose` command is used and allows to override the Docker images version used in the Docker compose files.

Hence, to make that change effective, the containers must be updated using `./ccd compose up`.

#### `master` branch

When switching a project to `master` branch, the branch override is removed using the `unset` command detailed below.

### Unset

Given a list of 1 or more projects, for each project:

1. If `.tags.env` contains an entry for the project, the entry is removed

Similarly to when branches are set, for a change to `.tags.env` to be applied, the containers must be updated using `./ccd compose up`.

### Status

Retrieve from `.tags.env` the branches and compose files currently enabled and display them.

### Compose

```bash
./ccd compose [<docker-compose command> [options]]
```

The compose command acts as a wrapper around `docker-compose` and accept all commands and options supported by it.

:information_source: *For the complete documentation of Docker Compose CLI, see [Compose command-line reference](https://docs.docker.com/compose/reference/).*

Here are some useful commands:

#### Up

```bash
./ccd compose up [-d]
```

This command:
1. Create missing containers
2. Recreate outdated containers (= apply configuration changes)
3. Start all enabled containers

The `-d` (detached) option start the containers in the background.

#### Down

```bash
./ccd compose down [-v] [project]
```

This stops and destroys all composed containers.

If provided, the `-v` option will also clean the volumes.

Destroyed containers cannot be restarted. New containers will need to be built using the `up` command.

#### Ps

```bash
./ccd compose ps [<project>]
```

Gives the current state of all or specified composed projects.

#### Logs

```bash
./ccd compose logs [-f] [<project>]
```

Displays the logs for all or specified composed projects.

The `-f` (follow) option allows to follow the tail of the logs.

#### Start/stop

```bash
./ccd compose start [<project>]
./ccd compose stop [<project>]
```

Start or stop all or specified composed containers. Stopped containers can be restarted with the `start` command.

:warning: Please note: Re-starting a project with stop/start does **not** apply configuration changes. Instead, the `up` command should be used to that end.

#### Pull

```bash
./ccd compose pull [project]
```

Fetch the latest version of an image from its source. For the new version to be used, the associated container must be re-created using the `up` command.

### Configuration

#### OAuth 2

OAuth 2 clients must be explicitly declared in service `idam-api` with their ID and secret.

A client is defined as an environment variable complying to the pattern:

```yml
environment:
  IDAM_API_OAUTH2_CLIENT_CLIENT_SECRETS_<CLIENT_ID>: <CLIENT_SECRET>
```

The `CLIENT_SECRET` must then also be provided to the container used by the client service.

:information_source: *To prevent duplication, the client secret should be defined in the `.env` file and then used in the compose files using string interpolation `"${<VARIABLE_NAME>}"`.*

#### Service-to-Service

Micro-services names and secret keys must be registered as part of `service-auth-provider-api` configuration by adding environment variables like:

```yml
environment:
  MICROSERVICEKEYS_<SERVICE_NAME>: <SERVICE_SECRET>
```

The `SERVICE_SECRET` must then also be provided to the container running the micro-service.

:information_source: *To prevent duplication, the client secret should be defined in the `.env` file and then used in the compose files using string interpolation `"${<VARIABLE_NAME>}"`.*

## Containers

### Back-end

#### ccd-definition-store-api

Store holding the case type definitions, which are a case's states, events and schema as well as its display configuration for rendering in CCD's UI.

#### ccd-data-store-api

Store where the versioned instances of cases are recorded.

#### ccd-user-profile-api

Display preferences for the CCD users.

### Front-end

#### ccd-api-gateway

API gateway securing interactions between `ccd-case-management-web` and the back-end services.

#### ccd-case-management-web

Caseworker frontend, exposed on port `3451`.

## Local development

The provided Docker compose files can be used to get up and running for local development.

However, while working, it is more convenient to run a project directly on the localhost rather than having to rebuild a docker image and a container.
This means mixing a locally-run project, the one being worked on, with projects running in Docker containers.

Given their unique configuration and dependencies, the way to achieve this varies slightly from one project to the other.

Here's the overall approach:

### 1. Update containers to point to local project

As is, the containers are configured to use one another.
Thus, the first step to replace a container by a locally running instance is to update all references to this container in the compose files.

For instances, to use a local data store, references in `ccd-api-gateway` service (file `compose/frontend.yml`) must be changed from:

```yml
PROXY_AGGREGATED: http://ccd-data-store-api:4452
PROXY_DATA: http://ccd-data-store-api:4452
```

to, for Mac OS:

```yml
PROXY_AGGREGATED: http://docker.for.mac.localhost:4452
PROXY_DATA: http://docker.for.mac.localhost:4452
```

or to, for Windows:

```yml
PROXY_AGGREGATED: http://docker.for.win.localhost:4452
PROXY_DATA: http://docker.for.win.localhost:4452
```

The `docker.for.mac.localhost` and `docker.for.win.localhost` hostnames point to the host computer (your localhost running Docker).

For other systems, the host IP address could be used.

Once the compose files have been updated, the new configuration can be applied by running:

```
./ccd compose up -d
```

### 2. Configure local project to use containers

The local project properties must be reviewed to use the containers and comply to their configuration.

Mainly, this means:
- **Database**: pointing to the locally exposed port for the associated DB
- **IDAM**: pointing to the locally exposed port for IDAM
- **S2S**:
  - pointing to the locally exposed port for `service-auth-provider-api`
  - :warning: using the right key, as defined in `service-auth-provider-api` container
- **URLs**: all URLs should be updated to point to the corresponding locally exposed port

#### Azure Authentication for pulling latest docker images
- ERROR: Get <docker_image_url>: unauthorized: authentication required
    - If you see this above authentication issue while pulling images, please follow below commands,

Install Azure-CLI locally,

```brew update && brew install azure-cli```

and to update a Azure-CLI locally,

```brew update azure-cli```

then, login to MS Azure,

```az login```

and finally, Login to the Azure Container registry:

```./ccd login```

#### Configure tribunal API to work with the sscs-docker containers
- Bring Down the tribunal api container manually.
- Add the following entry to the file /etc/hosts:
  - ```127.0.0.1 dm-store```
- Update the following property to the application.yaml file in the tribunal api service:  
  - ```document_management.url=${DOCUMENT_MANAGEMENT_URL:http://dm-store:4506}```
- Bring up the tribunal api service
- Now you should be able to submit appeals with a piece of evidence successfully.

## Accessing documents saved to Azurite Emulator

You can get a list of saved documents by one of the following methods.

A request to
```
  http://127.0.0.1:10000/devstoreaccount1/hmctstestcontainer?restype=container&comp=list
```
Or a call to

```
docker exec -ti compose_azure-storage-emulator-azurite_1 sh -c "ls -la folder/__blobstorage__"
```
The first method will give you more information to identify which document is the one you are interested in.

Once you have the ID of the document you want - e.g. **BeJEPk_duYpK64E2KhpboF0nL40=**, you can grab the file to your local machine using:
```
docker cp compose_azure-storage-emulator-azurite_1:/opt/azurite/folder/__blobstorage__/BeJEPk_duYpK64E2KhpboF0nL40= filename.xlsx
```

## Variables
Here are the important variables exposed in the compose files:

| Variable | Description |
| -------- | ----------- |
| IDAM_KEY_CCD_DATA_STORE | IDAM service-to-service secret key for `ccd_data` micro-service (CCD Data store), as registered in `service-auth-provider-api` |
| IDAM_KEY_CCD_GATEWAY | IDAM service-to-service secret key for `ccd_gw` micro-service (CCD API Gateway), as registered in `service-auth-provider-api` |
| IDAM_KEY_CCD_DEFINITION_STORE | IDAM service-to-service secret key for `ccd_definition` micro-service (CCD Definition store), as registered in `service-auth-provider-api` |
| IDAM_KEY_CCD_ADMIN | IDAM service-to-service secret key for `ccd_admin` micro-service (CCD Admin Web), as registered in `service-auth-provider-api` |
| DATA_STORE_S2S_AUTHORISED_SERVICES | List of micro-service names authorised to call this service, comma-separated, as registered in `service-auth-provider-api` |
| DEFINITION_STORE_S2S_AUTHORISED_SERVICES | List of micro-services authorised to call this service, comma-separated, as registered in `service-auth-provider-api` |
| USER_PROFILE_S2S_AUTHORISED_SERVICES | List of micro-services authorised to call this service, comma-separated, as registered in `service-auth-provider-api` |
| DATA_STORE_TOKEN_SECRET | Secret for generation of internal event tokens |
| APPINSIGHTS_INSTRUMENTATIONKEY | Secret for Microsoft Insights logging, can be a dummy string in local |
| STORAGEACCOUNT_PRIMARY_CONNECTION_STRING | (If dm-store is enabled) Secret for Azure Blob Storage. It is pointing to dockerized Azure Blob Storage emulator. |
| STORAGE_CONTAINER_DOCUMENT_CONTAINER_NAME | (If dm-store is enabled) Container name for Azure Blob Storage |

## Remarks

- A container can be configured to call a localhost host resource with the localhost shortcut added for docker containers recently. However the shortcut must be set according the docker host operating system.

```bash
# for Mac
docker.for.mac.localhost
# for Windows
docker.for.win.localhost
```

Remember that once you changed the above for a particular app you have to make sure the container configuration for that app does not try to automatically start the dependency that you have started locally. To do that either comment out the entry for the locally running app from the **depends_on** section of the config or start the app with **--no-deps** flag.

- If you happen to run `docker-compose up` before setting up the environment variables, you will probably get error while starting the DB. In that
case, clear the containers but also watch out for volumes created to be cleared to get a fresh start since some initialisation scripts don't run if
you have already existing volume for the container.

```bash
$ docker volume list
DRIVER              VOLUME NAME

# better be empty
```

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
