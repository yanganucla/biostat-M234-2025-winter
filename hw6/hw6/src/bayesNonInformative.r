library(mvtnorm)

bayesNonInformative <- function(lmObject, NITER) {
		
	lmObjectData = model.frame(lmObject)
	lmObjectCov = vcov(lmObject) ##This gives s^2*solve(t(X)%*%X)
	coeffMean = coefficients(lmObject) ##This gives the mle of beta
	
	sigmasq = (summary(lmObject)$sigma)^2 ##This gives s^2
	##Note: solve(t(X)%*%X) = lmObjectCov/sigmasq 
	tXXinv = lmObjectCov/sigmasq 

	n = nrow(lmObjectData)
	p = ncol(lmObjectCov)

	##Simulate from marginal posterior [sigma^2 | y]
	sigmasqPosterior = 1/rgamma(NITER, (n-p)/2, (n-p)*sigmasq/2)

	##Simulate from conditional posterior [beta | y, sigma^2]
        ##Homework: Write the following chunk without using a for loop
	coeffPosterior = matrix(0, nrow=NITER, ncol=p)
	for(i in 1:NITER) {
		SigmaCoeff = sigmasqPosterior[i]*tXXinv
	        coeffPosterior[i,] = rmvnorm(1, coeffMean, SigmaCoeff) 	
	}
	
	posteriorSamples <- as.data.frame(cbind(coeffPosterior, sigmasqPosterior))
	return(posteriorSamples)
		
}
