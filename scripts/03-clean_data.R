#### Preamble ####
# Purpose: Cleans the raw motor vehicle collision data for analysis
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Downloaded raw data on motor vehicle collisions
# Any other information needed? Ensure dependencies are installed, and data file path is correct.

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/Motor Vehicle Collisions with KSI Data - 4326.csv")

# Initial data cleaning and transformation
cleaned_data <- 
  raw_data |> 
  # Select relevant columns for your analysis
  select(
    ACCNUM, DATE, TIME, ROAD_CLASS, DISTRICT, TRAFFCTL, VISIBILITY, LIGHT, 
    RDSFCOND, ACCLOC, ACCLASS, IMPACTYPE, INVTYPE, INVAGE, INJURY, DRIVCOND
  ) |>
  # Filter out rows with missing or irrelevant injury data
  filter(!is.na(INJURY), !is.na(DRIVCOND), !is.na(LIGHT), !is.na(RDSFCOND)) |>
  # Convert injury severity to binary variable
  mutate(INJURY_SEVERE = if_else(INJURY == "Fatal", 1, 0)) |>
  # Combine categories for `DRIVCOND`
  mutate(
    DRIVCOND_GROUP = case_when(
      DRIVCOND %in% c("Ability Impaired, Alcohol Over .08", "Had Been Drinking", "Ability Impaired, Drugs") ~ "Impaired",
      DRIVCOND %in% c("Inattentive", "Fatigue", "Medical or Physical Disability") ~ "Distracted/Impaired",
      DRIVCOND == "Normal" ~ "Normal",
      TRUE ~ "Other"
    ),
    # Combine categories for `RDSFCOND`
    RDSFCOND_GROUP = case_when(
      RDSFCOND == "None" ~ "Good Condition",
      RDSFCOND %in% c("Ice", "Slush", "Packed Snow", "Loose Snow", "Loose Sand or Gravel") ~ "Hazardous Surface",
      RDSFCOND == "Wet" ~ "Wet",
      TRUE ~ "Other"
    ),
    # Combine categories for `LIGHT`
    LIGHT_GROUP = case_when(
      LIGHT %in% c("Daylight", "Dawn", "Dusk") ~ "Natural Light",
      LIGHT %in% c("Dark, artificial", "Dawn, artificial", "Daylight, artificial", "Dusk, artificial") ~ "Artificial Light",
      TRUE ~ "Other"
    )
  ) |>
  # Convert combined group variables to factors
  mutate(
    DRIVCOND_GROUP = factor(DRIVCOND_GROUP),
    RDSFCOND_GROUP = factor(RDSFCOND_GROUP),
    LIGHT_GROUP = factor(LIGHT_GROUP)
  ) |>
  # Remove rows with missing or invalid data
  drop_na()

#### Save cleaned data ####
write_parquet(cleaned_data, sink = "data/02-analysis_data/cleaned_motor_vehicle_collisions.parquet")
