library(shiny)

ui <- fluidPage(
  
  textInput("name","what is your name"),
  textOutput("outputname")
  
)

server <- function(input,output,session){
  
  string <- reactive( paste0("Hello ",input$name," "))
  
  
  output$outputname <- renderText(string())

  
}

shinyApp(ui,server)
