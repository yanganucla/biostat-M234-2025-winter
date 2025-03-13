rm(list = ls())
# Load necessary packages
library(rjags)
library(coda)

# Set seed for reproducibility
set.seed(1234)

# Read the height dataset
data <- read.csv("../data/height_data.csv")

# Define groups
group1 <- data$US
group2 <- data$Swedish

# Prepare data list for JAGS
dataList <- list(
    group1 = group1,
    group2 = group2,
    n1 = length(group1),
    n2 = length(group2)
)

# JAGS model for Bayesian Behrens-Fisher analysis
model_string <- "
model {
    for (i in 1:n1) {
        group1[i] ~ dnorm(mu1, tau1)
    }
    for (i in 1:n2) {
        group2[i] ~ dnorm(mu2, tau2)
    }

    # Priors on means
    mu1 ~ dnorm(0, 1e-5)
    mu2 ~ dnorm(0, 1e-5)

    # Priors on precisions (inverse variance)
    tau1 ~ dgamma(0.001, 0.001)
    tau2 ~ dgamma(0.001, 0.001)

    # Convert precisions to variances
    sigmaSq1 <- 1 / tau1
    sigmaSq2 <- 1 / tau2

    # Compute posterior difference in means
    muDiff <- mu1 - mu2

    # Compute posterior variance ratio
    sigmaSqRatio <- sigmaSq1 / sigmaSq2
}
"

# Write model to file
writeLines(model_string, "../src/height_model.txt")

# Load JAGS model
model <- jags.model("../src/height_model.txt", data = dataList, n.chains = 3, n.adapt = 1000)

# Burn-in phase
update(model, 5000)

# Sample from the posterior
samples <- coda.samples(model, c("muDiff", "sigmaSqRatio"), n.iter = 10000)

# Extract credible intervals
muDiff_CI <- quantile(samples[[1]][, "muDiff"], c(0.025, 0.5, 0.975))
sigmaSqRatio_CI <- quantile(samples[[1]][, "sigmaSqRatio"], c(0.025, 0.5, 0.975))

# Print results
cat("95% Credible Interval for Mean Difference (muDiff):", muDiff_CI, "\n")
cat("95% Credible Interval for Variance Ratio (sigmaSqRatio):", sigmaSqRatio_CI, "\n")
