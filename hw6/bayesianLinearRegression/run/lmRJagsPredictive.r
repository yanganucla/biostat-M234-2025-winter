rm(list = ls())

library(rjags)
library(coda)

set.seed(1234)

source("../src/dataPrepPredictive.r")

inits = list(
		list(beta = rep(0, times=p), tausq=1.0, yFit = rep(0, times=N), yPred = rep(0, times=m))
)

nSamp = 10000
nChains = 1
nAdapt = 200
nBurn = 1000

modelParameters = c("beta", "tausq", "sigmasq", "yFit", "yPred")

#-------
#Compile
#-------
m <- jags.model("../src/modelJagsPredictive.txt", data=jagsData, inits=inits, n.chains=nChains, n.adapt=nAdapt)


#---------------
#Update and burn
#---------------
update(m, n.iter=nBurn)

#------------------
#posterior sampling
#------------------
mOut <- coda.samples(model=m, variable.names=modelParameters, n.iter=nSamp)

#-------------------------------------------------
#descriptive statistics of posterior distributions
#-------------------------------------------------
sm <- summary(mOut)

#--------------------------------------------------------
# extracting samples from the full posterior distribution
#--------------------------------------------------------
samps <- do.call(rbind, mOut)

#----------------------------------
#medians and 95% credible intervals
#----------------------------------
credibleIntervals <- t(apply(samps, 2, function(x){quantile(x, c(0.50, 0.025, 0.975))}))

ciBeta <- credibleIntervals[grep("beta", rownames(credibleIntervals)),]
ciyFit <- credibleIntervals[grep("yFit", rownames(credibleIntervals)),]
ciyPred <- credibleIntervals[grep("yPred", rownames(credibleIntervals)),]


# Define correct row names dynamically
expected_names <- c("intercept", "X1", "X2", "X3", "X4", "X5", "X6")

# Print results
print("Posterior Summary for Beta Coefficients:")
print(ciBeta)

print("Posterior Predictive Median and 95% Prediction Intervals:")
print(ciyPred)

# Save outputs to files
write.table(ciBeta, file="posterior_beta_summary.txt", row.names=TRUE, col.names=NA)
write.table(ciyPred, file="posterior_predictive_summary.txt", row.names=TRUE, col.names=NA)
