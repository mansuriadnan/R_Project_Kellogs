library(shiny)
library(ggplot2)
library(dplyr)

# Define UI
ui <- fluidPage(
  titlePanel("Population Trend"),
  sidebarLayout(
    sidebarPanel(
      ... = FALSE
    ),
    mainPanel(
      plotOutput("population_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  set.seed(123)  # for reproducibility
  sample_data <- data.frame(
    date = seq(as.Date("2020-01-01"), by = "month", length.out = 10),
    dimension = rep(c("dollar", "euro"), each = 5),
    brand = rep(c("PRINGLES", "LAY'S"), times = 5),
    l12m = runif(1000, min = 1000000, max = 5000000),  # Random values for l12m
    l13m = runif(1000, min = 1000000, max = 5000000)   # Random values for l13m
  )
  
  # Print original sample data
  print("Original Sample Data:")
  print(sample_data)
  
  
  # Data
  data <- data.frame(
    date = as.Date(c(
      "2020-04-01", "2020-06-01", "2020-08-01", "2020-10-01", "2020-12-01", "2021-02-01", "2021-04-01",
      "2020-04-01", "2020-06-01", "2020-08-01", "2020-10-01", "2020-12-01", "2021-02-01", "2021-04-01"
    )),
    population = c(62, 59.8, 62.8, 73.1, 79.8, 84.2, 96, 16.8, 15, 18.2, 25, 28, 30, 27),
    line = c("MAT", "MAT", "MAT", "MAT", "MAT", "MAT", "MAT", "P3M", "P3M", "P3M", "P3M", "P3M", "P3M", "P3M")
  )

  # Create ggplot
  output$population_plot <- renderPlot({
    
    
    
    
    ggplot(data, aes(x = date, y = population, color = line)) +
      geom_line() +
      geom_point() +
      theme_minimal() +
      scale_color_manual(values = c("#fd9332", "#7091f5")) + # Adjust colors as needed
      labs(x = "Date", y = "Population", color = "Line") +
      theme(legend.position = "")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
