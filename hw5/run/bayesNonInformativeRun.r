# Clear all variables from the environment
rm(list=ls())

# Set seed for reproducibility
set.seed(1234)

# Read the dataset
data <- read.table("../data/stockton_real_estate.txt", header = TRUE)

# Define response variable (Y) and predictor variables (X)
Y = data$Y
X = data[, c("X1", "X2", "X3", "X4", "X5", "X6")]  # Select predictor variables

# Fit an OLS linear regression model as a reference
lmOut <- lm(Y ~ ., data = data)

# Load the Bayesian regression function (ensure the correct path)
source("../src/bayesNonInformative.r")

# Set the number of MCMC iterations
NITER = 1000

# Run Bayesian linear regression with non-informative priors
posteriorSamples <- bayesNonInformative(lmOut, NITER)

# Assign names to posterior samples
names(posteriorSamples) <- c("intercept", "X1", "X2", "X3", "X4", "X5", "X6", "residualVariance")

# Print summary of posterior samples
print(head(posteriorSamples))

# Print posterior quantiles for each coefficient
cat("\nQuantiles for Intercept:\n")
print(quantile(posteriorSamples$intercept, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for X1:\n")
print(quantile(posteriorSamples$X1, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for X2:\n")
print(quantile(posteriorSamples$X2, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for X3:\n")
print(quantile(posteriorSamples$X3, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for X4:\n")
print(quantile(posteriorSamples$X4, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for X5:\n")
print(quantile(posteriorSamples$X5, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for X6:\n")
print(quantile(posteriorSamples$X6, c(0.5, 0.025, 0.975)))

cat("\nQuantiles for Residual Variance:\n")
print(quantile(posteriorSamples$residualVariance, c(0.5, 0.025, 0.975)))

# Print summary of OLS model
cat("\nSummary of OLS Model:\n")
print(summary(lmOut))


