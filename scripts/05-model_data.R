#### Preamble ####
# Purpose: Models violent crime likelihood using binary outcome and predictors for crime characteristics
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Cleaned crime data with binary violent crime classification and relevant predictors
# Any other information needed? Ensure dependencies are installed and the data file path is correct.

#### Workspace Setup ####
library(tidyverse)
library(arrow)
library(rstanarm)

#### Read Cleaned Data ####
# Load the cleaned data
analysis_data <- read_parquet("data/02-analysis_data/cleaned_crime_data_for_model.parquet")

#### Check Data Structure ####
# Ensure predictors are correctly encoded as factors
analysis_data <- analysis_data %>%
  mutate(
    PREMISES_TYPE = as.factor(PREMISES_TYPE),
    TIME_OF_DAY = as.factor(TIME_OF_DAY)
  )

#### Fit Logistic Regression Model ####
violent_crime_model <- stan_glm(
  VIOLENT_CRIME ~ PREMISES_TYPE + TIME_OF_DAY,
  data = analysis_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 304
)

#### Save Model ####
# Save the model for reuse
saveRDS(violent_crime_model, file = "models/violent_crime_model.rds")