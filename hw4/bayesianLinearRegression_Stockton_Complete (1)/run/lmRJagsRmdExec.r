
library(rmarkdown)

# Render the R Markdown document
render("lmRJags.Rmd")

# Extract R code from R Markdown
knitr::purl(input = "lmRJags.Rmd", output = "lmRJagsPurl.r", documentation = 0)
