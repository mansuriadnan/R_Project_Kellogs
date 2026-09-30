library(shiny)
library(glue)
source("render_mtd_ytd_indices.R")

server <- function(input, output, session) {
  
  render_net_sales_value <- function(.category) {
  
    .value_label <- ifelse(.category == "mtd", "MTD", "YTD")
    
    .mtd_ytd_value <- ifelse(.category == "mtd", 8.2, 10.2) 
    
    .growth <- ifelse(.category == "mtd", 50 , 80) 
    
    .delta_glyph <- ifelse(.growth > 50, "up", "down")
    
    renderText({
      glue('<div class="index-vs-ya">
               <div class="index-value">
                 <h2>{.mtd_ytd_value}%</h2>
                 <span><img src="images/arrow-{.delta_glyph}.png"></span>
               </div>
               <p>{.value_label} Index vs YA</p>
             </div>
             {common_index_value_box(3000000,3200000, "IOP")}
             {common_index_value_box(3600000,3200000, "3&9")}
             
             ')
    })
  }
  # Output for MTD sales
  output$composite_mtd_sales <- render_net_sales_value("mtd")
  
  # Output for YTD sales
  output$composite_ytd_sales <- render_net_sales_value("ytd")
  
  
  numItems <- 5  # Number of menu items to generate
  
  # Create a tibble with menu items and corresponding icons
  menuItems <- data.frame(
    text = paste("Item", 1:numItems),
    tabName = paste("tab", 1:numItems, sep = ""),
    icon = c("bars", "dollar", "basket-shopping", "chain", "star-of-life")
  )
  
  # Define a function to create menu items
  createMenuItem <- function(item) {
    menuItem(
      text = item$text,
      tabName = item$tabName,
      icon = icon(item$icon)
    )
  }
  
  # Render dynamic menu
  output$dynamicMenu <- renderMenu({
    bs4SidebarMenu(
      lapply(seq_len(nrow(menuItems)), function(i) createMenuItem(menuItems[i, ]))
    )
  })
  
  
  # observeEvent(input$sidebarMenu, {
  #   selected_tab <- input$sidebarMenu
  #   if (selected_tab == "tab1") {
  #     showTab(inputId = "tabset", target = 'firstmenutab')
  #   } else { 
  #     hideTab(inputId = "tabset", target = 'firstmenutab')
  #   }
  # })
}
