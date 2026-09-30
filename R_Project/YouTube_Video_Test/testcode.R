library(shiny)
library(ggplot2)


dataset <- c("economics","faithfuld","seals")

ui <- fluidPage(
  fluidRow(
    textInput("txtinside", "",placeholder  = "Your Name")
  ),
  fluidRow(
    sliderInput("dateslider",label = "Dates Slider", min = as.Date(Sys.Date(),"%Y-%m-%d"),
                max = as.Date("2025-12-01","%Y-%m-%d"),
                value=as.Date(Sys.Date()))
  ),
  selectInput("dataset",
              "Dataset",choices = dataset),
  verbatimTextOutput("summary"),
  plotOutput("plot"),
  fluidRow(
    
  actionButton("firstbutton","Submit Me!",class = "btn-primary"),
  ),
  fluidRow(
  actionButton("drink","No Drink!",icon = icon("cocktail")))
  
)

server <- function(input, output, session) {
  
  dataset <- reactive({
    get(input$dataset,"package:ggplot2")
  })
  
  output$summary <- renderPrint({
    summary(dataset())
  })
  
  
  output$plot <- renderPlot({
    plot(dataset())
  },res = 96)
  
}

shinyApp(ui, server)