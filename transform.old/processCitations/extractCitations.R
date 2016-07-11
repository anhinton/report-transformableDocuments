library(XML)
document <- xmlRoot(xmlParse(
    "~/uoastorage/openapi/documentation/report/report.xml"))
citations <- xpathSApply(
    doc = document,
    path = "//cite",
    function (x) {
        attrs <- xmlAttrs(x)
        key <- attrs[["key"]]
        key
    })
citations <- paste("    ", citations, sep = "@")
citations <- c("---", "nocite: |", citations, "---")
writeLines(text = citations, con = "citations.txt")
