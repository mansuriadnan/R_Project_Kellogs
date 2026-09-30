library(shiny)
library(bs4Dash)

sidebar <- bs4DashSidebar(
  bs4SidebarMenu(
    id = "sidebarMenu",
    sidebarMenuOutput("dynamicMenu")  # Render dynamic menu
    # menuItem(
    #   text = "Item 1",
    #   tabName = "tab1",
    #   icon = icon("bars")
    # ),
    # menuItem(
    #   text = "Item 2",
    #   tabName = "tab2",
    #   icon = icon("dollar")
    # ),
    # menuItem(
    #   text = "Item 3",
    #   tabName = "tab3",
    #   icon = icon("basket-shopping")
    # ),
    # menuItem(
    #   text = "Item 4",
    #   tabName = "tab4",
    #   icon = icon("chain")
    # ),
    # menuItem(
    #   text = "Item 5",
    #   tabName = "tab5",
    #   icon = icon("star-of-life")
    # )
  ),
  status = "secondary",
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/style_msr.css")),
  # tags$head(
  #   tags$style(
  #     HTML("
  #       .sidebar-menu .nav-link {
  #         color: white !important; /* Change color to White */
  #       }
  #       .nav-sidebar>.nav-item { margin-bottom: 30px; }
  #       .sidebar {
  #         background-color: #343A40; /* Change sidebar background color */
  #       }
  #     ")
  #   )
  # )
)
