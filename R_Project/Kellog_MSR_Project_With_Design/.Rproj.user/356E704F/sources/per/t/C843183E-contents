
library(glue)
library(purrr)

source("render_mtd_ytd_indices.R")

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
             {cmn_index_value_box(3000000,3200000, "IOP")}
             {cmn_index_value_box(3600000,3200000, "3&9")}'
           )
    })
  }
server <- function(input, output, session) {
  

  # Define the number of menu items to generate
  numItems <- 5
  
  # Create a list of menu items and corresponding icons
  menuItems <- map(1:numItems, function(i) {
    menuItem(
      text = paste("Item", i),
      tabName = paste("tab", i, sep = ""),
      icon = switch(i,
                    "1" = icon("bars"),
                    "2" = icon("dollar"),
                    "3" = icon("basket-shopping"),
                    "4" = icon("chain"),
                    "5" = icon("star-of-life"))
    )
  })
  
  # Render dynamic menu
  output$dynamicMenu <- renderMenu({
    bs4SidebarMenu(menuItems)
  })
  
  # Output for MTD sales
  output$composite_mtd_sales <- render_net_sales_value("mtd")
  
  # Output for YTD sales
  output$composite_ytd_sales <- render_net_sales_value("ytd")
  
}
