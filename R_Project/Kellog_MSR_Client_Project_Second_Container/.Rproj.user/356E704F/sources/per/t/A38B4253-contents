library(shiny) 
library(bs4Dash) 
library(fontawesome) 
library(shinyWidgets)
library(tidyverse) 
library(lubridate) 
library(patchwork) 
library(glue) 
library(janitor)
library(htmltools)
library(reactable)
library(fresh) 
library(here) 
library(plotly)

theme_set(theme_minimal())

loadSupport()


ui <- dashboardPage(title = "MSR", fullscreen = TRUE, dark = NULL,
  # ------------------------------------------------------------------------------ |
  header     = render_dashboard_header(),
  sidebar    = render_dashboard_sidebar(),
  controlbar = dashboardControlbar(width = 750, skin = "dark"),
  footer     = render_dashboard_footer(),
  # ------------------------------------------------------------------------------ |
  body = dashboardBody(
    
    style_sheets(),
    
    tab_items()
  )
)


server <- function(input, output, session) {
  
  msr_page1_server(
    input, output, session, 
    .data1 = dummy_net_sales_data,
    .data2 = dummy_op_profibility_data,
    .data3 = dummy_controllable_gm_profitability_data
  )
}


shinyApp(
  ui = ui, 
  server = server
)