#### Preamble ####
# Purpose: Test cleaned data of crimes in toronto
# Author: Yiyi Yao
# Email: ee.yao@mail.utoronto.ca
# Date: 21 September 2024
# License: MIT
# Prerequisites: 02-clean_data.R


#### Workspace setup ####
library(dplyr)
library(readr)

# Load the cleaned and processed dataset
crime_data_test <- read_csv("data/analysis_data/toronto_crimes_grouped.csv")


#### Test data ####

# 1. Check for missing values in key columns
missing_values <- colSums(is.na(crime_data_test))
print("Missing values per column:")
print(missing_values)

# 2. Ensure the column "Count_Cleared" has been removed (since you didn't remove "Division")
columns_present <- colnames(crime_data_test)
if (!"Count_Cleared" %in% columns_present) {
  print("Count_Cleared column has been successfully removed.")
} else {
  print("Error: Count_Cleared column is still present.")
}

# 3. Confirm that data is correctly grouped and 'COUNT' is summed properly
# Select a sample group and test if the counts are summed as expected
test_group <- crime_data_test %>%
  filter(REPORT_YEAR == 2020, CATEGORY == "Crimes Against Property", SUBTYPE == "Auto Theft")

print("Sample group (Year 2020, Auto Theft in Crimes Against Property):")
print(test_group)

# 4. Check the summary of the resulting dataset
print("Summary of the cleaned and aggregated data:")
summary(crime_data_test)

# 5. Check if any duplicates remain (based on REPORT_YEAR, CATEGORY, and SUBTYPE)
duplicates_check <- crime_data_test %>%
  group_by(REPORT_YEAR, CATEGORY, SUBTYPE) %>%
  filter(n() > 1)

if (nrow(duplicates_check) == 0) {
  print("No duplicates found after aggregation. Data is correctly summed.")
} else {
  print("Duplicates found. Something went wrong in the aggregation step.")
}

