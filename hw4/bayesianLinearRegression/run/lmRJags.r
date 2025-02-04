rm(list = ls())

library(rjags)
library(coda)

set.seed(1234)

source("../src/dataPrep.r")

inits = list(
		list(beta = rep(0, times=p), tausq=1.0, yFit = rep(0, times=N))
)

nSamp = 10000
nChains = 1
nAdapt = 200
nBurn = 1000

modelParameters = c("beta", "tausq", "sigmasq", "yFit")

#-------
#Compile
#-------
m <- jags.model("../src/modelJags.txt", data=jagsData, inits=inits, n.chains=nChains, n.adapt=nAdapt)


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
#posterior mean, posterior standard deviation and 95% credible intervals for: (i) the regression slopes; (ii) the residual variance; and (iii) the model-fitted values of the data.
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

posterior_median <- apply(samps, 2, median)
posterior_median


#Which of the covariates are statistically significant predictors of Y
significant_covariates <- rownames(ciBeta)[!(ciBeta[,2] < 0 & ciBeta[,3] > 0)]
significant_covariates

#How many of the 95% credible intervals for the model-fitted values actually include the observed values?
included_observed <- sum(data$Y >= ciyFit[,2] & data$Y <= ciyFit[,3])
included_observed


#Scatter plot of observed vs. fitted median values
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

