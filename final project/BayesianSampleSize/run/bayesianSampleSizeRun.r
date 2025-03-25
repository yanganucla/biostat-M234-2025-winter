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
deltas <- c(0.5, 1, 2.5, 5, 10, 15, 20)

# Run Bayesian Sample Size Calculation
results <- sapply(deltas, bayesian_sample_size)

# Save results to a CSV file
output_df <- data.frame(Effect_Size = deltas, Required_Sample_Size = results)
write.csv(output_df, "../output/sample_size_results.csv", row.names = FALSE)

# Print results to console
print(output_df)

# Generate log-scaled visualization
library(ggplot2)
library(tibble)

plot_data <- tibble(Effect_Size = deltas, Required_Sample_Size = as.numeric(results))

p <- ggplot(plot_data, aes(x = Effect_Size, y = Required_Sample_Size)) +
  geom_line(color = "blue", linewidth = 1.2) +
  geom_point(size = 2) +
  scale_y_continuous(trans = 'log10') +
  labs(title = "Bayesian Sample Size vs. Effect Size",
       x = "True Effect Size (Δ)",
       y = "Required Sample Size (log10 scale)") +
  theme_minimal()

print(p)
