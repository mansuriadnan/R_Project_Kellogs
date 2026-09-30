
render_dashboard_header <- function()
  dashboardHeader(
    title = dashboardBrand(
      title = HTML("MSR"),
      href = "https://www.google.com",
      color = "secondary",
      image = "pringles_logo2.png"
    ),
    
    skin = "dark",
    status = "secondary",
    border = TRUE,
    sidebarIcon = shiny::icon("bars"),
    controlbarIcon = shiny::icon("th")
  )


render_dashboard_footer <- function() 
  dashboardFooter(
    left = a(
      href = "https://www.google.com",
      target = "_blank", "MSR"
    ),
    
    right = HTML("<div style='color:gainsboro'>This webapp is made with R/Shiny + bs4Dash/adminLTE3/Bootstrap4 framework</div>")
  )



style_sheets <- function() 
  tags$head(
    tags$link(rel = "stylesheet",type = "text/css",href = 'spec_india_css/msr_page1.css'),
    
    tags$link(rel = "stylesheet",type = "text/css",href = "https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"),
    
    tags$link(rel = "stylesheet",type = "text/css",href = "msr_base.css"),
    #tags$link(rel = "stylesheet",type = "text/css",href = "spec_india_css/spec_msr_page.css"),
    
    tags$link(rel = "stylesheet",href = "https://fonts.cdnfonts.com/css/gilroy-bold"),
    
    tags$link(rel = "stylesheet",href = "http://fonts.googleapis.com/css?family=Noto Sans Japanese"),
    
    tags$script(src = "includeHTML.js")
  )


tab_items <- function() 
  tabItems(
    # ----------------------------------------------------------------------- |
    tabItem(tabName = "tab_item_1",
      tabsetPanel(id = "tabset1",
                  
        msr_page1_ui()
      )
    ),
    # ---------------------------------------------------------------------- |
    tabItem(tabName = "tab_item_2",
      tabsetPanel(id = "tabset2",
        tabPanel(title = "Item 2A")
      )
    ),
    # ---------------------------------------------------------------------- |
    tabItem(tabName = "tab_item_3",
      tabsetPanel(id = "tabset3",
        tabPanel(title = "Item 3A")
      )
    ),
    # ----------------------------------------------------------------------- |
    tabItem(tabName = "tab_item_4",
      tabsetPanel(id = "tabset4",
        tabPanel(title = "Item 4A")
      )
    ),
    # -----------------------------------------------------------------------
    tabItem(tabName = "tab_item_5",
      tabsetPanel(id = "tabset5",
        tabPanel(title = "Item 5A"),
        tabPanel(title = "Item 5B")
      )
    )
  )




render_dashboard_sidebar <- function() {
  
  dashboardSidebar(skin = "dark", status = "secondary", elevation = 3,
   # -------------------------------------------------------------------
   sidebarMenu(
     sidebarHeader(""),
     menuItem(
       text = HTML("&nbsp; Item 1"),
       tabName = "tab_item_1",
       icon = shiny::icon("list")
     )
   ),
   
   br(),
   
   sidebarMenu(
     sidebarHeader(""),
     menuItem(
       text = HTML("&nbsp; Item 2"),
       tabName = "tab_item_2",
       icon = shiny::icon("dollar-sign")
     )
   ),
   
   br(),
   
   sidebarMenu(
     sidebarHeader(""),
     menuItem(
       text = HTML("&nbsp; Item 3"),
       tabName = "tab_item_3",
       icon = shiny::icon("shopping-basket")
     )
   ),
   
   br(),
   
   sidebarMenu(
     sidebarHeader(""),
     menuItem(
       text = HTML("&nbsp; Item 4"),
       tabName = "tab_item_4",
       icon = shiny::icon("link")
     )
   ),
   
   br(),
   
   sidebarMenu(
     sidebarHeader(""),
     menuItem(
       text = HTML("&nbsp; Item 5"),
       tabName = "tab_item_5",
       icon = shiny::icon("star-of-life")
     )
   )
  )
}
