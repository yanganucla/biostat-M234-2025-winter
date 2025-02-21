# Update Predictive Run Script
rm(list=ls())

set.seed(1234)

posteriorSamples <- read.table("posteriorSamples.txt", header=T)

# Load new data points for prediction
newX <- read.table("../data/stockton_real_estate.txt", header=T)
colnames(newX) <- c("Y", "X1", "X2", "X3", "X4", "X5", "X6", "Lat", "Longi")
newX = as.matrix(newX[, c("X1", "X2", "X3", "X4", "X5", "X6")]) # Using same predictors
newX = cbind(1, newX)  # Add intercept term

source("../src/bayesNonInformativePredictive.r")

yPred = bayesNonInformativePredictive(newX, posteriorSamples)

# Display output automatically
dim(yPred)
for (i in 1:35) {
  print(quantile(yPred[i,], c(0.5, 0.025, 0.975)))
}
