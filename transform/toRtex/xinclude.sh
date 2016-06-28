#!/bin/bash
## copy report.xml to $PWD and do xinclude
xmllint --xinclude -o $PWD/report.xml \
    ~/uoastorage/openapi/documentation/report/report.xml
