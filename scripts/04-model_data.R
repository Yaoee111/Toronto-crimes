#### Preamble ####
# Purpose: Model cleaned data of crimes in toronto
# Author: Yiyi Yao
# Email: ee.yao@mail.utoronto.ca
# Date: 21 September 2024
# License: MIT
# Prerequisites: 02-clean_data.R


#### Workspace setup ####
# Load necessary libraries
library(dplyr)
library(ggplot2)
library(caret)  # For model building
library(readr)

# Load the cleaned dataset
crime_data <- read_csv("data/analysis_data/toronto_crimes_grouped.csv")

# Check column names
colnames(crime_data)

# Rename the column if needed (assuming the column is COUNT_)
# This step is optional, depending on the actual name of the column
colnames(crime_data)[which(colnames(crime_data) == "COUNT_")] <- "COUNT"

# Convert categorical variables to factors
crime_data$CATEGORY <- as.factor(crime_data$CATEGORY)
crime_data$SUBTYPE <- as.factor(crime_data$SUBTYPE)

# 1. Split data into training and testing sets
set.seed(123)  # For reproducibility
train_index <- createDataPartition(crime_data$COUNT, p = 0.8, list = FALSE)
train_data <- crime_data[train_index, ]
test_data <- crime_data[-train_index, ]

# 2. Build a linear regression model to predict COUNT based on REPORT_YEAR and CATEGORY
linear_model <- lm(COUNT ~ REPORT_YEAR + CATEGORY, data = train_data)

# 3. Summary of the model to check its performance
summary(linear_model)

# 4. Predict on the test data
predictions <- predict(linear_model, newdata = test_data)

# 5. Evaluate the model's performance using RMSE (Root Mean Squared Error)
rmse_value <- sqrt(mean((test_data$COUNT - predictions)^2))
print(paste("RMSE of the model:", rmse_value))

# 6. Visualize actual vs predicted values
ggplot() +
  geom_point(aes(x = test_data$COUNT, y = predictions), color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  labs(x = "Actual COUNT", y = "Predicted COUNT", title = "Actual vs Predicted Crime Counts")


#### Save model ####
saveRDS(linear_model, "model/crime_count_model.rds")
