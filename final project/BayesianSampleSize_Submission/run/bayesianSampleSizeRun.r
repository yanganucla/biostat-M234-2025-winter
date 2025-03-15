rm(list=ls())
set.seed(1234)

# Load Bayesian Sample Size Function
source("../src/bayesianSampleSize.r")

# Read simulated LDL data
data <- read.csv("../data/simulated_LDL_data.csv")

# Convert LDL column to numeric (prevents NA issues)
data$LDL <- as.numeric(data$LDL)

# Separate Lipitor and DrugX groups using correct column name
lipitor_data <- subset(data, Group == "Lipitor")$LDL
drugX_data <- subset(data, Group == "DrugX")$LDL

# Compute observed effect size
delta_observed <- mean(lipitor_data, na.rm = TRUE) - mean(drugX_data, na.rm = TRUE)

cat("Mean LDL (Lipitor):", mean(lipitor_data, na.rm = TRUE), "| Mean LDL (DrugX):", mean(drugX_data, na.rm = TRUE), "\n")

# Define effect sizes to test
deltas <- c(5, 10, 15, 20)

# Run Bayesian Sample Size Calculation
results <- sapply(deltas, bayesian_sample_size)

# Save results to a CSV file
output_df <- data.frame(Effect_Size = deltas, Required_Sample_Size = results)
write.csv(output_df, "../output/sample_size_results.csv", row.names = FALSE)

# Print results to console
print(output_df)
