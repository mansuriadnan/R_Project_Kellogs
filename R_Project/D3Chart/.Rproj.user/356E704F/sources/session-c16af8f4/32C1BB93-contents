#Import libraries
library(shiny)
library(tidyverse)
library(jsonlite)

ui <- fluidPage(
  
  #Bring in the style sheet from the www folder
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
  
  #Tell shiny what version of d3 we want
  #tags$script(src='//d3js.org/d3.v3.min.js'),
  tags$script(src='https://d3js.org/d3.v7.min.js'),
  
  # App Title
  titlePanel("Average MPG By Vehicle Class and Manufacturer "),
  
  actionButton("goevent", "Go"),
  
  #Dropdown list with the vehicle classes  
  selectInput(inputId = "vehicleClass",
              label = 'Select a Vehicle Class',
              choices = c('','compact', 'midsize', 'suv', '2seater', 'minivan', 'pickup', 'subcompact'),
              selected = ''
  ),
  
  #The d3 graph
  uiOutput("chartcontainer")
)

server <- function(input, output, session) {
  
  #Lets look for changes in our vehicle class dropdown then crunch the data and serve it to D3
  observeEvent(input$goevent, {
    
    #Use tidyverse to slice the data based on the drop down input
    dfMpg <- mpg %>% 
      filter(class == input$vehicleClass) %>% 
      group_by(manufacturer) %>% 
      mutate(avgCity = mean(cty)) %>% 
      select(manufacturer, avgCity) %>% 
      unique() %>% 
      rename(name = manufacturer, value = avgCity)
    
    #Convert the tibble to json
    jsonMpg <- toJSON(dfMpg, pretty=TRUE)
    
    
    data <- data.frame(
      date = c(
        "2020-04-01", "2020-06-01", "2020-08-01", "2020-10-01", "2020-12-01", "2021-02-01", "2021-04-01",
        "2020-04-01", "2020-06-01", "2020-08-01", "2020-10-01", "2020-12-01", "2021-02-01", "2021-04-01"
      ),
      population = c(62, 59.8, 62.8, 73.1, 79.8, 84.2, 96, 16.8, 15, 18.2, 25, 28, 30, 27),
      line = c(
        "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE",
        "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE"
      )
    )
    json_data <- toJSON(data, pretty = TRUE)
    
    print(json_data)
    session$sendCustomMessage(type="jsondata",json_data)
  }, ignoreNULL = FALSE,ignoreInit = FALSE)
  
  
  #This tells shiny to run our javascript file "script.js" and send it to the UI for rendering
  output$chartcontainer <- renderUI({
    HTML('<script type="text/javascript", src="jsoncharttwo.js">  </script>')
  })
}
shinyApp(ui = ui, server = server)