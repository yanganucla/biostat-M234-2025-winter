

rm(list=ls())
set.seed(1234)

df <- read.table("../data/summaryData.txt", header=T)

yBar = df$sampleMean
sSq = df$sampleVariance
n = df$sampleSize
theta = df$priorMean
n0 = df$priorPrecision
a0 = df$priorShape
b0 = df$priorScale

NITER = 1000

source("../src/behrensFisherBayes.r")

behrensFisherBayesOutput <- behrensFisherBayes(yBar, sSq, n, theta, n0, a0, b0, NITER) 

J <- length(yBar)
mu = as.matrix(behrensFisherBayesOutput[,1:J])
sigmaSq = as.matrix(behrensFisherBayesOutput[,(J+1):ncol(behrensFisherBayesOutput)])

source("../src/getContrast.r")
index <- c(1,2)
contrast <- getContrast(index, J)

muDiff = mu%*%contrast ## Posterior distribution of difference in means between the groups in "index"
sigmaSqRatio = sigmaSq[,index[1]]/sigmaSq[,index[2]] ## Posterior distribution of ratio of the posterior variances

# Compute 95% credible intervals
muDiff_CI <- quantile(muDiff, c(0.025, 0.5, 0.975))
sigmaSqRatio_CI <- quantile(sigmaSqRatio, c(0.025, 0.5, 0.975))

# Print results
cat("95% Credible Interval for Mean Difference (muDiff):", muDiff_CI, "\n")
cat("95% Credible Interval for Variance Ratio (sigmaSqRatio):", sigmaSqRatio_CI, "\n")

