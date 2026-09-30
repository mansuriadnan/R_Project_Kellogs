library(shiny)
library(shinydashboard)

includeCSS("www/css/style.css")
title <- tags$a(href='https://www.google.com',
                tags$img(src='images/logo.png'))


dashboardHeader <- dashboardHeader(title = title)

