# Flight-Price-Prediction-Data-Science-R

The goal of the study is to analyze the flight booking dataset received from the "Ease My Trip" website and run various statistical hypothesis tests to analyze the following research questions: 
- How does the price vary across Airlines?
- How does the ticket price vary between Economy and Business class?
- Does the ticket price change depending on the departure time and arrival time?
- How does the ticket price vary closer to the departure dates?
- Is the ticket price influenced by Source and Destination?

### Data Sources
Data was collected from the “Ease My Trip” website, which contains flight travel information between India’s top 6 metro cities.  A total of 300261 distinct flight booking options were extracted from the site for 50 days, from February 11th to March 31st, 2022. There were two parts to the dataset: economy class tickets and business class tickets. 


### Data Quality and Transformations
The data looks in order and has no missingness. There was no data cleaning required. For our data analysis, we merged the two parts of the collected data to create one dataset with 11 features.  Two transformations were made to the features - (1) Date was in character format and was transformed to as.Date() to convert to Day of the Week and (2) Time of Departure was in character format and was changed to Lubridate Time format.
Initial Exploratory Data Analysis


<img width="482" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/43dc59aa-83dc-4f34-a268-81ca5a20b680">
##### img-1

### In our project, we will be plotting the following features as part of our initial exploratory analysis:
Duration vs Price (economy and business)
Departure Time vs Price (economy and business)
Distribution of duration by airline 
Days to flight vs price (for different sectors and airlines)
Price distribution is based on the day of the week 
Distribution of departure time 

### Linear Regression Model
A variable's value can be predicted using linear regression analysis based on the value of another variable. The dependent variable is the one you want to be able to forecast. The independent variable is the one you're using to make a prediction about the value of the other variable. In our implementation of Linear Regression, our Target Variable (dependent variable) is the Price of the ticket. All 11 features will be used to predict the target variable.


<img width="316" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/31acbeb7-3fe1-49ac-b64f-c4a5ec259007">
##### img-2


<img width="332" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/8e942d3f-cc18-4cc4-af84-22cc2f815717">
##### img-3


<img width="341" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/8a6bf506-5680-4fcc-9047-baad639be829">
##### img-4


<img width="316" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/620f4c7d-8640-489f-8340-739e5434d8db">
##### img-5


<img width="322" alt="image" src="https://github.com/farhanah09/Flight-Price-Prediction-Data-Science-R/assets/127971208/50e78217-851a-4cfc-ab9d-5359f8209615">
##### img-6
