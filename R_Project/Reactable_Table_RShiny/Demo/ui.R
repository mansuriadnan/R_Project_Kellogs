# Run in an interactive R session
if (interactive()) {
  
  library(shiny)
  library(reactable)
  
  ui <- fluidPage(
    titlePanel("reactable example"),
    reactableOutput("table")
  )
  
  server <- function(input, output, session) {
    output$table <- renderReactable({
      reactable(iris)
    })
  }
  
  shinyApp(ui, server)
}