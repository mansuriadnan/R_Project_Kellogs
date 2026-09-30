library(shiny)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  plotlyOutput("plot")
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    # Create a ggplot with a line and filled area
    p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_line(color = "#6E74AC") +
      geom_area(fill = "#DCE5FE", alpha = 0.5) +  # Fills the area under the line
      labs(x = NULL, y = NULL, title = "Area under the line") +  # Remove axis labels
      theme_minimal()
    
    # Convert ggplot to plotly
   p <- ggplotly(p, tooltip = c("x", "y"), dynamicTicks = TRUE)
    
    # Customize the tooltip appearance
   # p <- style(p, cursor = "pointer")
    
    # Hide x and y axes
    p <- layout(p, xaxis = list(showgrid = FALSE, showticklabels = FALSE),
                yaxis = list(showgrid = FALSE, showticklabels = FALSE))
    
    p
  })
}

shinyApp(ui, server)
