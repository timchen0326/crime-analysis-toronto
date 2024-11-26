# Crime Analysis in Toronto

## Overview

This repository contains the analysis and findings for the paper *Examining the Influence of Premises Type and Time of Day on Violent Crime in Toronto: A Bayesian Approach to Analyzing Contextual and Temporal Factors in Urban Crime Dynamics*. The project leverages Bayesian logistic regression to uncover the relationship between violent crimes, premises type, and time of day in Toronto using the Major Crime Indicators dataset.

## File Structure

The repository is structured as follows:

- `data/00-simulated_data`: Contains the simulated dataset used for testing scripts and analyses.
  - `simulated_crime_data.csv`: A sample dataset for testing and experimentation.
- `data/01-raw_data`: Contains the raw crime data as obtained from Open Data Toronto.
- `data/02-analysis_data`: Contains the cleaned dataset ready for modeling and analysis.
  - `cleaned_crime_data_for_model.parquet`: Cleaned and pre-processed dataset used in the analysis.
- `models`: Stores fitted models.
  - `violent_crime_model.rds`: The Bayesian logistic regression model used to analyze violent crime data.
- `other`: Contains additional project-related files.
  - `llm_usage/usage.txt`: Log of interactions with LLMs for code and text generation.
  - `sketches`: Includes visual sketches and preliminary visualizations, such as:
    - `dataset.png`: Overview of the dataset.
    - `graph1.png`, `graph2.png`: Graphical summaries or visualizations of key findings.
- `paper`: Contains files used to generate the final paper.
  - `paper.qmd`: Quarto markdown file used to write and compile the paper.
  - `references.bib`: Bibliography file with references used in the paper.
  - `paper.pdf`: The final compiled PDF of the paper.
- `scripts`: R scripts used in various stages of the analysis.
  - `00-simulate_data.R`: Script to generate simulated data.
  - `01-test_simulated_data.R`: Tests and validates the simulated data workflow.
  - `02-download_data.R`: Script to download raw crime data from Open Data Toronto.
  - `03-clean_data.R`: Cleans and pre-processes raw data for analysis.
  - `04-test_analysis_data.R`: Validates the cleaned dataset.
  - `05-model_data.R`: Fits the Bayesian logistic regression model to the data.

### Obtaining the Raw Data

To obtain the raw data for the "Major Crime Indicators" dataset, users can simply run the `02-download_data.R` script located in the `scripts` folder. This script leverages the `opendatatoronto` package to download the dataset directly from the [Open Data Toronto portal](https://open.toronto.ca/dataset/major-crime-indicators/) and saves it as a CSV file in the `data/01-raw_data/` directory.

The script performs the following steps:
1. Sets up the workspace and ensures required directories (`data/01-raw_data/`) are created.
2. Fetches the dataset from Open Data Toronto using its API.
3. Saves the raw data file as `major-crime-indicators.csv` in the appropriate folder.

**Prerequisites:**
- The following R packages must be installed: `opendatatoronto`, `dplyr`, `readr`, and `here`.
- Ensure you are in the correct working directory (the root of this repository) before running the script.

To execute the process, open the `02-download_data.R` script and run it in your R environment. The data will be downloaded and saved automatically.


## Statement on LLM Usage

Aspects of this project were developed with assistance from ChatGPT-4o. The abstract, introduction, and other text components were crafted with input from ChatGPT-4o, and the interaction history is documented in `other/llm_usage/usage.txt`. Additionally, ChatGPT-4o was used to provide suggestions and guidance for script development and refinement.
