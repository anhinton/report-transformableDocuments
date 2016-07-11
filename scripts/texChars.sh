#! /bin/bash
# replace HTML entity values with TeX entity values
sed -i 's/<!ENTITY us "_">/<!ENTITY us "\\_">/' report.xml
sed -i 's/<!ENTITY tilde "~">/<!ENTITY tilde "\\~{}">/' report.xml
sed -i 's/<!ENTITY bar "|">/<!ENTITY bar "\\textbar">/' report.xml
sed -i 's/<!ENTITY mdash "&#x2014;">/<!ENTITY mdash "\\textemdash">/' report.xml
sed -i 's/<!ENTITY ndash "&#x2013;">/<!ENTITY ndash "\\textendash">/' report.xml

# replace all & with \&
sed -i 's/&amp;/\\\&amp;/g' report.xml
