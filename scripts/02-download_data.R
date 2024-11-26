#### Preamble ####
# Purpose: Download and save raw data for Major Crime Indicators in Toronto
# Author: Tim Chen
# Date: Today
# Contact: timwt.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `opendatatoronto`, `dplyr`, `readr`, and `here` packages must be installed and loaded.
# - Ensure you are in the correct working directory to save the data.
# - The dataset "Major Crime Indicators" must be available on Open Data Toronto.

#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readr) # For writing data to CSV files
library(here)  # For handling file paths

# Create directories if not already present
dir.create(here::here("data"), showWarnings = FALSE)
dir.create(here::here("data/01-raw_data"), showWarnings = FALSE)

# Get package information
package <- show_package("major-crime-indicators")
print(package)

# Get all resources for this package
resources <- list_package_resources("major-crime-indicators")

# Identify datastore resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Load the first datastore resource as a sample
data <- filter(datastore_resources, row_number() == 1) %>% get_resource()

# Save the raw data to data/01-raw_data directory
output_path <- here::here("data/01-raw_data/major-crime-indicators.csv")
write_csv(data, output_path)
