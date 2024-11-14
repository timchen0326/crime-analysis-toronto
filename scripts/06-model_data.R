#### Preamble ####
# Purpose: Models injury severity using grouped driver conditions, road surface conditions, and lighting conditions
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Cleaned motor vehicle collision data with combined categories
# Any other information needed? Ensure dependencies are installed and the data file path is correct.

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/cleaned_motor_vehicle_collisions.parquet")

### Model data ####

# Logistic regression for injury severity using grouped categories
injury_severity_model <- stan_glm(
  INJURY_SEVERE ~ DRIVCOND_GROUP + RDSFCOND_GROUP + LIGHT_GROUP,
  data = analysis_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 215
)

# Save the model
saveRDS(injury_severity_model, file = "models/injury_severity_model.rds")
