library(tidyverse)
library(modelr)
library(lubridate)

economy_data = read_csv("Flights Price Prediction Dataset\\economy.csv", show_col_types = FALSE)
business_data = read_csv("Flights Price Prediction Dataset\\business.csv", show_col_types = FALSE)
economy_data$time_taken = lubridate::hm(economy_data$time_taken)
business_data$time_taken = lubridate::hm(business_data$time_taken)
head(economy_data)
head(business_data)

#distribution with respect to departure time

ggplot (data = economy_data) +
  geom_histogram(mapping = aes(x=dep_time))

ggplot (data = business_data) +
  geom_histogram(mapping = aes(x=dep_time))


#distribution with respect to duration


ggplot (data = economy_data) +
  geom_histogram(mapping = aes(x=(lubridate::as.duration(time_taken)/3600)))

ggplot (data = business_data) +
  geom_histogram(mapping = aes(x=(lubridate::as.duration(time_taken)/3600)))

