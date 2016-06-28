#!/usr/bin/Rscript
references <- readLines("references.html")
references <- c("<!DOCTYPE div [",
                "<!ENTITY us \"_\">",
                "]>",
                references)
writeLines(references, "references.html")
