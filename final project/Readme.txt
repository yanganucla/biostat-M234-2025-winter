# README - Bayesian Sample Size Calculation Project

## Project Overview
This project aims to determine the minimum sample size required to detect a statistically significant difference in LDL (Low-Density Lipoprotein) levels between **Lipitor** and **Drug X** using a Bayesian framework. The study applies Monte Carlo simulations to compute posterior probabilities and identify an optimal sample size.

## Directory Structure
```
BayesianSampleSize/
│── data/                     # Stores synthetic LDL data
│   ├── simulated_LDL_data.csv (500 samples per group)
│
│── src/                      # Core R script for Bayesian sample size calculation
│   ├── bayesianSampleSize.r
│
│── run/                      # Main script to execute Bayesian sample size analysis
│   ├── bayesianSampleSizeRun.r
│
│── output/                    # Stores computed sample size results
│   ├── sample_size_results.csv (Generated after running the script)
│
│── BIOSTAT_234_Final_Project_report.pdf  # Project Report
│── README.txt                  # Project Documentation (this file)
```

## How to Run the Code
### 1. Prerequisites
Ensure you have **R installed** with the required libraries:
```r
install.packages("mvtnorm")
```

### 2. Running the Simulation
Navigate to the project folder in R and execute:
```r
source("bayesianSampleSizeRun.r")
```

### 3. Viewing Results
The script will output the required sample sizes for different effect sizes in:
```
output/sample_size_results.csv
```

## Key Components
- **`bayesianSampleSize.r`**: Implements Bayesian sample size calculation using posterior probabilities.
- **`bayesianSampleSizeRun.r`**: Runs simulations for multiple effect sizes (5, 10, 15, 20) and dynamically computes `delta_observed`.
- **`simulated_LDL_data.csv`**: **Expanded dataset with 500 samples per group**, used for analysis.
- **`BIOSTAT_234_Final_Project_Expanded.pdf`**: Final project report summarizing methodology and results.

## Updated Results Summary
| Effect Size | Required Sample Size |
|------------|----------------------|
| 5          | 408                   |
| 10         | 340                   |
| 15         | 308                   |
| 20         | 295                   |

## Comparison with Classical Methods
- **Classical Approach**: Uses power calculations to determine `n` based on fixed significance levels.
- **Bayesian Approach**: Determines `n` by computing posterior probabilities and dynamically updating beliefs based on observed LDL data.
- **Advantages**:
  - Incorporates prior knowledge
  - More flexible for adaptive trial designs

## Future Extensions
- Incorporate **hierarchical Bayesian models** for multi-center trials.
- Implement **adaptive Bayesian designs** that adjust `n` dynamically.
- Conduct **sensitivity analysis** to assess robustness to prior assumptions.
