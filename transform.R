#! /usr/bin/Rscript
library(conduit)

## load document transformation pipeline
transform <- loadPipeline(name = "transform",
                          ref = "transform/toHtml/pipeline.xml")

## execute pipeline
pplRes1 <- runPipeline(transform)

## copy knitr figures to examples directory
conduit:::dir.copy(from = pplRes1$outputList$knitToHtml$figure$ref,
                   to = "examples/figure", overwrite = TRUE)
## copy final report.html to working directory
file.copy(from = pplRes1$outputList$knitToHtml$report$ref, to = ".",
          overwrite = TRUE)
