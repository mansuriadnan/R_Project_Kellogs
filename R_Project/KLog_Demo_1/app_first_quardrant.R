# Load necessary libraries
library(shiny)

# Source the file containing the custom UI function
source("first_quadrant.R")
source("first_quadrant_server.R")

# Define the server logic
server <-function(input, output, session){
  first_quadrant_view_server(input, output, session)
}

# Define UI
ui <- fluidPage(
  first_quadrant_view_ui()  # Call the custom UI function
)

# Run the application
shinyApp(ui = ui, server = server )
