library(shiny)
library(glue)

# Source the UI component
source("comm_single_view_ui.R")
source("comm_single_view_server.R")

# UI Definition
ui <- fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/style_dhaval.css")),
  comm_single_view_ui()
)

# Server Logic
server <- function(input, output) {
  
  comm_single_view_server(input, output);

}

# Run the application 
shinyApp(ui = ui, server = server)
