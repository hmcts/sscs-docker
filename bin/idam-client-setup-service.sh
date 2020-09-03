#!/bin/sh

IDAM_URI="http://localhost:5000"
REDIRECT_URI="http://localhost:3451/oauth2redirect"
CLIENT_ID=${1:-ccd_gateway}
CLIENT_SECRET=${2:-ccd_gateway_secret}

authToken=$(curl -v -H 'Content-Type: application/x-www-form-urlencoded' -XPOST "${IDAM_URI}/loginUser?username=idamOwner@hmcts.net&password=Ref0rmIsFun" | jq -r .api_auth_token)

echo "authtoken is ${authToken}"

#Create a client
curl -XPOST \
  ${IDAM_URI}/services \
 -H "Authorization: AdminApiAuthToken ${authToken}" \
 -H "Content-Type: application/json" \
 -d '{ "activationRedirectUrl": "", "allowedRoles": ["ccd-import", "caseworker", "caseworker-sscs", "caseworker-sscs-systemupdate", "caseworker-sscs-clerk", "caseworker-sscs-anonymouscitizen", "caseworker-sscs-callagent", "caseworker-sscs-judge", "caseworker-sscs-dwpresponsewriter", "caseworker-sscs-registrar", "caseworker-sscs-superuser", "caseworker-sscs-panelmember", "caseworker-sscs-bulkscan"], "description": "'${CLIENT_ID}'", "label": "'${CLIENT_ID}'", "oauth2ClientId": "'${CLIENT_ID}'", "oauth2ClientSecret": "'${CLIENT_SECRET}'", "oauth2RedirectUris": ["http://localhost:3451/oauth2redirect", "http://localhost:3000/sign-in", "http://localhost:3002/oauth2/callback", "https://localhost:3000/authenticated", "http://localhost:4502/authenticated"], "oauth2Scope": "string", "onboardingEndpoint": "string", "onboardingRoles": ["ccd-import", "caseworker", "caseworker-sscs", "caseworker-sscs-systemupdate", "caseworker-sscs-clerk", "caseworker-sscs-anonymouscitizen", "caseworker-sscs-callagent", "caseworker-sscs-judge", "caseworker-sscs-dwpresponsewriter", "caseworker-sscs-registrar", "caseworker-sscs-superuser", "caseworker-sscs-panelmember", "caseworker-sscs-bulkscan"], "selfRegistrationAllowed": true}'

#Assign all the roles to the client
curl -XPUT \
  ${IDAM_URI}/services/${CLIENT_ID}/roles \
 -H "Authorization: AdminApiAuthToken ${authToken}" \
 -H "Content-Type: application/json" \
 -d '["ccd-import", "caseworker", "caseworker-sscs", "caseworker-sscs-systemupdate", "caseworker-sscs-clerk", "caseworker-sscs-anonymouscitizen", "caseworker-sscs-callagent", "caseworker-sscs-judge", "caseworker-sscs-dwpresponsewriter", "caseworker-sscs-registrar", "caseworker-sscs-superuser", "caseworker-sscs-panelmember", "caseworker-sscs-bulkscan"]'

