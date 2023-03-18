library(tidyverse)
library(modelr)

economy_data = read_csv("Flights Price Prediction Dataset\\economy.csv", show_col_types = FALSE)
business_data = read_csv("Flights Price Prediction Dataset\\business.csv", show_col_types = FALSE)
head(economy_data)
head(business_data)

#distribution with respect to departure time

ggplot (data = economy_data) +
  geom_histogram(mapping = aes(x=dep_time))

ggplot (data = business_data) +
  geom_histogram(mapping = aes(x=dep_time))


