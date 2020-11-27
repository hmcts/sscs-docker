#!/bin/sh
##Create all the roles
./bin/idam-client-setup-roles.sh

##Set up client services
./bin/idam-client-setup-service.sh sscs QM5RQQ53LZFOSIXJ
./bin/idam-client-setup-service.sh ccd_gateway ccd_gateway_secret
./bin/idam-client-setup-service.sh xui_webapp xui_webapp_secrect "profile openid roles manage-user create-user"



