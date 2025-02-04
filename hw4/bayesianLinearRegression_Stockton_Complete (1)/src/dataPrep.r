
# Load the dataset
data <- read.table("../data/stockton_real_estate.txt", header = TRUE)

# Define outcome and covariates
Y = data$Y
X = as.matrix(data[, c("X1", "X2", "X3", "X4", "X5", "X6")])

N = length(Y)

# Add intercept to X
X = cbind(1, X)

# Number of predictors
p <- ncol(X)

# Hyperparameters
a0 = 0.001
b0 = 0.001
n0 = 1e-3

# JAGS data list
jagsData = list(N = N, p = p, Y = Y, X = X, a0 = a0, b0 = b0, n0 = n0)
