
bayesNonInformativePredictive <- function (newX, posteriorSamples) {
	
	m = nrow(newX)
	NITER = nrow(posteriorSamples)
	p = ncol(newX)

	beta = as.matrix(posteriorSamples[,-(p+1)])
	sigma = sqrt(posteriorSamples[, (p+1)])
	newX <- as.matrix(newX)
	mu = tcrossprod(newX, beta) ## newX%*%t(beta)
	
##	yPred = matrix(0, nrow=m, ncol=NITER)
##	for (i in 1:m) {
##		yPred[i,] <- rnorm(NITER, mu[i,], sigma)
##	}

	yPred <- matrix(rnorm(m*NITER, c(mu), sigma) , nrow=m, ncol=NITER)
	
	return(yPred)
}

