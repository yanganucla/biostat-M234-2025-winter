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
sm

samps <- do.call(rbind, mOut)

credibleIntervals <- t(apply(samps, 2, function(x){quantile(x, c(0.50, 0.025, 0.975))}))
ciBeta <- credibleIntervals[grep("beta", rownames(credibleIntervals)),]
ciBeta
ciyFit <- credibleIntervals[grep("yFit", rownames(credibleIntervals)),]
ciyFit

posterior_median <- apply(samps, 2, median)
posterior_median


significant_covariates <- rownames(ciBeta)[!(ciBeta[,2] < 0 & ciBeta[,3] > 0)]
significant_covariates


included_observed <- sum(data$Y >= ciyFit[,2] & data$Y <= ciyFit[,3])
included_observed


# Extracting the median fitted values
head(ciyFit) 
yFitMedians <- ciyFit[, 1]  # First column contains the medians

# Scatter Plot: Observed vs. Fitted Median Values
plot(Y, yFitMedians, 
     main = "Observed vs. Fitted Median Values", 
     xlab = "Observed Y", 
     ylab = "Fitted Median Y", 
     pch = 19, 
     col = "blue")

# Add a 45-degree reference line
abline(0, 1, col = "red", lwd = 2, lty = 2)

# Calculate and Display Correlation
correlation_result <- cor(Y, yFitMedians)

# Adding correlation value to the plot
legend("topleft", legend = paste("Correlation =", round(correlation_result, 3)), 
       bty = "n", text.col = "darkred", cex = 0.9)

# Display correlation value in console as well
print(paste("Correlation between Observed Y and Fitted Median Y:", round(correlation_result, 3)))

