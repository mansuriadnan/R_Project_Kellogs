library(shiny)
library(plotly)

data <- 
  data.frame(
    cost = sample(40:400, 20),
    year = 1994:2013
  )

ui <- fluidPage(plotlyOutput("distPlot"))

server <- function(input, output) {
  output$distPlot <- renderPlotly({
    ggplot(data, aes(year, cost)) +
      geom_bar(stat = "identity")
  })
}

shinyApp(ui = ui, server = server)
