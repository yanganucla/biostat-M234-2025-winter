# Bayesian Model Comparison - README

## 📌 Overview
This project compares **two Bayesian predictive modeling approaches**:
1. **JAGS-based Bayesian regression** (RJAGS)
2. **Bayesian inference using `bayesNonInformativePredictiveRun.r`**

The goal is to analyze how well these two methods align in estimating the **posterior predictive median (`yPred`) and credible intervals**.

## 📂 Required Files
Ensure the following files are in the working directory:
- `posterior_predictive_summary.txt` → JAGS-based posterior predictive results
- `result.txt` → Bayesian inference-based posterior predictive results
- `posterior_beta_summary.txt` → Posterior beta coefficient estimates from both methods
- `bayesian_comparison_analysis.py` → Python script to compute RMSE, correlation, and scatter plot
- `bayesian_comparison_scatter.png` → Generated plot comparing predictions

## 🚀 Running the Analysis
1️⃣ Install required Python libraries:
```bash
pip install pandas numpy scipy matplotlib
```

2️⃣ Run the analysis script:
```bash
python bayesian_comparison_analysis.py
```

## 📊 Expected Outputs
- **RMSE (Root Mean Squared Error):** Measures prediction deviation.
- **Pearson Correlation Coefficient:** Measures prediction similarity.
- **Scatter plot (`bayesian_comparison_scatter.png`)**: Visualizes alignment between methods.

## 📉 Interpretation
- **Low RMSE** → High agreement between methods.
- **High Pearson correlation** (closer to ±1) → Strong similarity in predictions.
- **Scatter plot alignment** → Indicates consistency in predictions.

## 🔍 Troubleshooting
- Missing files? Ensure all required files are in the working directory.
- Import errors? Run `pip install pandas numpy scipy matplotlib`.
- No output? Check if `posterior_predictive_summary.txt` and `result.txt` contain valid data.

## 📬 Contact
For inquiries, contact **Yang An** at [yangan@g.ucla.edu](mail to:yangan@g.ucla.edu).
