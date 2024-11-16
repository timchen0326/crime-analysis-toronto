#### Preamble ####
# Purpose: Extract unique values for each model variable from raw data
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Raw dataset available in CSV format
# Any other information needed? Ensure the data file path is correct.

#### Workspace setup ####
library(tidyverse)

#### Read raw data ####
# Replace the file path with your actual data file location
raw_data <- read_csv("data/01-raw_data/major-crime-indicators.csv")

#### Extract unique values for each model variable ####

# Unique values for OFFENCE
unique_offense <- raw_data %>%
  select(OFFENCE) %>%
  distinct() %>%
  pull(OFFENCE)

# Unique values for OCC_HOUR
unique_occ_hour <- raw_data %>%
  select(OCC_HOUR) %>%
  distinct() %>%
  pull(OCC_HOUR)

# Unique values for DIVISION
unique_division <- raw_data %>%
  select(DIVISION) %>%
  distinct() %>%
  pull(DIVISION)

# Unique values for LOCATION_TYPE
unique_location_type <- raw_data %>%
  select(LOCATION_TYPE) %>%
  distinct() %>%
  pull(LOCATION_TYPE)

# Unique values for PREMISES_TYPE
unique_premises_type <- raw_data %>%
  select(PREMISES_TYPE) %>%
  distinct() %>%
  pull(PREMISES_TYPE)

# Print the unique values
cat("Unique values for OFFENCE:\n")
print(unique_offense)

cat("\nUnique values for OCC_HOUR:\n")
print(unique_occ_hour)

cat("\nUnique values for DIVISION:\n")
print(unique_division)

cat("\nUnique values for LOCATION_TYPE:\n")
print(unique_location_type)

cat("\nUnique values for PREMISES_TYPE:\n")
print(unique_premises_type)
