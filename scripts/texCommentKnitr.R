#! /usr/bin/Rscript
library(XML)
report <- xmlRoot(xmlParse("report.xml"))

## add TeX comment to start of knitr code lines
knitrNodes <- xpathApply(doc = report, path = "//code[@class='knitr']",
    fun = function (x) {
        nodeAttrs <- xmlAttrs(x)
        newNode <- newXMLNode(name = "code", attrs = nodeAttrs, parent = NULL)
        nodeValue <- newXMLCDataNode(
            text = paste0("% ", gsub("\n", "\n% ", xmlValue(x))),
            parent = newNode)
        replaceNodes(x, newNode)
    })

saveXML(doc = report, file = "report.xml")
