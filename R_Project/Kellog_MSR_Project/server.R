library(shiny)

server <- function(input, output, session) {
  
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
  
  
  observeEvent(input$sidebarMenu, {
    selected_tab <- input$sidebarMenu
    if (selected_tab == "tab1") {
      showTab(inputId = "tabset", target = 'medianTab')
    } else { 
      hideTab(inputId = "tabset", target = 'medianTab')
    }
  })
}
