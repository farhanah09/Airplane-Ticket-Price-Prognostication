<a href="https://app.commanddash.io/agent?github=https://github.com/farhanah09/Airplane-Ticket-Price-Prognostication"><img src="https://img.shields.io/badge/AI-Code%20Gen-EB9FDA"></a>

# Flight-Price-Prediction-Data-Science-R

The goal of the study is to analyze the flight booking dataset received from the "Ease My Trip" website and run various statistical hypothesis tests to analyze the following research questions: 
- How does the price vary across Airlines?
- How does the ticket price vary between Economy and Business class?
- Does the ticket price change depending on the departure time and arrival time?
- How does the ticket price vary closer to the departure dates?
- Is the ticket price influenced by Source and Destination?

### Data Sources
The features that we have in the data are Date of Journey, Journey_day, Airline, Flight code, Class, Source city,  Departure time,  Total_stops, Arrival city, Flight Duration, Days Left to Travel and Fare of the Ticket. We will be using this to predict the fare of the flight tickets. Table 1 shows the unique values for the main features and the range of these features.


### Data Quality and Transformations
The data looks in order and has no missingness. There was no data cleaning required. For our data analysis, we merged the two parts of the collected data to create one dataset with 11 features.  Two transformations were made to the features - (1) Date was in character format and was transformed to as.Date() to convert to Day of the Week and (2) Time of Departure was in character format and was changed to Lubridate Time format.
Initial Exploratory Data Analysis


<img width="317" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/fa853c36-dea2-491f-8b29-1034dc6e4804">

It has also been observed that we don’t have a uniform number of datapoints on all airlines and different classes (See Figures A1, A2 and A3 in Appendix). However this might be because some airlines operate more flights and most of the tickets sold are either economy class or premium economy. Hence the prediction for airlines with less data and first class tickets might have higher uncertainty. It is also seen that the number of flights is more or less the same on each day of the week. Hence the prediction might have similar uncertainty any day of the week.
The relation of the ticket fare vs multiple variables in the data was examined to understand the dependence of the fare on these variables. From the plots below, it can be seen that the fare of the ticket depends to a high extent on the days left to the flight, number of stops, the airline, ticket class (economy, business etc.) and departure time. Hence these should be the main elements of the model. Other variables such as, journey day (day of the week), sector, source and destination cities don’t have much effect on the fare


### In our project, we will be plotting the following features as part of our initial exploratory analysis:
Duration vs Price (economy and business)
Departure Time vs Price (economy and business)
Distribution of duration by airline 
Days to flight vs price (for different sectors and airlines)
Price distribution is based on the day of the week 
Distribution of departure time 

### Analysis
#### Model fitting 
We trained a Random Forest model with 25 trees to predict the price of air tickets based on different features such as departure and arrival locations, departure and arrival times, travel dates, airline carriers, seat class, and number of stops. Initially, we tested a Lasso model to predict the target variable. While the model had a relatively high R-squared value of 0.851, we observed that the plot of residuals displayed a pattern of uneven variance, indicating the presence of outliers or error terms that could potentially impact the model's predictive variability (Figure 2). Despite our efforts to rectify these issues, we could not obtain satisfactory results.
To overcome these limitations, we switched to a Random Forest model. The R-squared value of the Random Forest model of 0.929 was slightly higher than that of the Lasso model and demonstrated a statistically significant and high predictive ability (Figure 3). This suggests that the Random Forest model is better suited for our data and can provide more reliable predictions.

For more information check the  "DS- Final Report"

