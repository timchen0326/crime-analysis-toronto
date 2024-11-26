#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned crime dataset
# Author: Tim Chen
# Date: Today
# Contact: timwt.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The cleaned crime data must be saved as a Parquet file
# Any other information needed? Ensure the dataset path is correct.

#### Workspace setup ####
library(tidyverse)
library(arrow)  # For reading Parquet files
library(testthat)

# Read the cleaned dataset from a Parquet file
data <- read_parquet("data/02-analysis_data/cleaned_crime_data_for_model.parquet")

#### Test data ####

# Test that the dataset has rows greater than 0
test_that("dataset has rows", {
  expect_gt(nrow(data), 0)
})

# Test that the dataset has the expected columns
expected_columns <- c("PREMISES_TYPE", "TIME_OF_DAY", "VIOLENT_CRIME", "EVENT_UNIQUE_ID")
test_that("dataset has expected columns", {
  expect_true(all(expected_columns %in% colnames(data)))
})

# Test that the 'PREMISES_TYPE' column contains only valid values
valid_premises <- c("Apartment", "House", "Commercial", "Outside", "Educational", "Transit", "Other")
test_that("'PREMISES_TYPE' contains valid values", {
  expect_true(all(data$PREMISES_TYPE %in% valid_premises))
})

# Test that the 'TIME_OF_DAY' column contains only valid values
valid_times <- c("Early Morning", "Morning", "Afternoon", "Evening")
test_that("'TIME_OF_DAY' contains valid values", {
  expect_true(all(data$TIME_OF_DAY %in% valid_times))
})

# Test that the 'VIOLENT_CRIME' column contains only valid binary values (0 or 1)
valid_crime_values <- c(0, 1)
test_that("'VIOLENT_CRIME' contains valid binary values", {
  expect_true(all(data$VIOLENT_CRIME %in% valid_crime_values))
})

# Test that 'PREMISES_TYPE' column does not have empty strings
test_that("'PREMISES_TYPE' does not contain empty strings", {
  expect_false(any(data$PREMISES_TYPE == ""))
})

# Test that 'TIME_OF_DAY' column does not have empty strings
test_that("'TIME_OF_DAY' does not contain empty strings", {
  expect_false(any(data$TIME_OF_DAY == ""))
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_false(any(is.na(data)))
})
