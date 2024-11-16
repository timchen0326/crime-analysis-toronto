#### Preamble ####
# Purpose: Cleans the raw crime data for analysis with grouped variables
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Downloaded raw crime data
# Any other information needed? Ensure dependencies are installed, and data file path is correct.

#### Workspace Setup ####
library(tidyverse)
library(janitor)
library(arrow)
library(lubridate)  # For date operations

#### Read Data ####
# Replace the file path with the correct path to your data file
raw_data <- read_csv("data/01-raw_data/major-crime-indicators.csv")

#### Define Violent and Non-Violent Offenses ####
violent_offenses <- c(
  "Assault", "Assault Bodily Harm", "Assault With Weapon", "Assault Peace Officer",
  "Aggravated Assault", "Assault - Force/Thrt/Impede", "Assault - Resist/ Prevent Seiz",
  "Assault Peace Officer Wpn/Cbh", "Aggravated Assault Avails Pros", "Aggravated Aslt Peace Officer",
  "Unlawfully Causing Bodily Harm", "Crim Negligence Bodily Harm", "Administering Noxious Thing",
  "Air Gun Or Pistol: Bodily Harm", "Traps Likely Cause Bodily Harm", "Set/Place Trap/Intend Death/Bh",
  "Disarming Peace/Public Officer", "Hoax Terrorism Causing Bodily",
  "Robbery - Mugging", "Robbery - Business", "Robbery With Weapon", "Robbery - Swarming",
  "Robbery - Purse Snatch", "Robbery - Other", "Robbery - Financial Institute",
  "Robbery - Armoured Car", "Robbery - Vehicle Jacking", "Robbery - Home Invasion",
  "Robbery - Taxi", "Robbery - Delivery Person", "Robbery - Atm", "Robbery To Steal Firearm",
  "Discharge Firearm With Intent", "Pointing A Firearm", "Discharge Firearm - Recklessly",
  "Use Firearm / Immit Commit Off"
)

non_violent_offenses <- c(
  "Theft Over", "Theft Of Motor Vehicle", "Theft From Motor Vehicle Over",
  "Theft From Mail / Bag / Key", "Theft Over - Shoplifting", "Theft - Misapprop Funds Over",
  "Theft Over - Distraction", "Theft Over - Bicycle", "Theft Of Utilities Over",
  "B&E W'Intent", "B&E", "B&E Out", "B&E - To Steal Firearm", "B&E - M/Veh To Steal Firearm",
  "Unlawfully In Dwelling-House"
)

#### Fix Columns and Filter Data ####
cleaned_data <- raw_data %>%
  # Ensure date columns are parsed correctly
  mutate(
    REPORT_DATE = as_date(REPORT_DATE, format = "%Y-%m-%d"),
    # Create binary outcome for violent crime
    VIOLENT_CRIME = case_when(
      OFFENCE %in% violent_offenses ~ 1,
      OFFENCE %in% non_violent_offenses ~ 0,
      TRUE ~ NA_real_  # Exclude offenses not in either list
    ),
    # Categorize OCC_HOUR into time of day
    TIME_OF_DAY = factor(
      case_when(
        OCC_HOUR >= 0 & OCC_HOUR < 6 ~ "Early Morning",
        OCC_HOUR >= 6 & OCC_HOUR < 12 ~ "Morning",
        OCC_HOUR >= 12 & OCC_HOUR < 18 ~ "Afternoon",
        OCC_HOUR >= 18 & OCC_HOUR <= 23 ~ "Evening"
      ),
      levels = c("Early Morning", "Morning", "Afternoon", "Evening")
    ),
    # Remove whitespace from PREMISES_TYPE to avoid unexpected NA values
    PREMISES_TYPE = str_trim(PREMISES_TYPE, side = "both")
  ) %>%
  # Filter for summer month (July in this example)
  filter(month(REPORT_DATE) == 7) %>%
  # Remove all rows with NA in any of the specified columns
  drop_na(EVENT_UNIQUE_ID, PREMISES_TYPE, TIME_OF_DAY, VIOLENT_CRIME) %>%
  # Select relevant columns
  select(EVENT_UNIQUE_ID, PREMISES_TYPE, TIME_OF_DAY, VIOLENT_CRIME)

#### Save Cleaned Data ####
# Save cleaned data for modeling
write_parquet(cleaned_data, "data/02-analysis_data/cleaned_crime_data_for_model.parquet")
