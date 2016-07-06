### Create transformation pipelines for report
library(conduit)

xinclude <- module(
    name = "xinclude",
    language = moduleLanguage("bash"),
    description = "Process XInclude nodes",
    inputs = list(
        report = moduleInput(
            name = "report",
            vessel = fileVessel("report.xml"),
            format = ioFormat("XML file")),
        metadataExample =  moduleInput(
            name = "metadataExample",
            vessel = fileVessel("metadataExample.xml"),
            format = ioFormat("XML file")),
        knitrExample = moduleInput(
            name = "knitrExample",
            vessel = fileVessel("knitrExample.xml"),
            format = ioFormat("XML file"))),
    sources = list(
        moduleSource(vessel = scriptVessel(readLines("scripts/xinclude.sh")))),
    outputs = list(
        report = moduleOutput(
            name = "report",
            vessel = fileVessel("report.xml"),
            format = ioFormat("XML file"))))

#res1 <- runModule(xinclude, targetDirectory = tempdir())
substituteEntities <- module(
    name = "substituteEntities",
    language = moduleLanguage("bash"),
    description = "Substitutes XML entity references for values",
    inputs = list(
        moduleInput(name = "report",
                     vessel = fileVessel("report.xml"),
                     format = ioFormat("XML file"))),
    sources = list(moduleSource(
        vessel = scriptVessel(readLines("scripts/substituteEntities.sh")))),
    outputs = list(
        moduleOutput(name = "report",
                     vessel = fileVessel("report.xml"),
                     format = ioFormat("XML file"))))



docToHtml <- pipeline(
    name = "docToHtml",
    description = "Convert transformable XML document to HTML",
    components = list(xinclude, substituteEntities),
    pipes = list(
        pipe("xinclude", "report", "substituteEntities", "report")))

pplRes1 <- runPipeline(docToHtml, targetDirectory = tempdir())
