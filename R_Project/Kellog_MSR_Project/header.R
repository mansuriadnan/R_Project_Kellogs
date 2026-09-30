library(shiny)
library(bs4Dash)

header <- bs4DashNavbar(
  title =  dashboardBrand(
    title = "MSR",
    color = "secondary",
    image = "images/header_logo.png"
  ),
  status = "secondary" 
)
