# Crime Analysis in Toronto

## Overview

This repository contains the analysis and findings for the paper *Examining the Influence of Premises Type and Time of Day on Violent Crime in Toronto: A Bayesian Approach to Analyzing Contextual and Temporal Factors in Urban Crime Dynamics*. The project leverages Bayesian logistic regression to uncover the relationship between violent crimes, premises type, and time of day in Toronto using the Major Crime Indicators dataset.

## File Structure

The repository is structured as follows:

### Data
- **`data/00-simulated_data`**: Contains the simulated dataset used for testing scripts and analyses.
  - `simulated_crime_data.csv`: A sample dataset for testing and experimentation.
- **`data/01-raw_data`**: Contains the raw crime data as obtained from Open Data Toronto, since the file is too large, follow the steps below to download.
- **`data/02-analysis_data`**: Contains the cleaned dataset ready for modeling and analysis.
  - `cleaned_crime_data_for_model.parquet`: Cleaned and pre-processed dataset used in the analysis.

### Models
- **`models`**: Stores fitted models.
  - `violent_crime_model.rds`: The Bayesian logistic regression model used to analyze violent crime data.

### Other
- **`other`**: Contains additional project-related files.
  - **`llm_usage/usage.txt`**: Log of interactions with LLMs for code and text generation.
  - **`sketches`**: Includes visual sketches and preliminary visualizations:
    - `dataset.png`: Overview of the dataset.
    - `graph1.png`, `graph2.png`: Graphical summaries or visualizations of key findings.
  - **`datasheet`**
    - `datasheet.pdf`: Provides an overview of the data, including variables, sources, and metadata.
    - `datasheet.qmd`: The Quarto Markdown file used to generate the datasheet document.

### Paper
- **`paper`**: Contains files used to generate the final paper.
  - `paper.qmd`: Quarto markdown file used to write and compile the paper.
  - `references.bib`: Bibliography file with references used in the paper.
  - `paper.pdf`: The final compiled PDF of the paper.

### Scripts
- **`scripts`**: R scripts used in various stages of the analysis.
  - `00-simulate_data.R`: Script to generate simulated data.
  - `01-test_simulated_data.R`: Tests and validates the simulated data workflow.
  - `02-download_data.R`: Script to download raw crime data from Open Data Toronto.
  - `03-clean_data.R`: Cleans and pre-processes raw data for analysis.
  - `04-test_analysis_data.R`: Validates the cleaned dataset.
  - `05-model_data.R`: Fits the Bayesian logistic regression model to the data.
  - `06-api.R`: Contains the implementation for setting up a simple API endpoint to serve pre-processed data or analysis results.
  - `07-run_api.R`: Script to run and test the API locally, ensuring smooth functionality and integration with the analysis pipeline.
  - `08-survey_simulate_data.R`: Script used to generate and analyze simulated survey data related to crime analysis.


## Obtaining the Raw Data

To obtain the raw data for the "Major Crime Indicators" dataset, users can simply run the `02-download_data.R` script located in the `scripts` folder. This script leverages the `opendatatoronto` package to download the dataset directly from the [Open Data Toronto portal](https://open.toronto.ca/dataset/major-crime-indicators/) and saves it as a CSV file in the `data/01-raw_data/` directory.

The script performs the following steps:
1. Sets up the workspace and ensures required directories (`data/01-raw_data/`) are created.
2. Fetches the dataset from Open Data Toronto using its API.
3. Saves the raw data file as `major-crime-indicators.csv` in the appropriate folder.

**Prerequisites:**
- The following R packages must be installed: `opendatatoronto`, `dplyr`, `readr`, and `here`.
- Ensure you are in the correct working directory (the root of this repository) before running the script.

To execute the process, open the `02-download_data.R` script and run it in your R environment. The data will be downloaded and saved automatically.

## Running the Violent Crime Prediction API

### `07-run_api.R`
**Purpose**: This script runs the REST API defined in `06-api.R` and starts the server, enabling predictions for the likelihood of violent crimes based on premises type and time of day.

**Steps to Run**:
1. Ensure the following pre-requisites are met:
   - The `06-api.R` file is in the `scripts/` folder and correctly configured.
   - The `models/violent_crime_model.rds` file exists in the `models/` directory and contains the trained Bayesian logistic regression model.
   - The required R packages (`plumber`, `rstanarm`, `dplyr`, `here`) are installed.
2. Open the `07-run_api.R` file in your R environment.
3. The API will start and listen on port 8000. By default, it will be 
accessible at http://127.0.0.1:8000.

### API Features
Once the API is running, you can send GET requests to the `/predict` endpoint to predict violent crime likelihood. The API accepts the following parameters:

- `premises_type`: Type of premises where the incident occurs (e.g., "Apartment", "House", "Commercial", etc.).
- `time_of_day`: Time of day when the incident occurs (e.g., "Early Morning", "Morning", etc.).

#### Example Request
You can test the API using tools like curl, Postman, or your browser. For example, using curl:

```bash
curl "http://127.0.0.1:8000/predict?premises_type=Apartment&time_of_day=Morning"
```
#### Response
The API will return a JSON response containing:
- Predicted probability of a violent crime.
- An explanation of the result.

Note: Make sure the API remains running in your R environment while sending requests.


## Statement on LLM Usage

Aspects of this project were developed with assistance from ChatGPT-4o. The abstract, introduction, and other text components were crafted with input from ChatGPT-4o, and the interaction history is documented in `other/llm_usage/usage.txt`. Additionally, ChatGPT-4o was used to provide suggestions and guidance for script development and refinement.
