rm(list = ls())

library(rjags)
library(coda)
set.seed(1234)

# Read summary data file
data <- read.table("../data/summaryData.txt", header=TRUE)

# Extract values for JAGS
group1 <- rnorm(n = data$sampleSize[1], mean = data$sampleMean[1], sd = sqrt(data$sampleVariance[1]))
group2 <- rnorm(n = data$sampleSize[2], mean = data$sampleMean[2], sd = sqrt(data$sampleVariance[2]))

dataList <- list(
    group1 = group1,
    group2 = group2,
    n1 = length(group1),
    n2 = length(group2)
)

# Load JAGS model
model <- jags.model("../src/modelJags.txt", data = dataList, n.chains = 3, n.adapt = 1000)

# Burn-in phase
update(model, 5000)

# Sample from the posterior
samples <- coda.samples(model, c("muDiff", "sigmaSqRatio"), n.iter = 10000)

# Summary of posterior distributions
summary(samples)

# Compute credible intervals
muDiff_CI <- quantile(samples[[1]][, "muDiff"], c(0.025, 0.5, 0.975))
sigmaSqRatio_CI <- quantile(samples[[1]][, "sigmaSqRatio"], c(0.025, 0.5, 0.975))

cat("95% Credible Interval for Mean Difference (muDiff):", muDiff_CI, "\n")
cat("95% Credible Interval for Variance Ratio (sigmaSqRatio):", sigmaSqRatio_CI, "\n")
