library(shiny)
library(bs4Dash)

sidebar <- bs4DashSidebar(
  bs4SidebarMenu(
    id = "sidebarMenu",
    sidebarMenuOutput("dynamicMenu")  # Render dynamic menu
   
  ),
  status = "secondary",
)
