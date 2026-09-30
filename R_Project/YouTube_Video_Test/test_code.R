library(shiny)
library(bs4Dash)

# Define UI
ui <- dashboardPage(
  header = dashboardHeader(title = "Shiny Dashboard with bs4Dash"),
  sidebar = dashboardSidebar(),
  body = dashboardBody(
    bs4Dash::bs4DashBody(
      box(
        title = "Example Box",
        status = "primary",
        solidHeader = TRUE,
        width = 6,
        height = "200px",
        collapsible = TRUE,
        collapsed = FALSE,
        closable = TRUE,
        maximizable = TRUE,
        footer = "Footer Text",
        background = "primary",
        label = "My Custom Label",
        uiOutput("box_content")  # Output text will be rendered inside the box
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$box_content <- renderUI({
    HTML("This is some example text inside the box.")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
