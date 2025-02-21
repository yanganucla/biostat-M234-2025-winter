
data <- read.table("../data/stockton_real_estate.txt", header=T)

Y = data$Y
X = as.matrix(data[, c("X1", "X2", "X3", "X4", "X5", "X6")])

N = length(Y)

#----------------------------
#Add an intercept column to X
#----------------------------
X = cbind(rep(1, times=N), X)

#----------------------------
#Store number of columns in X
#----------------------------
p <- ncol(X)

#-----------------------------------------------
#Set values of hyperparameters in Bayesian model 
#-----------------------------------------------
a0 = 0.001
b0 = 0.001
n0 = 1e-3

#-----------------------------
#Read new values of predictors
#-----------------------------
newX <- read.table("../data/stocktonRealEstateNewPredictors.txt", header=T)
newX <- newX[, c("X1", "X2", "X3", "X4", "X5", "X6")]  # Remove Lat & Longi

m <- nrow(newX)
newX <- cbind(rep(1, times=m), newX)

jagsData = list(N=N, p=p, Y=Y, X=X, a0=a0, b0=b0, n0=n0, m=m, newX=newX)

