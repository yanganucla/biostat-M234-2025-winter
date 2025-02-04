rm(list = ls())

set.seed(1234)

# Load data and prior information
data <- read.table("../data/data.txt", header = TRUE)
priors <- read.table("../data/prior.txt", header = TRUE)

# Source posterior function
source("../src/normalInvGamma.r")

# Number of Monte Carlo samples
monteCarloSamples <- 500

# Initialize a results list
results <- list()

# Loop through priors
for (i in 1:nrow(priors)) {
  prior <- priors[i, ]
  cat(sprintf("\n----- Case %d -----\n", i))
  
  # Compute posterior samples
  posteriorResult <- normalInvGamma(monteCarloSamples, data, prior)
  
  # Compute 95% credible intervals
  muCI <- posteriorResult$credible_interval
  
  # Print results
  cat(sprintf("Posterior Mean: %.2f\n", mean(posteriorResult$samples$mu, na.rm = TRUE)))
  cat(sprintf("95%% Credible Interval for μ: [%.2f, %.2f]\n", muCI[1], muCI[2]))
  
  # Hypothesis testing
  testResult <- if (200 >= muCI[1] && 200 <= muCI[2]) {
    "NOT rejected"
  } else {
    "rejected"
  }
  cat(sprintf("Hypothesis μ = 200 is %s.\n\n", testResult))
}
