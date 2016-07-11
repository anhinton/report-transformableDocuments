### Create transformation pipelines for report
#library(conduit)
library(devtools)
load_all("~/uoastorage/openapi/conduit")

## xinclude <- loadModule("xinclude", "transform/xinclude.xml")

knitToHtml <- loadModule("knitToHtml", "transform/knitToHtml.xml")

transform <- loadPipeline(name = "transform", ref = "transform/pipeline.xml")

## convertToRhtml <- transform$components$convertToRhtml$value

## modRes1 <- runModule(convertToRhtml,
##                      targetDirectory = tempdir(),
##                      inputObject =
##                          list(report = file.path(getwd(), "report.xml")))

pplRes1 <- runPipeline(transform, targetDirectory = tempdir())
