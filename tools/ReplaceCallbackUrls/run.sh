#!/usr/bin/env bash
source ../../.env
java -cp "poi-4.1.0/*:poi-4.1.0/ooxml-lib/*:poi-4.1.0/lib/*:." ReplaceCallbackUrls $CCD_CASE_DEFINITION_XLS
java -cp "poi-4.1.0/*:poi-4.1.0/ooxml-lib/*:poi-4.1.0/lib/*:." ReplaceCallbackUrls $CCD_BULK_SCAN_CASE_DEFINITION_XLS
