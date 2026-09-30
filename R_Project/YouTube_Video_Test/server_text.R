library(shiny)

ui <- fluidPage(
  numericInput("a","Enter a value",value = 10),
  numericInput("b","enter b value",value = 20),
  numericInput("d","enter d value",value = 30),
  textOutput("f")
  
)

server <- function(input, output, session) {
  
  c <- reactive(input$a + input$b)
  e <- reactive(c() + input$d)
  output$f <- renderText(e())
  
}

shinyApp(ui, server)