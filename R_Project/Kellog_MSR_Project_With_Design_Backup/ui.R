library(shiny)
library(bs4Dash)

source("header.R")
source("sidebar.R")
source("body.R")

ui <- bs4DashPage(
  header,
  sidebar,
  body,
  dark = NULL,
  help = NULL
)
