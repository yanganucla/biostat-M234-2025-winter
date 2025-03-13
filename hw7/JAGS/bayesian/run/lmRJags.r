rm(list = ls())
library(rjags)
library(coda)

# Set seed for reproducibility
set.seed(1234)

# Generate data with different variances (same as in Behrens-Fisher analysis)
group1 <- rnorm(n = 20, mean = 10, sd = 2)  # Smaller variance
group2 <- rnorm(n = 25, mean = 12, sd = 5)  # Larger variance

# Define the JAGS data list
dataList <- list(
    group1 = group1,
    group2 = group2,
    n1 = length(group1),
    n2 = length(group2)
)

# Load the JAGS model
model <- jags.model("../src/modelJags.txt", data = dataList, n.chains = 3, n.adapt = 1000)

# Burn-in phase
update(model, 5000)

# Sample from the posterior
samples <- coda.samples(model, c("muDiff", "sigmaSqRatio"), n.iter = 10000)

# Print summary statistics
summary(samples)

# Extract and compute 95% credible intervals
muDiff_CI <- quantile(samples[[1]][, "muDiff"], c(0.025, 0.5, 0.975))
sigmaSqRatio_CI <- quantile(samples[[1]][, "sigmaSqRatio"], c(0.025, 0.5, 0.975))

# Display results
cat("95% Credible Interval for Mean Difference (muDiff):", muDiff_CI, "\n")
cat("95% Credible Interval for Variance Ratio (sigmaSqRatio):", sigmaSqRatio_CI, "\n")
