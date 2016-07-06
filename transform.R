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

res1 <- runModule(xinclude, targetDirectory = tempdir())
