README: Bayesian Linear Regression with Non-Informative Priors

This project performs Bayesian linear regression on the real estate dataset (stockton_real_estate.txt) 
using a non-informative prior. The regression model follows the structure of the classical linear model 
but incorporates Bayesian inference using MCMC sampling.

### Files Included:
1. **bayesNonInformativeRun.r** - Runs the Bayesian regression model.
2. **stockton_real_estate.txt** - Real estate dataset used in Homework 4.
3. **bayesNonInformative.r** - Contains the Bayesian regression function.
4. **answer.txt** - Summary of results from Bayesian regression.

### How to Run:
1. **Ensure Required Libraries are Installed**:
   ```r
   install.packages("MCMCpack")
   install.packages("readr")
   ```

2. **Set Up Your Working Directory**:
   Ensure that `bayesNonInformativeRun.r` and `stockton_real_estate.txt` are in the correct paths.

3. **Run the R Script**:
   ```r
   source("bayesNonInformativeRun.r")
   ```

4. **Review Results**:
   - Posterior summaries of coefficients can be found in `answer.txt`.
   - Compare Bayesian estimates with OLS estimates from `lm()`.

### Notes:
- The Bayesian model runs for 1000 iterations (`NITER = 1000`).
- The priors used are **non-informative**, allowing the data to drive parameter estimates.
