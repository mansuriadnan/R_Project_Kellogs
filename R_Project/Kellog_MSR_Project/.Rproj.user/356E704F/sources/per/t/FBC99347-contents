library(shiny)
library(bs4Dash)

body <- bs4DashBody(
  div(
    id = "tabset_div",
    tabsetPanel(
      id = "tabset",
      tabPanel("Item 1A", "Hello", value = 'medianTab')
    )
  ),
  tabItems(
    tabItem(tabName = "tab2",
            h2("Welcome To Tab 2")
    ),
    tabItem(tabName = "tab3",
            h2("Welcome To Tab 3")
    )
  )
)
