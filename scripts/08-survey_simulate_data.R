#### Preamble ####
# Purpose: Simulate a dataset of crime-related survey responses, including 
# variables related to violent crime, alcohol involvement, area familiarity, 
# and lighting conditions.
# Author: Tim Chen
# Contact: timwt.chen@mail.utoronto.ca
# Date: Today
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed.
# Outputs: A CSV file ("survey_simulated_crime_data.csv") containing 1000 rows and 4 variables:
#          - `VIOLENT_CRIME`: Binary variable indicating whether a crime was violent (1) or not (0).
#          - `ALCOHOL_INVOLVED`: Binary variable indicating whether alcohol was involved (1 = Yes, 0 = No).
#          - `AREA_FAMILIARITY`: Binary variable indicating whether the respondent was familiar with the area (1 = Yes, 0 = No).
#          - `LIGHTING_CONDITIONS`: Categorical variable describing the lighting conditions at the time of the incident 
#                                   ('Well-lit', 'Dimly lit', 'Dark').

# Load required package
library(tidyverse)

# Set seed for reproducibility
set.seed(304)

# Simulate data
n <- 1000  # Number of observations
simulated_data <- tibble(
  VIOLENT_CRIME = rbinom(n, 1, 0.4),  # 40% probability of violent crime
  ALCOHOL_INVOLVED = rbinom(n, 1, 0.3),  # 30% probability alcohol involved
  AREA_FAMILIARITY = rbinom(n, 1, 0.4),  # 40% probability familiar with the area
  LIGHTING_CONDITIONS = sample(c("Well-lit", "Dimly lit", "Dark"), n, replace = TRUE, prob = c(0.4, 0.4, 0.2)) # Lighting conditions
)


# Save simulated data to a CSV file
write_csv(simulated_data, "data/00-simulated_data/survey_simulated_crime_data.csv")
