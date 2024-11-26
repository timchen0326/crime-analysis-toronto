#### Preamble ####
# Purpose: Tests the structure and validity of the simulated crime dataset.
# Author: Tim Chen
# Date: Today
# Contact: timwt.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - The simulation script must have been run to generate the dataset
# Any other information needed? Make sure you are in the correct working directory.

#### Workspace setup ####
library(tidyverse)

# Load the simulated dataset
crime_data <- read_csv("data/00-simulated_data/simulated_crime_data.csv")

# Test if the data was successfully loaded
if (exists("crime_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 151 rows
if (nrow(crime_data) == 151) {
  message("Test Passed: The dataset has 151 rows.")
} else {
  stop("Test Failed: The dataset does not have 151 rows.")
}

# Check if the dataset has 4 columns
if (ncol(crime_data) == 4) {
  message("Test Passed: The dataset has 4 columns.")
} else {
  stop("Test Failed: The dataset does not have 4 columns.")
}

# Check if all values in the 'incident_id' column are unique
if (n_distinct(crime_data$incident_id) == nrow(crime_data)) {
  message("Test Passed: All values in 'incident_id' are unique.")
} else {
  stop("Test Failed: The 'incident_id' column contains duplicate values.")
}

# Check if the 'premises_type' column contains only valid premises types
valid_premises <- c("Apartment", "House", "Commercial", 
                    "Outside", "Educational", "Transit", "Other")

if (all(crime_data$premises_type %in% valid_premises)) {
  message("Test Passed: The 'premises_type' column contains only valid premises types.")
} else {
  stop("Test Failed: The 'premises_type' column contains invalid values.")
}

# Check if the 'time_of_day' column contains only valid time categories
valid_times <- c("Early Morning", "Morning", "Afternoon", "Evening")

if (all(crime_data$time_of_day %in% valid_times)) {
  message("Test Passed: The 'time_of_day' column contains only valid time categories.")
} else {
  stop("Test Failed: The 'time_of_day' column contains invalid values.")
}

# Check if the 'crime_type' column contains only valid crime types
valid_crimes <- c("Violent", "Non-Violent")

if (all(crime_data$crime_type %in% valid_crimes)) {
  message("Test Passed: The 'crime_type' column contains only valid crime types.")
} else {
  stop("Test Failed: The 'crime_type' column contains invalid values.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(crime_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'incident_id', 'premises_type', 'time_of_day', and 'crime_type' columns
if (all(crime_data$incident_id != "" & 
        crime_data$premises_type != "" & 
        crime_data$time_of_day != "" & 
        crime_data$crime_type != "")) {
  message("Test Passed: There are no empty strings in 'incident_id', 'premises_type', 'time_of_day', or 'crime_type'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'crime_type' column has at least two unique values
if (n_distinct(crime_data$crime_type) >= 2) {
  message("Test Passed: The 'crime_type' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'crime_type' column contains less than two unique values.")
}
