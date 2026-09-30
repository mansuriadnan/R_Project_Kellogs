library(shiny)

ui <- fluidPage(
  titlePanel("Simple Shiny App"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", choices = c("iris", "mtcars")),
    ),
    mainPanel(
      tableOutput("table")
    )
  )
)

server <- function(input, output) {
  output$table <- renderTable({
    switch(input$dataset,
           "iris" = iris,
           "mtcars" = mtcars)
  })
}

shinyApp(ui, server)
