behrensFisherBayes <- function (yBar, sSq, n, theta, n0, a0, b0, NITER) {

    J = length(yBar)  ## J is the number of groups in the data
    
    a = a0 + n / 2
    rss = (n - 1) * sSq
    w = n / (n0 + n)
    b = b0 + (1/2) * (rss + n0 * w * (yBar - theta)^2)
    
    sigmaSq = matrix(1/rgamma(NITER * J, rep(a, each=NITER), rep(b, each=NITER)), ncol=J)
    
    muPost = (1 - w) * theta + w * yBar
    muPostSD = sqrt(sigmaSq * w / n)
    
    mu = matrix(rnorm(NITER * J, rep(muPost, each=NITER), rep(muPostSD, each=NITER)), ncol=J)
    
    df.out = data.frame(cbind(mu, sigmaSq))
    return(df.out)
}
