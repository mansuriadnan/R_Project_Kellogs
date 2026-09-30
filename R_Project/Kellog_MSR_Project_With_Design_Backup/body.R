library(shiny)
library(bs4Dash)
library(glue)

# Define function to generate main title header
main_box_title <- function(title) {
  HTML(glue('<div class="main-title-only-text">
                 <h4>{title}</h4>
               </div>'))
}

# Function to generate the net sales value box
net_sales_value_box <- function(category) {
  tags$div(
    class = "net-sales-value-inner box",
    htmlOutput(glue("composite_{category}_sales"))
  )
}

body <- bs4DashBody(
  div(
    id = "tabset_div",
    tabsetPanel(
      id = "tabset",
      tabPanel("Item 1A", fluidRow(
    tags$div(
      class = "dashbourd-main",  # Main dashboard class
      tags$div(
        class = "top-section main-padding",  # Top section class with padding
        tags$div(
          class = "main-row",  # Main row class
          tags$div(
            class = "three-column",  # Three-column layout
            main_box_title("net sales value"),  # Generate main title header
            tags$div(
              class = "value-details",  
              net_sales_value_box("mtd"),  # Generate net sales value box for MTD
              net_sales_value_box("ytd")   # Generate net sales value box for YTD
            )
          )
        )
      )
    )), value = 'firstmenutab')
    )
  )
  # tabItems(
  #   tabItem(tabName = "tab2",
  #           h2("Welcome To Tab 2")
  #   ),
  #   tabItem(tabName = "tab3",
  #           h2("Welcome To Tab 3")
  #   )
  # )
)
