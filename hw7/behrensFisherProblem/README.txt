
# Bayesian Behrens-Fisher Analysis

## Overview
This project includes R scripts for performing both classical and Bayesian Behrens-Fisher analysis.

### Files Included:
1. `run/behrensFisherBayesRun.r` - Runs Bayesian Behrens-Fisher analysis and calculates 95% credible intervals.
2. `run/classical_behrens_fisher_test.r` - Runs the classical (frequentist) Behrens-Fisher test using `bfTest()`.
3. `src/behrensFisherBayes.r` - The modified Bayesian function with vectorized operations.
4. `data/summaryData.txt` - The dataset used for analysis.

---

## How to Use

### Step 1: Run the Classical Behrens-Fisher Test
- In R, execute the script to determine if the means are significantly different:
  ```r
  source("classical_behrens_fisher_test.r")
  ```

### Step 2: Run Bayesian Behrens-Fisher Analysis
- Execute the Bayesian script to get the **95% credible intervals**:
  ```r
  source("behrensFisherBayesRun.r")
  ```

### Step 3: Interpret Results
- If **0 is NOT in `muDiff_CI`**, the means **are significantly different**.
- If **1 is inside `sigmaSqRatio_CI`**, the variances **are not significantly different**.

---

## Notes
- Ensure `data/summaryData.txt` is present before running.
- The Bayesian script loads `src/behrensFisherBayes.r` from `src/`.

For any issues, feel free to modify the scripts accordingly.
