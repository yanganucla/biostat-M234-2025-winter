rm(list=ls())

set.seed(1234)

# Load Stockton real estate dataset
data <- read.table("../data/stockton_real_estate.txt", header=T)

# Ensure column names match dataset structure
colnames(data) <- c("Y", "X1", "X2", "X3", "X4", "X5", "X6", "Lat", "Longi")

# Define response variable (Y) and predictor variables (X)
Y = data$Y  # Assuming 'Y' is the target variable
X = as.matrix(data[, c("X1", "X2", "X3", "X4", "X5", "X6")]) # Selecting predictor variables

# Fit linear model
lmOut <- lm(Y ~ X)

source("../src/bayesNonInformative.r")

NITER = 1000

posteriorSamples <- bayesNonInformative(lmOut, NITER)

names(posteriorSamples) <- c("intercept", colnames(X), "residualVariance")

write.table(posteriorSamples, file="posteriorSamples.txt", row.names=FALSE)

# Compute posterior coefficient summaries
posterior_summary <- apply(posteriorSamples, 2, function(x) quantile(x, c(0.5, 0.025, 0.975)))
write.table(posterior_summary, file="posterior_beta_summary.txt", row.names=TRUE, col.names=NA)
