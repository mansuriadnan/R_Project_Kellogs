# Install and load required packages
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}
if (!requireNamespace("shinydashboard", quietly = TRUE)) {
  install.packages("shinydashboard")
}

library(shiny)
library(shinydashboard)
library(httpuv)
library(tidyverse)
library(jsonlite)
library(r2d3)
source("dashboardBody.R")
source("Header.R")
source("Footer.R")

# This is just the body component of a dashboard


ui <- dashboardPage(
  dashboardHeader,
  dashboardSidebar(disable = TRUE),
  dashboardBody
  
)


