
library(rmarkdown)

# Render the Bayesian Behrens-Fisher Analysis Report
render("lmRJags.Rmd")

# Extract R script from the RMarkdown file
knitr::purl(input = "lmRJags.Rmd", output = "lmRJagsPurl.r", documentation=0)
