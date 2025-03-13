

# Load necessary package
library(asht)

# Set seed for reproducibility
set.seed(1234)

# Generate data with different variances
group1 <- rnorm(n = 20, mean = 10, sd = 2)  # Smaller variance
group2 <- rnorm(n = 25, mean = 12, sd = 5)  # Larger variance

# Perform a CLASSICAL Behrens-Fisher test 
test_result <- bfTest(group1, group2)

# Print results
print(test_result)

