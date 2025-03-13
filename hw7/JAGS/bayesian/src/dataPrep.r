
# Load the dataset
data <- read.table("../data/summaryData.txt", header = TRUE)

# Define outcome variables for Behrens-Fisher analysis
group1 = rnorm(n = data$sampleSize[1], mean = data$sampleMean[1], sd = sqrt(data$sampleVariance[1]))
group2 = rnorm(n = data$sampleSize[2], mean = data$sampleMean[2], sd = sqrt(data$sampleVariance[2]))

# JAGS data list
jagsData = list(
    group1 = group1,
    group2 = group2,
    n1 = length(group1),
    n2 = length(group2)
)
