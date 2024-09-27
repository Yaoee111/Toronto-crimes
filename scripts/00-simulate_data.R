#### Preamble ####
# Purpose: Simulate data on crimes in Toronto in a year
# Author: Yiyi Yao
# Email: ee.yao@mail.utoronto.ca
# Date: 21 September 2024
# Prerequisites: -


#### Workspace setup ####
library(tidyverse)


# Assuming we have determined the average daily crimes from the historical data
avg_crimes_per_day <- 100
std_dev <- 15

# Simulate crime occurrences for a year (365 days)
set.seed(123) # For reproducibility
simulated_crimes <- rnorm(n = 365, mean = avg_crimes_per_day, sd = std_dev)

# Create a dataframe for the simulation result
simulation_data <- data.frame(
  Day = 1:365,
  SimulatedCrimes = round(simulated_crimes) 
)

head(simulation_data)

# Plotting the simulated crime occurrences over the year
ggplot(simulation_data, aes(x = Day, y = SimulatedCrimes)) +
  geom_line() +
  labs(title = "Simulated Daily Crime Occurrences Over a Year", x = "Day of the Year", y = "Number of Crimes") +
  theme_minimal()


#### Save data ####
write_csv(simulation_data, "data/simulated_data/simulation_data.csv")
