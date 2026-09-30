# Load required libraries
library(shiny)
library(reactable)

# Your data
offtake <- c("$96M", "$96M", "$96M", "$96M")
from_ya <- c("$37M", "$37M", "$37M", "$37M")
row_names <- c("MAT", "P6M", "P3M", "YTD")

# Combine data into a data frame
data <- data.frame(Offtake = offtake, from_ya = from_ya, row.names = row_names, stringsAsFactors = FALSE)

# Define UI
ui <- fluidPage(
  titlePanel("reactable examples"),
  
  # Basic usage
  reactableOutput("basic"),
  
  # Grouping and aggregation
  reactableOutput("grouping"),
  
  # Row details
  reactableOutput("details"),
  
  # Conditional styling
  reactableOutput("conditional")
)

# Define server logic
server <- function(input, output, session) {
  
  # Basic usage
  output$basic <- renderReactable({
    reactable(data)
  })
  
  # Grouping and aggregation
  output$grouping <- renderReactable({
    reactable(
      data,
      groupBy = "Offtake",
      columns = list(
        Offtake = colDef(aggregate = "count"),
        `From YA` = colDef(aggregate = "mean")
      )
    )
  })
  
  # Row details
  output$details <- renderReactable({
    reactable(data, details = function(index) {
      htmltools::div(
        "Details for row: ", index,
        htmltools::tags$pre(paste(capture.output(data[index, ]), collapse = "\n"))
      )
    })
  })
  
  # Conditional styling
  output$conditional <- renderReactable({
    reactable(data, columns = list(
      Offtake = colDef(style = function(value) {
        if (value == "$96M") {
          color <- "green"
        } else {
          color <- "red"
        }
        list(color = color, fontWeight = "bold")
      }),
      from_ya = colDef(style = function(value) {
        if (value != "$96M") {
          color <- "blue"
        } else {
          color <- "red"
        }
        list(color = color, fontWeight = "bold")
      })
      
    ))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
