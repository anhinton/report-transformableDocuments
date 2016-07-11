#!/usr/bin/Rscript
library(XML)
document <- xmlParse("report.xml")
commentedCode <- xpathApply(
    document,
    "//pre[@class='knitr']",
    function(x) {
        con <- textConnection(xmlValue(x))
        value <- readLines(con)
        close(con)
        value <- paste("%", value, collapse = "\n")
        xmlValue(x) <- value
    })

saveXML(document, "report.xml")
