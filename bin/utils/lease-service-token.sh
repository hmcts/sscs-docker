#!/usr/bin/env bash

set -eu
serviceAuthProviderUrl=${SERIVE_AUTH_PROVIDER_URL:-localhost:4502}
microservice=${1:-ccd_gw}

curl --insecure --fail --show-error --silent -X POST \
  ${SERVICE_AUTH_PROVIDER_API_BASE_URL:-"${serviceAuthProviderUrl}"}/testing-support/lease \
  -H "Content-Type: application/json" \
  -d '{
    "microservice": "'${microservice}'"
  }' \
  -w "\n"
  
