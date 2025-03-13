
# Bayesian Behrens-Fisher Analysis - Height Data

## Overview
This project implements the **Bayesian Behrens-Fisher analysis** using JAGS and R. It compares the means and variances of heights between US and Swedish individuals.

## Directory Structure
```
JAGS/
│── results/
│   ├── results.txt                 # Summary of Bayesian analysis results
│── README.txt                       # Instructions for running the analysis
│── bayesian/
│   │── run/
│   │   ├── lmRJags.r                 # Main R script to run JAGS
│   │   ├── lmRJagsRmdExec.r          # Script to execute RMarkdown
│   │   ├── lmRJags.Rmd               # RMarkdown report file
│   │   ├── lmRJagsPurl.r             # Extracts R code from RMarkdown
│   │── data/
│   │   ├── height_data.csv           # Data used for Bayesian analysis
│   │── src/
│   │   ├── height_model.txt             # JAGS model script
│   │   ├
```

## How to Run

### **1️⃣ Install Required R Packages**
```r
install.packages(c("rjags", "coda", "rmarkdown", "knitr"))
```

### **2️⃣ Run Bayesian Behrens-Fisher Analysis**
Execute the main R script:
```r
source("lmRJags.r")
```

### **3️⃣ Generate an HTML Report**

```r
 source("lmRJagsRmdExec.r")
```

## Notes
- The dataset used is `summaryData.txt`, replacing the previous example datasets.
- The **JAGS model in `modelJags.txt`** has been modified for Behrens-Fisher analysis.
