Bayesian Predictive Analysis

📌 Overview
This project performs Bayesian predictive modeling using JAGS to estimate the log selling prices of homes in Stockton based on real estate covariates.

🚀 How to Run the Analysis
Simply run the following command in R:
```r
source("lmRJagsPredictive.r")
```
This will:
- Load necessary data.
- Perform Bayesian regression analysis using JAGS.
- Generate posterior estimates of regression coefficients.
- Compute predictive values and 95% prediction intervals.
- Print results automatically.

🛠️ Outputs
The script automatically prints the posterior estimates and predictive intervals. Results are saved as:
- `posterior_beta_summary.txt` → Posterior coefficient estimates including `sigma_square`.
- `posterior_predictive_summary.txt` → Predicted values with uncertainty bounds.

To read the results in R:
```r
read.table("posterior_beta_summary.txt", header=TRUE)
read.table("posterior_predictive_summary.txt", header=TRUE)
```

🚀 Now you're ready to run Bayesian predictive analysis with JAGS! 🚀
