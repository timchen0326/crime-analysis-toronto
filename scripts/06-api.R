#### Preamble ####
# Purpose: Models violent crime likelihood using binary outcome and predictors for crime characteristics
# Author: Tim Chen
# Date: [Today's Date]
# Contact: timwt.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The cleaned crime data must be saved as a Parquet file with binary violent crime classification and relevant predictors.
# Any other information needed? Ensure dependencies are installed and the dataset file path is correct.


# Load required libraries
library(plumber)
library(rstanarm)
library(dplyr)

model <- readRDS(file = here::here("models/violent_crime_model.rds"))

#* @apiTitle Violent Crime Prediction API
#* @apiDescription Predict the likelihood of violent crimes based on premises type and time of day.
#* @apiVersion 1.0.0
#* @apiContact list(name = "Support", url = "https://github.com/your-repo", email = "support@yourdomain.com")

#* Predict violent crime likelihood
#* @param premises_type Type of premises (e.g., "Apartment", "House", "Commercial", "Transit", "Outside", "Educational").
#* @param time_of_day Time of day (e.g., "Early Morning", "Morning", "Afternoon", "Evening").
#* @get /predict
function(premises_type, time_of_day) {
  # Validate input
  if (missing(premises_type) || missing(time_of_day)) {
    return(list(
      status = "error",
      message = "Missing required parameters. Both 'premises_type' and 'time_of_day' are required.",
      valid_inputs = list(
        premises_type = c("Apartment", "House", "Commercial", "Transit", "Outside", "Educational", "Other"),
        time_of_day = c("Early Morning", "Morning", "Afternoon", "Evening")
      )
    ))
  }
  
  # Check that the input values are valid
  valid_premises <- levels(model$data$PREMISES_TYPE)
  valid_times <- levels(model$data$TIME_OF_DAY)
  
  if (!(premises_type %in% valid_premises)) {
    return(list(
      status = "error",
      message = paste("Invalid premises_type. Valid values are:", paste(valid_premises, collapse = ", "))
    ))
  }
  
  if (!(time_of_day %in% valid_times)) {
    return(list(
      status = "error",
      message = paste("Invalid time_of_day. Valid values are:", paste(valid_times, collapse = ", "))
    ))
  }
  
  # Create a data frame for prediction
  new_data <- data.frame(
    PREMISES_TYPE = factor(premises_type, levels = valid_premises),
    TIME_OF_DAY = factor(time_of_day, levels = valid_times)
  )
  
  # Make predictions using posterior_predict
  prediction <- posterior_predict(model, newdata = new_data)
  mean_prob <- mean(prediction) # Mean probability from posterior samples
  
  # Return the prediction result
  return(list(
    status = "success",
    prediction = list(
      premises_type = premises_type,
      time_of_day = time_of_day,
      predicted_probability = round(mean_prob, 4),
      explanation = paste(
        "Based on the Bayesian model, the probability of a violent crime occurring",
        "in a", premises_type, "during the", time_of_day, "is approximately",
        round(mean_prob * 100, 2), "%."
      )
    )
  ))
}

