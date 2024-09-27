#### Preamble ####
# Purpose: Clean data for crimes in toronto
# Author: Yiyi Yao
# Email: ee.yao@mail.utoronto.ca
# Date: 21 September 2024
# License: MIT
# Prerequisites: 01-download_data.R


#### Workspace setup ####
library(dplyr)
library(readr)


#### Clean data ####
# Load the dataset 
crime_data <- read_csv("data/raw_data/toronto-crimes.csv")

# Remove the seventh column (Count_Cleared)
crime_data_cleaned <- crime_data[, -c(7)]

# Group the data by 'CATEGORY' and sort by 'REPORT_YEAR' (from oldest to nearest)
crime_data_grouped <- crime_data_cleaned %>%
  arrange(CATEGORY, REPORT_YEAR)  # Sort by CATEGORY first, then REPORT_YEAR

# View the cleaned and organized dataset
head(crime_data_grouped)


#### Save data ####
write_csv(crime_data_grouped, "data/analysis_data/toronto_crimes_grouped.csv")
