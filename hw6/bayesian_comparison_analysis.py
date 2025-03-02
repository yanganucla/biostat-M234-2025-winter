import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import scipy.stats as stats


# Load JAGS results
jags_pred = pd.read_csv("posterior_predictive_summary.txt", delim_whitespace=True, index_col=0)
jags_medians = jags_pred["50%"].values

# Load Bayesian inference results
with open("result.txt", "r") as file:
    bayesian_raw_data = file.readlines()

# Extract Bayesian median predictions
cleaned_bayesian_values = []
for line in bayesian_raw_data[3:]:  # Skip header lines
    parts = line.strip().split()
    if len(parts) == 3:
        try:
            median_value = float(parts[0])
            cleaned_bayesian_values.append(median_value)
        except ValueError:
            continue

bayesian_medians_fixed = np.array(cleaned_bayesian_values[:len(jags_medians)])

# Compute RMSE
rmse = np.sqrt(np.mean((jags_medians - bayesian_medians_fixed) ** 2))

# Compute Pearson correlation coefficient
correlation, _ = stats.pearsonr(jags_medians, bayesian_medians_fixed)

# Scatter plot comparison
plt.figure(figsize=(8, 6))
plt.scatter(jags_medians, bayesian_medians_fixed, alpha=0.7, label="Predictions")
plt.plot([min(jags_medians), max(jags_medians)], 
         [min(jags_medians), max(jags_medians)], 'r--', label="y=x Line")
plt.xlabel("JAGS Predictions (Median)")
plt.ylabel("Bayesian Inference Predictions (Median)")
plt.title("Comparison of Posterior Predictive Medians")
plt.legend()
plt.grid(True)
plt.savefig("bayesian_comparison_scatter.png")  # Save the figure
plt.show()

# Print results
print(f"RMSE: {rmse:.3f}")
print(f"Pearson Correlation: {correlation:.3f}")
