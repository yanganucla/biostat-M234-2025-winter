library(rmarkdown)

render("lmRJags.Rmd")
knitr::purl(input = "lmRJags.Rmd", output = "lmRJagsPurl.r", documentation=0)

knitr::purl(input = "lmRJags.Rmd", output = "lmRJagsPurl.r", documentation=0)

