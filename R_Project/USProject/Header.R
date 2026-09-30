library(shiny)
library(shinydashboard)

# Get the current year
current_year <- as.integer(format(Sys.Date(), "%Y"))

# Calculate the last five years (including the current year)
last_five_years <- current_year - 0:4

# Convert the years to a string
years_text <- paste(last_five_years, collapse = " ")

dropdownMenu()


dashboardHeader <-  dashboardHeader(
  title = tags$img(src='images/logo.png'),
 
  uiOutput('list'))

