#### Preamble ####
# Purpose: Simulate a dataset of crime incidents in Toronto, including 
# premises type, time of day, and crime type.
# Author: Tim Chen
# Contact: timwt.chen@mail.utoronto.ca
# Date: Today
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed.

#### Workspace setup ####
library(tidyverse)
set.seed(304)

#### Simulate data ####
# Premises types and their probabilities
premises_types <- c("Apartment", "House", "Commercial", 
                    "Outside", "Educational", "Transit", "Other")
premises_probs <- c(0.3, 0.25, 0.15, 0.1, 0.1, 0.05, 0.05)

# Times of day and their probabilities
times_of_day <- c("Early Morning", "Morning", "Afternoon", "Evening")
time_probs <- c(0.2, 0.25, 0.3, 0.25)

# Crime types and their probabilities
crime_types <- c("Violent", "Non-Violent")
crime_probs <- c(0.4, 0.6)

# Create a dataset by randomly assigning premises, time, and crime type to incidents
crime_data <- tibble(
  incident_id = paste("Incident", 1:151),  # Add "Incident" to make it a character
  premises_type = sample(
    premises_types,
    size = 151,
    replace = TRUE,
    prob = premises_probs
  ),
  time_of_day = sample(
    times_of_day,
    size = 151,
    replace = TRUE,
    prob = time_probs
  ),
  crime_type = sample(
    crime_types,
    size = 151,
    replace = TRUE,
    prob = crime_probs
  )
)

#### Save data ####
write_csv(crime_data, "data/00-simulated_data/simulated_crime_data.csv")
