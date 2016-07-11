## references paragraphs
library(XML)
document <- xmlParse("references.html")
refId <- xpathApply(
    document,
    "//p|//a",
    function (x) {
        xmlAttrs(x) <- c(class = "references")
    })
saveXML(document, "~/uoastorage/openapi/documentation/report/references.html")
