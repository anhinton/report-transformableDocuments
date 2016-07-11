#! /usr/bin/Rscript
library(conduit)

## load document to HTML transformation pipeline
toHtml <- loadPipeline(name = "toHtml",
                       ref = "transform/toHtml/pipeline.xml")

## execute document to HTML pipeline
pplRes1 <- runPipeline(toHtml, targetDirectory = tempdir())

## copy knitr figures to examples directory
conduit:::dir.copy(from = pplRes1$outputList$knitToHtml$figure$ref,
                   to = "examples/figure", overwrite = TRUE)
## copy final report.html to working directory
file.copy(from = pplRes1$outputList$knitToHtml$report$ref, to = ".",
          overwrite = TRUE)

## load document to PDF transformation pipeline
toPdf <- loadPipeline(name = "toPdf",
                      ref = "transform/toPdf/pipeline.xml")

## execute document to PDF pipeline
pplRes2 <- runPipeline(toPdf, targetDirectory = tempdir())
