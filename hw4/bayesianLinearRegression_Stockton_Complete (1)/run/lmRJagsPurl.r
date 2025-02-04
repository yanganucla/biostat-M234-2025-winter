
rm(list = ls())

library(rjags)
library(coda)

source("../src/dataPrep.r")

# Initial values
inits = list(
    list(beta = rep(0, times = p), tausq = 1.0, yFit = rep(0, times = N))
)

# MCMC settings
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
