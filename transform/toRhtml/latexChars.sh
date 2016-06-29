#!/bin/bash
## replace bad latex characters
sed -i 's/<!ENTITY us "_">/<!ENTITY us "\\_">/g' report.xml
sed -i 's/<!ENTITY tilde "~">/<!ENTITY tilde "\\~{}">/g' report.xml
sed -i 's/<!ENTITY bar "|">/<!ENTITY bar "\\textbar">/g' report.xml
sed -i 's/%/\\%/g' report.xml
sed -i 's/&amp;/\\\&amp;/g' report.xml
sed -i 's/&#x2014;/\\textemdash /g' report.xml
sed -i 's/&#x2013;/\\textendash /g' report.xml

## replace entities
xmllint --noent -o report.xml report.xml
