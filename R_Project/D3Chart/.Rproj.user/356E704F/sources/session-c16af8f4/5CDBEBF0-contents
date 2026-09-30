library(shiny)
library(tidyverse)
library(jsonlite)


ui <- fluidPage(
  
  #Bring in the style sheet from the www folder
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
  
  #Tell shiny what version of d3 we want
  tags$script(src='//d3js.org/d3.v3.min.js'),
  
  # App Title
  titlePanel("Average MPG By Vehicle Class and Manufacturer "),
  
  #Dropdown list with the vehicle classes  
  selectInput(inputId = "vehicleClass",
              label = 'Select a Vehicle Class',
              choices = c('','compact', 'midsize', 'suv', '2seater', 'minivan', 'pickup', 'subcompact'),
              selected = ''
  ),
  
  #The d3 graph
  uiOutput("d3")
)
