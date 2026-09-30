# Load necessary libraries
#library(shiny)

# Source the file containing the custom UI function
source("comm_single_view_ui_client.R")
source("comm_single_view_server_client.R")

# Define the server logic
server <-function(input, output, session, .data1, .data2, .data3, .data4){
  comm_single_view_server(input, output, session, .data1, .data2, .data3, .data4)
}

# Define UI
ui <- fluidPage(
  comm_single_view_ui()  # Call the custom UI function
)

# Run the application
shinyApp(ui = ui, server = server)
