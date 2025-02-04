
rm(list = ls())

library(rjags)
library(coda)

set.seed(1234)

source("../src/dataPrep.r")

# Initial values
inits = list(
    list(beta = rep(0, times = p), tausq = 1.0, yFit = rep(0, times = N))
)

# MCMC parameters
nSamp = 10000
nChains = 1
nAdapt = 200
nBurn = 1000

modelParameters = c("beta", "tausq", "sigmasq", "yFit")

# Compile model
m <- jags.model("../src/modelJags.txt", data = jagsData, inits = inits, n.chains = nChains, n.adapt = nAdapt)

# Burn-in
update(m, n.iter = nBurn)

# Posterior sampling
mOut <- coda.samples(model = m, variable.names = modelParameters, n.iter = nSamp)

# Summary
sm <- summary(mOut)

# Posterior samples
samps <- do.call(rbind, mOut)

# Credible intervals
credibleIntervals <- t(apply(samps, 2, function(x) { quantile(x, c(0.50, 0.025, 0.975)) }))
ciBeta <- credibleIntervals[grep("beta", rownames(credibleIntervals)), ]
ciyFit <- credibleIntervals[grep("yFit", rownames(credibleIntervals)), ]

# Posterior Mean, SD, Median, 95% Credible Intervals
posterior_means <- sm$statistics[, "Mean"]
posterior_sd <- sm$statistics[, "SD"]
posterior_median <- apply(samps, 2, median)
credible_intervals <- credibleIntervals

# Identify statistically significant covariates
significant_covariates <- rownames(ciBeta)[!(ciBeta[,2] < 0 & ciBeta[,3] > 0)]

# Check how many 95% credible intervals for fitted values include the observed values
included_observed <- sum(data$Y >= ciyFit[,2] & data$Y <= ciyFit[,3])
