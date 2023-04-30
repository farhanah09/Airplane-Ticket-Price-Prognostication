library(shiny)
library(shinyWidgets)
library(lubridate)
library(tidyverse)
library(modelr)
library(lubridate)
library(dplyr)
library(glmnet)
library(caret)
library(pROC)
library(caTools)
library(randomForest)
addResourcePath("img", "img")


flightPricePredict <-
  function(Airline,
           Source,
           Destination,
           Journey_day,
           Days_left,
           Class,
           Total_stops,
           Arrival,
           Departure) {
    flight_new = read_csv("Flights Price Prediction Dataset/Cleaned_dataset.csv",
                          show_col_types = FALSE)
    flight_new["Total_stops"][flight_new["Total_stops"] == "non-stop"] <-
      '0'
    flight_new["Total_stops"][flight_new["Total_stops"] == "1-stop"] <-
      '1'
    flight_new["Total_stops"][flight_new["Total_stops"] == "2+-stop"] <-
      '2'
    flight_new$Total_stops = as.numeric(flight_new$Total_stops)
    
    cat(
      Airline,
      Source,
      Destination,
      Journey_day,
      Days_left,
      Class,
      Total_stops,
      Arrival,
      Departure
    )
    
    model <- readRDS("model_file_Random_Forest.rds")
    flight_inpt = data.frame(
      Journey_day,
      Airline,
      Class,
      Source,
      Departure,
      Total_stops,
      Arrival,
      Destination,
      Days_left
    )
    inp = model.matrix(~ ., data = rbind(
      flight_inpt,
      select(
        flight_new,
        -Fare,
        -Flight_code,
        -Date_of_journey,
        -Duration_in_hours
      )
    ))
    temp = predict(model, newdata = inp)
    prd = as.numeric(temp[1])
    
    for (i in Days_left:1) {
      flight_inpt = data.frame(
        Journey_day,
        Airline,
        Class,
        Source,
        Departure,
        Total_stops,
        Arrival,
        Destination,
        Days_left = i
      )
      inp = model.matrix(~ ., data = rbind(
        flight_inpt,
        select(
          flight_new,
          -Fare,
          -Flight_code,
          -Date_of_journey,
          -Duration_in_hours
        )
      ))
      temp_n = predict(model, newdata = inp)
      prd_n = as.numeric(temp_n[1])
      prd = append(prd, prd_n)
    }
    rtn = list(rev(prd[-1]))
    rtnmin = which.min(rev(prd[-1]))
    
    
    return(prd) #the list of prices
    return(rtmin) #the index at which the price is least
  }


# Define UI ----
ui <- fluidPage(
  # use a gradient in background
  setBackgroundColor(
    color = c("#FBA581", "#D69F9A", "#96AEA9"),
    gradient = "linear",
    direction = "top"
  ),
  titlePanel(em(
    h1("Flight Price Predictinator", align = "center")
  )),
  mainPanel(img(
    src = "img/flight.png",
    height = 140,
    width = 250
  )),
  fluidRow(
    column(5,
           selectInput(
             "depc",
             h3("Departure City"),
             choices = list(
               "Hyderabad",
               "Bangalore",
               "Kolkata",
               "Chennai",
               "Delhi",
               "Mumbai",
               "Ahmedabad"
             ),
             selected = 1
           )),
    column(5,
           selectInput(
             "arrc",
             h3("Arrival City"),
             choices = list(
               "Hyderabad",
               "Bangalore",
               "Kolkata",
               "Chennai",
               "Delhi",
               "Mumbai",
               "Ahmedabad"
             ),
             selected = 1
           )),
    column(5,
           selectInput(
             "stops",
             h3("Number of Stops"),
             choices = list(
               "Zero" = 0,
               "One" = 1,
               "Two" = 2
             ),
             selected = 0
           )),
    column(5,
           selectInput(
             "airline",
             h3("Airline"),
             choices = list(
               "Air India",
               "Indigo",
               "SpiceJet",
               "Go FIRST",
               "AirAsia",
               "Vistara",
               "AkasaAir",
               "StarAir",
               "AllianceAir"
             ),
             selected = 1
           )),
    column(5,
           selectInput(
             "seat_class",
             h3("Class"),
             choices = list("Economy", "Premium Economy", "Business", "First"),
             selected = 1
           )),
    column(5,
           selectInput(
             "deptime",
             h3("Departure Time"),
             choices = list("After 6 PM", "Before 6 AM", "6 AM - 12 PM", "12 PM - 6 PM"),
             selected = 1
           )),
    column(5,
           selectInput(
             "arrtime",
             h3("Arrival Time"),
             choices = list("After 6 PM", "Before 6 AM", "6 AM - 12 PM", "12 PM - 6 PM"),
             selected = 1
           )),
    column(5,
           dateInput(
             "date",
             h3("Select Date"),
             min = as.Date(today()),
             max = NULL,
           )),
    
    column(10,
           actionButton("submit", "Submit"), align = "center"),
    mainPanel(
      #   textOutput("arrc"),
      #   textOutput("depc"),
      textOutput("days_left"),
      #   textOutput("stops"),
      #   textOutput("airline"),
      #   textOutput("class"),
      #   textOutput("deptime"),
      #   textOutput("arrtime")
      textOutput("prediction"),
      plotOutput("price_plot")
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  observeEvent(input$submit, {
    date_inp <- reactive((input$date))
    aaj <- as.Date(today())
    days_left <- as.numeric(difftime(((date_inp(
    ))), aaj))
    Journey_day = strftime(input$date, "%A")
    cat(
      input$airline,
      input$depc,
      input$arrc,
      input$date,
      days_left,
      input$seat_class,
      input$stops,
      input$arrtime,
      input$deptime
    )
    #cat(Journey_day, "---------")
    #cat(aaj)
    #pred = flightPricePredict(input$airline, input$depc,input$arrc, Journey_day, days_left, input$seat_class, input$stops, input$arrtime, input$deptime)
    pred = flightPricePredict(
      input$airline,
      input$depc,
      input$arrc,
      Journey_day,
      days_left,
      input$seat_class,
      as.numeric(input$stops),
      input$arrtime,
      input$deptime
    )
    #pred = flightPricePredict("SpiceJet",  "Kolkata", "Hyderabad",   "Monday",       15,       "Economy",         0,       "Before 6 AM", "6 AM - 12 PM")
    #pred = "Swim and go bro"  #test output line
    output$prediction <-
      renderText({
        paste("the price is cheapest at", pred)
      })
    output$price_plot <- renderPlot({
      hist(pred, xlab = "price", ylab = "number of days")
    })
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
