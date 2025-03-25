
README - Bayesian Sample Size Calculation Project
-------------------------------------------------

Project Overview:
-----------------
This project determines the minimum sample size required to detect a clinically meaningful difference in LDL (Low-Density Lipoprotein) levels between Lipitor and Drug X using a Bayesian framework. Monte Carlo simulations are used to compute posterior probabilities and identify optimal sample sizes for varying effect sizes.

Directory Structure:
--------------------
BayesianSampleSize/
├── data/
│   └── simulated_LDL_data.csv
├── src/
│   └── bayesianSampleSize.r
├── run/
│   └── bayesianSampleSizeRun.r
├── output/
│   └── sample_size_results.csv
├── sample_size_plot.png
├── BIOSTAT_234_Final_Project_report.pdf
└── README.txt

How to Run:
-----------
1. Make sure R is installed.
2. Install required packages:
   install.packages("mvtnorm")
   install.packages("ggplot2")

3. Run the simulation:
   source("bayesianSampleSizeRun.r")

4. Output:
   - Results saved in: output/sample_size_results.csv
   - Plot saved as: sample_size_plot.png

Bayesian Method Details:
------------------------
- Decision rule: Posterior probability must satisfy:
      P(mu_X - mu_L > 0.9 * delta | Data) > 0.95
- Prior used: Normal(0, 3^2)
- Simulated effect sizes: 0.5, 1.0, 2.5, 5.0, 10.0, 15.0, 20.0
- For each delta, simulation repeated and 25th percentile of qualifying n is selected

Summary Results:
----------------
Effect Size (delta) | Required Sample Size
--------------------|----------------------
0.5                 | 357
1.0                 | 362
2.5                 | 436
5.0                 | 408
10.0                | 340
15.0                | 308
20.0                | 295

Interpretation:
---------------
- Sample size increases for small effect sizes (harder to detect)
- Peaks around delta = 2.5, then decreases for larger effects
- Reflects Bayesian principle: more extreme effects are easier to detect

Comparison with Frequentist:
----------------------------
- Frequentist: based on power and significance level
- Bayesian: based on posterior probability and prior belief
- Bayesian method more flexible and intuitive

File Created by: Yang An
Course: BIOSTAT 234 - UCLA
Date: March 24, 2025
