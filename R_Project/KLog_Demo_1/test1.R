library(shiny)

ui <- fluidPage(
  sliderInput("x",label = " X is",min = 1,max = 50,value = 30),
  sliderInput("y",label = "Y is",min = 1,max = 50,value = 20),
  "x * y is ",
  textOutput("product"),
  "(x * y) + 5 is ",
  textOutput("product_plus5"),
  "(x * y) + 10 is ",
  textOutput("product_plus10"),
)

server <- function(input, output, session) {
  
  common_output <-  reactive({
    input$x * input$y
  })
  
  output$product <- renderText({
    common_output()
  })
  output$product_plus5 <- renderText({
    common_output() + 5
  })
  output$product_plus10 <- renderText({
    common_output() + 10
  })
  
}

shinyApp(ui, server)