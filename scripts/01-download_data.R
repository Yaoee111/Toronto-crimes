#### Preamble ####
# Purpose: Get data on 2024 major crimes indicator
# Author: Yiyi Yao
# Email: ee.yao@mail.utoronto.ca
# Date: 21 September 2024
# License: MIT
# Prerequisites: -


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)


#### Download data ####
# get package
package <- show_package("major-crime-indicators")
package

# get all resources for this package
resources <- list_package_resources("major-crime-indicators")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

head(data)

#### Save data ####
write_csv(data, "data/raw_data/toronto-crimes.csv") 
