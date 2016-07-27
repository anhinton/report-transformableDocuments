#! /usr/bin/Rscript
library(conduit)

### produce HTML output

## load document to HTML transformation pipeline
toHtml <- loadPipeline(name = "toHtml",
                       ref = "transform/toHtml/pipeline.xml")

## execute document to HTML pipeline
pplRes1 <- runPipeline(toHtml, targetDirectory = tempdir())

## export pipeline result
#tarball1 <- export(pplRes1)

## copy final report.html to working directory
file.copy(from = pplRes1$outputList$knitToHtml$report$ref, to = ".",
          overwrite = TRUE)
