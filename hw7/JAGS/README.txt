
# Bayesian Behrens-Fisher Analysis

## Overview
This project implements the **Bayesian Behrens-Fisher analysis** using JAGS and R. It compares the means and variances of two independent groups.

### **Directory Structure**
```
hw4_Bayesian_BehrensFisher/
│── bayesianLinearRegression/
│   │── data/
│   │   ├── summaryData.txt   # Dataset used for Behrens-Fisher analysis
│   │── src/
│   │   ├── modelJags.txt     # JAGS model for Bayesian Behrens-Fisher analysis
│   │   ├── dataPrep.r        # Script to load and prepare data
│   │── run/
│   │   ├── lmRJags.r         # Main R script to run JAGS model
│   │   ├── lmRJagsPurl.r     # Extracts R code from RMarkdown
│   │   ├── lmRJagsRmdExec.r  # R script to render RMarkdown file
│   │   ├── lmRJags.Rmd       # RMarkdown report file
     
```

---

## **How to Run**

### **1 Run Bayesian Behrens-Fisher Analysis in JAGS**
Execute the main R script:
```r
source("lmRJags.r")
```

### **2 Extract R Code and get html file from RMarkdown**
If needed, extract the R code from the `.Rmd` file:
```r
source("lmRJagsRmdExec.r")
```

### **3 Check Results**
- The script extracts **95% credible intervals** for:
  - **Mean difference (`muDiff`)**
  - **Variance ratio (`sigmaSqRatio`)**

- The credible intervals will help determine:
  - If **0 is NOT in `muDiff_CI`**, the **means are significantly different**.
  - If **1 is NOT in `sigmaSqRatio_CI`**, the **variances are significantly different**.

---

## **Notes**
- The dataset used is `summaryData.txt`, which correctly represents the Behrens-Fisher data.
- The **JAGS model in `modelJags.txt`** has been modified to perform the Behrens-Fisher analysis.
- The analysis is **fully Bayesian** and replaces the frequentist approach.

For any issues, feel free to modify the scripts accordingly.
