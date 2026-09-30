library(shiny)
library(reactable)

ui <- fluidPage(
  fluidRow(
    textInput("name", "What's your name?")
  ),
  reactableOutput("reactable_table")
)

server <- function(input, output) {
  output$reactable_table <- renderReactable({
    reactable(
      iris,
      defaultPageSize = 10,
      searchable = TRUE,
      sortable = TRUE,
      columns = list(
        Sepal.Length = colDef(
          name = "Sepal Length",
          header = function() {
            span("Custom Sepal Length Header")
          }
        ),
        Sepal.Width = colDef(
          name = "Sepal Width",
          header = function() {
            span("Custom Sepal Width Header")
          }
        ),
        Petal.Length = colDef(
          name = "Petal Length",
          header = function() {
            span("Custom Petal Length Header")
          }
        ),
        Petal.Width = colDef(
          name = "Petal Width",
          header = function() {
            span("Custom Petal Width Header")
          }
        )
      )
    )
  })
}

shinyApp(ui, server)
