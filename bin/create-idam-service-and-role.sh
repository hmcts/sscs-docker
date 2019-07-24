IDAM_WEB=http://localhost:8082
xdg-open ${IDAM_WEB}
echo "
Create the sscs service in IDAM. Opening IDAM (${IDAM_WEB}) in browser.

Login to ${IDAM_WEB} - I've opened it in a browser window for you.

=====================================================================================
Username: idamOwner@hmcts.net
Password:  Ref0rmIsFun
=====================================================================================

Create a service (Manage Services) with the following attributes:

=====================================================================================
label: sscs
description: sscs
client_id : sscs
client_secret : QM5RQQ53LZFOSIXJ
client_scope: *
redirect_uri : http://localhost:3000/receiver
=====================================================================================

Create a role (Manage Roles from http://localhost:8082) for the sscs service called:

=====================================================================================
ccd-import
=====================================================================================

Then hit RETURN to continue.
"
read
