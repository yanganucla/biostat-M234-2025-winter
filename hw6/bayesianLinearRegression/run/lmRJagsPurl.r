rm(list = ls())

library(rjags)
library(coda)

source("../src/dataPrep.r")

inits = list(
                list(beta = rep(0, times=p), tausq=1.0, yFit = rep(0, times=N))
)

nSamp = 10000 ## Number of posterior samples for inference
nChains = 1 ## Number of chains
nAdapt = 200 ## The initial number of runs to tune parameters
nBurn = 1000 ## Number of initial runs ("burn" period) for MCMC to converge

modelParameters = c("beta", "tausq", "sigmasq", "yFit")

m <- jags.model("../src/modelJags.txt", data=jagsData, inits=inits, n.chains=nChains, n.adapt=nAdapt)

update(m, n.iter=nBurn)

mOut <- coda.samples(model=m, variable.names=modelParameters, n.iter=nSamp)

sm <- summary(mOut)

samps <- do.call(rbind, mOut)

credibleIntervals <- t(apply(samps, 2, function(x){quantile(x, c(0.50, 0.025, 0.975))}))
ciBeta <- credibleIntervals[grep("beta", rownames(credibleIntervals)),]
ciBeta
ciyFit <- credibleIntervals[grep("yFit", rownames(credibleIntervals)),]
ciyFit
