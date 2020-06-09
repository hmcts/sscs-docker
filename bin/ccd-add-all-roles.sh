#!/bin/bash
binFolder=$(dirname "$0")

(${binFolder}/idam-create-caseworker.sh ccd-import ccd.docker.default@hmcts.net Pa55word11 Default CCD_Docker)
(${binFolder}/idam-create-caseworker.sh citizen testusername@test.com)
(${binFolder}/idam-create-caseworker.sh citizen reyabik385@upcmaill.com)

(${binFolder}/idam-create-caseworker.sh citizen testusername@test.com)



