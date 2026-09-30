library(shiny)
library(bs4Dash)

header <- bs4DashNavbar(
  title =  dashboardBrand(
    title = "MSR",
    color = "secondary",
    image = "images/header_logo.png"
  ),
  status = "secondary",
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/style_msr.css")),
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/style_dhaval.css"))
)
