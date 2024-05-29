library(tidyverse)
library(xts)

getwd()

data_path <- "dataset.rds"

# Attempt to read the RDS file again
data <- readRDS(data_path)

# Check the structure of the data to ensure it's a dataframe
str(data)
  
for (i in names(data)) {
  # Extract the xts object
  data_xts <- data[[i]]
  
  # Convert the index to a column at the beginning of the dataframe
  data_df <- as.data.frame(data_xts)
  data_df$Date <- index(data_xts)  # Add the date as the last column temporarily
  
  # Move the Date column to the first position
  data_df <- data_df[, c(ncol(data_df), 1:(ncol(data_df)-1))]
  
  # Write to CSV, ensuring date column is included at the beginning
  write_csv(data_df, sprintf("/Users/ruimaciel/Desktop/%s.csv", i))
}