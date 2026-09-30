library(shiny)
library(reactable)
library(dplyr)
library(glue)

vartical_space <- function(.margin){
  HTML(
    glue("<div style='margin-top:{.margin}em'></div>")
  )
}

# Define UI
ui <- fluidPage(
  titlePanel("Table Example"),
  mainPanel(
    fluidPage(
      fluidRow(
        
    reactableOutput("mytable"),
      ),
    vartical_space(2.0),
    fluidRow(
      
      
    reactableOutput("rgmactiontracking")
    )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  composite_reactable <- function(.df) {
    first_four_header_color <- "lightblue"
    last_three_header_color <- "lightyellow"
    value_prefix <- "+"
    value_suffix <- "-"
    
    .df <- .df %>%
      mutate(
        #IOP_Target = paste0(IOP_Target), # Add "+" prefix to IOP_Target
        Vs_IOP_Target = paste0(substr(Vs_IOP_Target, 1, nchar(Vs_IOP_Target) + 1), " bps"), # Extract last two digits and add suffix to Vs_IOP_Target column
        Vs_IOP_Target_1 = paste0(substr(Vs_IOP_Target_1, 1, nchar(Vs_IOP_Target_1) - (-1)), " bps"), # Extract last two digits and add suffix to Vs_IOP_Target_1 column
        Vs_Latest_FF = ifelse(as.numeric(Vs_Latest_FF) > 100, paste(value_prefix, Vs_Latest_FF), paste(value_suffix, Vs_Latest_FF)) # Apply prefix based on value in Vs_Latest_FF
      )
    
    reactable(
      .df,
      bordered = TRUE,
      defaultPageSize = nrow(.df), # Show all rows
      defaultColDef = colDef(
        align = "center",
        minWidth = 70,
        headerStyle = list(background = "#f7f7f8")
        
      ),
      columns = list(
        Metric = colDef(name = "", headerStyle = list(background = first_four_header_color)), # Adjust color as needed
        IOP_Target = colDef(name = "IOP Target", 
                            headerStyle = list(background = first_four_header_color)),
        Latest_FF = colDef(name = "Latest FF", 
                           headerStyle = list(background = first_four_header_color)), 
        Vs_IOP_Target = colDef(name = "Vs IOP Target",
                               headerStyle = list(background = first_four_header_color)),
        
        YTD_Actuals = colDef(name = "YTD Actuals", headerStyle = list(background = last_three_header_color)),
        Vs_IOP_Target_1 = colDef(name = "Vs IOP Target",
                                 headerStyle = list(background = last_three_header_color),
                                 format = colFormat(prefix = value_prefix, digits = 2)),
        Vs_Latest_FF = colDef(name = "Vs Latest FF", headerStyle = list(background = last_three_header_color)) 
        
      ),
      
      rowStyle = function(index) {
      
          list(background = "lightpink")
    
      }
      
    )
  }
  
  
  # Render the table
  output$mytable <- renderReactable({
    data <- data.frame(
      Metric = c("NSV/kg", "FG&A"),
      IOP_Target = c("10.0", "24.0%"),
      Latest_FF = c("11.0", "24.0%"),
      Vs_IOP_Target = c("1.0%", "100"),
      YTD_Actuals = c("10.2", "25.0%"),
      Vs_IOP_Target_1 = c("0.2", "100"),
      Vs_Latest_FF = c("0.8", "200")
    )
    
    composite_reactable(data)
  })
  # Render the table
  output$rgmactiontracking <- renderReactable({
    data <- data.frame(
      Metric = c("NSV/kg", "FG&A"),
      IOP_Target = c("10.0", "24.0%"),
      Latest_FF = c("11.0", "24.0%"),
      Vs_IOP_Target = c("1.0%", "100"),
      YTD_Actuals = c("10.2", "25.0%"),
      Vs_IOP_Target_1 = c("0.2", "100"),
      Vs_Latest_FF = c("0.8", "200")
    )
    
    composite_reactable(data)
  })
  
  # Render the table
  output$rgmactiontracking <- renderReactable({
    data <- data.frame(
      firstcolumn = c("FY2023", "", "", "", "P6 YTD", "", "", "", "", "FY2024", ""),
      Initiative = c("", "Pricing", "New Pricing", "Carryover Pricing", "FGA", "", "Trade", "PPA", "PPA", "", ""),
      Activity = c("", "", "M-can pricing 5%", "S-can pricing 9%", "", "", "", "Trade optimization", "Can deflation from 409g to 400g", "", ""),
      Timing = c("", "", "p3", "p4", "", "", "", "p8", "Can deflation from 409g to 400g", "", ""),
      FY_NSV = c("10", "0.2", "", "", "10.5", "0.3", "", "", "", "11", ""),
      FY_GM = c("38.00%", "1.0%", "", "", "39.00%", "0.50%", "", "0.30%", "", "39.80%", ""),
      Status = c("", "", "On track", "On track", "", "", "WIP/Off track", "", "WIP/Off track", "", ""),
      Actions = c("", "", "", "", "", "", "", "", "", "", "")
    )
    
    reactable(
      data,
      bordered = TRUE,
      defaultPageSize = nrow(data), # Show all rows
      defaultColDef = colDef(
        headerStyle = list(background = "lightgreen")
      ),
      columns = list(
        firstcolumn = colDef(name = "firstcolumn"),
        Initiative = colDef(name = "Initiative"),
        Activity = colDef(name = "Activity"),
        Timing = colDef(name = "Timing"),
        FY_NSV = colDef(name = "FY NSV/kg"),
        FY_GM = colDef(name = "FY GM %"),
        
        Status = colDef(
          name = "Status",
          style =  JS(
            "function(rowInfo) {
            console.log(rowInfo.values['Status'])
                                if (rowInfo.values['Status'] === 'On track') {
                                  return { backgroundColor: 'lightgreen', color: 'black', fontWeight: 600}
                                }else   if (rowInfo.values['Status'] === 'WIP/Off track') {
                                
                                  return { backgroundColor: 'yellow', color: 'black', fontWeight: 600 }
                                }
                                
                              }"
          )
         
        ),
        Actions = colDef(name = "Actions")
      )
    )
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
