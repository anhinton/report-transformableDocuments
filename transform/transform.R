setwd("~/uoastorage/openapi/documentation/report/transform")

library(conduit)

## run pipeline to extract <cite key=""/> tags and produce APA references
transform <- loadPipeline(
    name = "transform",
    ref = "processCitations/pipeline.xml")
out1 <- runPipeline(transform, targ = tempdir())

## convert report.xml to report.Rtex
toRtex <- loadPipeline(
    name = "toRtex",
    ref = "toRtex/pipeline.xml")
out2 <- runPipeline(toRtex, targ = tempdir())

setwd("~/uoastorage/openapi/documentation/report")

## knit report.Rtex to report.tex
library(knitr)
knit("report.Rtex")

## produce pdf
if (!dir.exists("pdf")) dir.create("pdf")
system2("pdflatex", c("-output-directory", "pdf", "report.tex"))

## producde pdf of hand-edited tex file
if (!dir.exists("pdf")) dir.create("pdf")
system2("pdflatex", c("-output-directory", "pdf", "reportEdit.tex"))
