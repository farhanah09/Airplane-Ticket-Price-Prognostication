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

setwd("c:\\Users\\Aadit Javeri\\Desktop\\CMU Stuff\\Data Science for Technology - 19603\\DS_Project\\Data_Science_Project_R")

flightPricePredict <- function(Airline, Source, Destination, Flight_date, Days_left, Class, Total_stops, Arrival, Departure){
  flight_new = read_csv("Flights Price Prediction Dataset\\Cleaned_dataset.csv", show_col_types = FALSE)
  unique(flight_new$Total_stops)
  flight_new["Total_stops"][flight_new["Total_stops"]== "non-stop"] <- '0'
  flight_new["Total_stops"][flight_new["Total_stops"]== "1-stop"] <- '1'
  flight_new["Total_stops"][flight_new["Total_stops"]== "2+-stop"] <- '2'
  flight_new$Total_stops = as.numeric(flight_new$Total_stops)
  
  model <- readRDS("model_file.rds")
  Journey_day = strftime(Flight_date,"%A")
  flight_inpt = data.frame(Journey_day, Airline, Class, Source, Departure, Total_stops, Arrival, Destination, Days_left)
  inp = model.matrix( ~ ., data =rbind(flight_inpt, select(flight_new,-Fare, -Flight_code, -Date_of_journey, -Duration_in_hours)))
  prd = predict(model, inp[1, ])
  for (i in Days_left:1) {
    flight_inpt = data.frame(Journey_day, Airline, Class, Source, Departure, Total_stops, Arrival, Destination, Days_left=i)
    inp = model.matrix( ~ ., data =rbind(flight_inpt, select(flight_new,-Fare, -Flight_code, -Date_of_journey, -Duration_in_hours)))
    prd_n = predict(model, inp[1, ])
    prd = append(prd, prd_n)
  }
}



# Define UI ----
ui <- fluidPage(
  # use a gradient in background
  setBackgroundColor(
    color = c("#FBA581","#D69F9A","#96AEA9"),
    gradient = "linear",
    direction = "top"
  ),
  titlePanel(em(h1("Flight Price Predictinator", align = "center"))),
  mainPanel(
    img(src = "flight.png", height = 140, width = 400), align = "center"), 
  fluidRow(
    
    column(5,
           selectInput("depc", h3("Departure City"), 
                       choices = list("Hyderabad", "Bangalore",
                                      "Ahmedabad", "Chennai", 
                                      "Delhi", "Mumbai"), selected = 1)),
    column(5,
           selectInput("arrc", h3("Arrival City"), 
                       choices = list("Hyderabad", "Bangalore",
                                                "Ahmedabad", "Chennai", 
                                                "Delhi", "Mumbai"), selected = 1)),
    column(5,
           selectInput("stops", h3("Number of Stops"), 
                       choices = list("Zero" = 0, "One" = 1, "Two" = 2
                                      ), selected = 1)),
    column(5,
           selectInput("airline", h3("Airline"), 
                       choices = list("Air India", "Indigo",
                                      "SpiceJet", "Go FIRST", 
                                      "AirAsia", "Vistara", "AkasaAir", "StarAir", "AllianceAir"), selected = 1)),
    column(5,
           selectInput("class", h3("Class"), 
                       choices = list("Economy","Premium Economy", "Business","First"
                                      ), selected = 1)),
    column(5,
           selectInput("deptime", h3("Departure Time"), 
                       choices = list("After 6 PM","Before 6 PM", "6 AM - 12 PM","12 PM - 6 PM"
                       ), selected = 1)),
    column(5,
           selectInput("arrtime", h3("Arrival Time"), 
                       choices = list("After 6 PM","Before 6 PM", "6 AM - 12 PM","12 PM - 6 PM"
                       ), selected = 1)),
    column(5, 
             dateInput("date", 
                       (h3("Date input")), 
                       value = today())   
    ),
    
             column(10,
                     submitButton("Submit"), align = "center"),
    mainPanel(
      textOutput("arrc"),
      textOutput("depc"), 
      textOutput("date"),
      textOutput("stops"),
      textOutput("airline"),
      textOutput("class"),
      textOutput("deptime"),
      textOutput("arrtime")
    )
  )
)
  
# Define server logic ----
server <- function(input, output) {
  output$arrc <- renderText({paste("You have selected the arrival city of", input$arrc)})
  output$depc <- renderText({paste("with departue city as", input$depc)})
  output$date <- renderText({paste("with days left to travel of", as.POSIXlt(as.Date(input$date, origin = "13-01-2022")) - today())})
  output$stops <- renderText({paste("with stops:", input$stops)})
  output$airline <- renderText({paste("in", input$airline)})
  output$class <- renderText({paste("in class", input$class)})
  output$deptime <- renderText({paste("leaving at", input$deptime)})
  output$arrtime <- renderText({paste("arriving at", input$arrtime)})
  date_inp <- reactive({as.POSIXlt(as.Date(input$date, origin = "13-01-2023"))})
  aaj <- reactive({today()})
  days_left <- reactive({as.POSIXlt(as.Date(input$date, origin = "13-01-2023")) - today()})
  pred = flightPricePredict(input$depc, input$arrc, date_inp, days_left, input$class,  input$stops, input$deptime,input$arrtime)
  output$prediction <- renderText({paste("the price is cheapest at", pred)}) 
}

# Run the app ----
shinyApp(ui = ui, server = server)