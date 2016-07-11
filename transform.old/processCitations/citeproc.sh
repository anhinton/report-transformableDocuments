#!/bin/bash
pandoc --filter=pandoc-citeproc \
       --bibliography=$HOME/uoastorage/openapi/documentation/report/bibliography.bib \
       --csl=$HOME/uoastorage/openapi/documentation/report/apa.csl \
       -o references.html \
       citations.txt
