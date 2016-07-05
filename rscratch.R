library(XML)
document <- xmlRoot(xmlParse("transformableDocuments.xml"))

nodeNames <- function(node) {
    kids <- xmlChildren(node)
    names <- sapply(kids, nodeNames)
    names <- c(names, names(kids))
    names
}

body <- xmlChildren(document)[["body"]]

allNames <- nodeNames(body)
allNames <- unlist(allNames)
unique(allNames)
