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


#Price distribution based on the day of the week
  #Converting date to weekday
economy_data$date <- as.Date(economy_data$date)
economy_data$weekday <- strftime(economy_data$date,"%A") 
business_data$date <- as.Date(business_data$date)
business_data$weekday <- strftime(business_data$date,"%A")
  #Plotting price vs day of economy
weekday_graph_economy <- ggplot (data = economy_data) +
  geom_point(mapping = aes (x = weekday, y = price))+
  geom_point(mapping = aes (x = weekday, y = median(price)),color="red")+
  geom_point(mapping = aes (x = weekday, y = mean(price)),color="gold2")
  #Plotting price vs day of business
weekday_graph_business <- ggplot (data = business_data) +
  geom_point(mapping = aes (x = weekday, y = price))+
  geom_point(mapping = aes (x = weekday, y = median(price)),color="red")+
  geom_point(mapping = aes (x = weekday, y = mean(price)),color="gold2")


