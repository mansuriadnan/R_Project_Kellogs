library(shiny)
library(reactable)

# Define UI
ui <- fluidPage(
  titlePanel("Table using reactable"),
  mainPanel(
    reactableOutput("mytable")
  )
)

server <- function(input, output) {
  # Sample data (replace with your actual data)
  data <- data.frame(
    Initiative = c("Initiative 1", "Initiative 2", "Initiative 3"),
    Activity = c("Activity 1", "Activity 2", "Activity 3"),
    Timing = c("Timing 1", "Timing 2", "Timing 3"),
    Status = c("Status 1", "Status 2", "Status 3"),
    Actions = c("Action 1", "Action 2", "Action 3")
  )
  
  # Render the table
  output$mytable <- renderReactable({
    reactable(
      data,
      columns = list(
        Initiative = colDef(name = "Initiative"),
        Activity = colDef(name = "Activity"),
        Timing = colDef(name = "Timing"),
        Status = colDef(name = "Status"),
        Actions = colDef(name = "Actions")
      )
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
