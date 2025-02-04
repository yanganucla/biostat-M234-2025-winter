rm(list = ls())

set.seed(1234)

data = read.table("../data/data.txt", header=T)
prior = read.table("../data/prior1.txt", header=T)

source("../src/normalNormalPosterior.r")

monteCarloSampleSize = 1000

n = data$sampleSize
yBar = data$sampleMean
sigma = data$sigma
sigmaSq = sigma^2

theta = prior$theta
tau = prior$tau
tauSq = tau^2

n0 = sigmaSq/tauSq

posteriorSamples = normalNormalPosterior(monteCarloSampleSize, yBar, sigmaSq, n, theta, n0)

posteriorSummaryExact = normalNormalPosteriorExact(yBar, sigmaSq, n, theta, n0)


