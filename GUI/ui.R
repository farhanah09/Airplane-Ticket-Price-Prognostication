library(shiny)
library(shinyWidgets)

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
             dateInput("date", 
                       (h3("Date input")), 
                       value = "2023-01-01")   
    ),
              column(10,
                     submitButton("Submit"), align = "center"),
    mainPanel(
      textOutput("arrc"),
      textOutput("depc"), 
      textOutput("date"),
      textOutput("stops"),
      textOutput("airline"),
      textOutput("class")
    
    ),
  )
)
  
# Define server logic ----
server <- function(input, output) {
  output$arrc <- renderText({paste("You have selected the arrival city of", input$arrc)})
  output$depc <- renderText({paste("with departue city as", input$depc)})
  output$date <- renderText({paste("on the date of", input$date)})
  output$stops <- renderText({paste("with stops:", input$stops)})
  output$airline <- renderText({paste("in", input$airline)})
  output$class <- renderText({paste("in class", input$class)})
}

# Run the app ----
shinyApp(ui = ui, server = server)