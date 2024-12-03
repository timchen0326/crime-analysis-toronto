#### Preamble ####
# Purpose: Runs the plumber API to predict violent crime likelihood
# Author: Tim Chen
# Date: [Today's Date]
# Contact: timwt.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure the `api.R` script is in the specified path and contains the defined endpoints.
#                 Ensure the required packages (`plumber`, `rstanarm`, `dplyr`) are installed.

#### Load Plumber API ####
library(plumber)

# Load and run the API
pr <- plumb("scripts/api.R")  # Path to your API script
pr$run(port = 8000)           # Run on port 8000
