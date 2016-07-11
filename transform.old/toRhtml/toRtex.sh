## create .tex document
xsltproc -o $HOME/uoastorage/openapi/documentation/report/report.Rtex \
    $HOME/uoastorage/openapi/documentation/report/xsl/toRtex.xsl \
    report.xml
