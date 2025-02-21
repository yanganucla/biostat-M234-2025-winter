
data <- read.csv("../data/rate_lung_cancer_with_smoking.csv", header=T)

Y = data$Age_Adjusted_Rate
X = data$Smoking_Rate

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

jagsData = list(N=N, p=p, Y=Y, X=X, a0=a0, b0=b0, n0=n0)

