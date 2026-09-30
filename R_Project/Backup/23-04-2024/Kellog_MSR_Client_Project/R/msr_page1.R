 library(lubridate) 

msr_page1_date_options <- as_date("2024-01-01") + months(0:11) 
msr_page1_date_options <- format(msr_page1_date_options, '%Y-%m')

ya_value_box <- function(.data, .category) {
  
  # .data <- dummy_net_sales_data 
  # .category <- "mtd"
  
  .value_label <- ifelse(.category == "mtd", "MTD", "YTD")
  
  .data <- .data %>% filter(ref == "ya", category == .category)
  .value <- .data %>% pull(value)
  .ref_value <- .data %>% pull(ref_value)
  
  .mtd_ytd_value <- .value / .ref_value - 1
  
  .delta_glyph <- ifelse(.mtd_ytd_value > 0, "up", "down")
  
  glue("
    <div style='font-size:1.6vw'>
      <div style='display:flex;align-items:flex-start;'>
        <div style='line-height:1'>
          <span style='font-weight:900;color:var(--msr-value-color)'>{round(.mtd_ytd_value * 100)}%</span>
          <i class='fa-solid fa-arrow-{.delta_glyph}' style='font-size:70%;color:var(--msr-{.delta_glyph}-color);margin-left:0.2em'></i>
        </div>
            
        <div style='text-align:left;margin-left:0.5em;font-size:50%;'>
          <span style='color:gray;font-weight:300;'>vs <strong>YA</strong></span>
        </div>
      </div>
                
      <p style='font-size:50%;'>{.value_label}</p>
    </div>
  ")
}

op_profitability_value_box <- function(.data, .category) {
  
  .value_label <- ifelse(.category == "mtd", "MTD", "YTD")
  
  .data <- .data %>% filter(ref == "ya", category == .category)
  .value <- .data %>% pull(value)
  .ref_value <- .data %>% pull(ref_value)
  
  .mtd_ytd_value <- .value / .ref_value - 1
  
  .color <- ifelse(.mtd_ytd_value > 0, 'green', 'orange')
  
  .delta_glyph <- ifelse(.mtd_ytd_value > 0, "up", "down")
  
  .value_percentage <- paste0(round(.mtd_ytd_value * 100), "%")
  
  #   bps <- .data %>%
  #   mutate(bps = (value - ref_value) / ref_value * 10000) %>%
  #   pull(bps)
  # .mtd_ytd_bps <- bps
  
#  print(.mtd_ytd_bps)
  
  glue("<div class='index-value'>
         
         <div style='line-height:1;display: flex;flex-direction: row; align-items: center;'>
         <span style='font-weight:900;color:var(--msr-value-color)'>{.value_percentage}</span>
         <i class='fa-solid fa-arrow-{.delta_glyph}' style='font-size:70%;color:var(--msr-{.delta_glyph}-color);margin-left:0.2em'></i>
         </div>
         <div style='text-align:left;margin-left:0.5em;font-size:50%;'>
              <div class='net-value-sale'>
									<strong class='{.color}-color-text'>{round(.mtd_ytd_value * 100)}%</strong> 
									<span>net sales value</span>
				      </div>
         </div>
        </div>
				<p>{.value_label}</p>
										
				")
}

iop_le_value_box <- function(.data, .category, .iop_le) {
  
  #.data <- dummy_net_sales_data
  #.iop_le <- "iop"
  
  .data <- .data %>% filter(ref == .iop_le, category == .category)
  .value <- .data %>% pull(value)
  .ref_value <- .data %>% pull(ref_value)
  
  # Calculate the difference ratio between value and reference
  .delta <- .value / .ref_value - 1
  
  # Determine the sign of deviation and color based on the delta value
  .sign_dev <- ifelse(.delta > 0, '+', '-')
  .color <- ifelse(.delta > 0, 'green', 'orange')
  
  # Convert value to million and calculate delta percentage
  value_million <- (.value - .ref_value) / 1e6
  delta_percent <- abs(round(.delta * 100, 1))
  
  .iop_le <- ifelse(.iop_le == "iop", "IOP", "9+3")
  
  glue("
    <div class='common-inner-value-box' style='font-size:0.75vw'>
      <div class='value-vs'>
        <span>vs <strong>{.iop_le}</strong></span>
      </div>
      <div class='value-vs-result'>
        <span class='{.color}-color-text'>+${value_million}M</span>
        <span class='{.color}-box'>{.sign_dev}{delta_percent}%</span>
      </div>
    </div>
  ")
}

iop_ya_value_box <- function(.data, .category, .iop_le) {

  # Filter the data based on the reference and category
  .data <- .data %>% filter(ref == .iop_le, category == .category)
  
  # Extract the 'value' and 'ref_value' columns
  .value <- .data %>% pull(value)
  .ref_value <- .data %>% pull(ref_value)
  
  # Calculate the difference ratio between value and reference
  .delta <- .value / .ref_value - 1
  
  # Determine the sign of deviation and color based on the delta value
  .sign_dev <- ifelse(.delta > 0, '+', '-')
  .color <- ifelse(.delta > 0, 'green', 'orange')
  
  # Convert value to million and calculate delta percentage
  value_million <- (.value - .ref_value) / 1e6
  delta_percent <- abs(round(.delta * 100, 1))
  
  # Determine the reference label based on 'iop_le'
  .iop_le <- ifelse(.iop_le == "iop", "IOP", "YA")
  
  # Generate HTML content for the value box
  glue("
    <div class='common-inner-value-box' style='font-size:0.75vw'>
      <div class='value-vs'>
        <span>vs <strong>{.iop_le}</strong></span>
      </div>
      <div class='value-vs-result'>
        <span class='{.color}-color-text'>+${value_million}M</span>
        <span class='{.color}-box'>{.sign_dev}{delta_percent}%</span>
      </div>
    </div>
  ")
}


# Function to generate the net sales value box
net_sales_value_box <- function(category) {
  tags$div(
    class = "net-sales-value-inner net-sales-value-box",
    htmlOutput(glue("composite_{category}_sales"))
  )
}

# Function to generate the op profitability value box
render_op_profitability_value_box <- function(.mtd_ytd) {
  column(
         width = 6,
         tags$div(
         class = "index-vs-ya",
         htmlOutput(glue("composite_op_profitability_{.mtd_ytd}_value_box")),
         plotOutput(glue("composite_{.mtd_ytd}_plot"), height = "50px"),hover = hoverOpts("plot_hover")),
         uiOutput("hoverinfo"),
       #  plotlyOutput(glue("composite_{.mtd_ytd}_plot"), height = "50px")),
         htmlOutput(glue("composite_{.mtd_ytd}_ya_iop_value_box"))
         )
}


 msr_page1_ui <- function() 
  tabPanel(
    title = "Item 1A",
    
    vertical_space(0.5),
    
    fluidRow(
      column(width = 9),
      column(width = 3, align = 'right',
             selectInput(
               inputId = "msr_page1_date_option",
               label = "Period",
               choices = msr_page1_date_options,
               selected = msr_page1_date_options[1]  # Select the first date
             )
      )
    ),
    
    fluidRow(
      box(width = 4,
          title = htmlOutput("net_sales_value_label"),
          
          tags$div(
            style = "display:flex;",  
            net_sales_value_box("mtd"),  # Generate net sales value box for MTD
            net_sales_value_box("ytd")   # Generate net sales value box for YTD
          )
      ),
      
      box(width = 4,
          title = htmlOutput("controllable_gm_profitability_label")
      ),
      
      box(width = 4,
          title = htmlOutput("op_profitability_label"),
          
          tags$div(
            class = "value-details sales-value-with-graph row",
            render_op_profitability_value_box("mtd"),  # Generate op profitability value box for MTD
            render_op_profitability_value_box("ytd")   # Generate op profitability value box for YTD
          )
          
      )
    ),
    
    fluidRow(
      box(width = 4,
          title = htmlOutput("net_sales_value_per_kilo_label")
      ),
      
      box(width = 4,
          title = htmlOutput("market_share_label")
      ),
      
      box(width = 4,
          title = htmlOutput("bias_label")
      )
    )
  )
 
 # Define a function to plot the op profitability chart
 plot_op_profitability_chart <- function(.data, .category) {
  # print(.data)
  # print(.msr_page1_date_option)
   # Filter the data based on the provided category
   filtered_data <- .data %>%
     filter(category == .category)
    # filter(format(period, "%Y-%m") == .msr_page1_date_option)
   
  # print(filtered_data)
   
   # Define colors for the line and area
   .line_color <- "#BED2E0"
   .area_color <- "#E4F4FF"
   
   # Create the ggplot object with the filtered data
   p <- ggplot(filtered_data, aes(x = period, y = value)) +
     # Add a line plot with specified color and size
     geom_line(color = .line_color, size = 0.5) +
     # Add an area plot with specified fill color and transparency
     geom_area(fill = .area_color, alpha = 0.3) +
     # Apply minimal theme to the plot
     theme_minimal() +
     # Customize theme to remove axis titles, axis text, and gridlines
     theme(
       axis.title = element_blank(),
       axis.text = element_blank(),
       plot.margin = margin(0, -6, -3, -6, "pt"), # Adjust margins
       panel.grid.major = element_blank(), 
       panel.grid.minor = element_blank(),
     )
   
   print(p)
   # Convert the ggplot object to a plotly object with tooltips
     #  ggplotly(p, tooltip = c("x", "y", "text"), hoverinfo = "text") %>%
     # # Disable display mode bar (toolbar)
     # config(displayModeBar = FALSE) %>%
     # # Set layout margins to remove extra space around the plot
     # layout(margin = list(l = 0, r = 0, t = 0, b = 0))
  
 }

msr_page1_server <- function(input, output, session, .data1, .data2) {
  
 
  
  
  
  render_net_sales_value <- function(.data1, .category) {
    
    renderText({
      glue("
      {ya_value_box(.data1, .category)}
      {iop_le_value_box(.data1, .category, 'iop')}
      {iop_le_value_box(.data1, .category, 'le')}
      ")
    })
  }
  
  # Output for MTD sales
  output$composite_mtd_sales <- render_net_sales_value(.data1, "mtd")
  
  # Output for YTD sales
  output$composite_ytd_sales <- render_net_sales_value(.data1, "ytd")
  
  
  # ------------------------------------------------------- |
  
  #OP Profitability Render Section
  
  
  
  
  
  
  
  
  
  
  # Function to render the profitability value box based on category (MTD or YTD)
  render_op_profitability_value <- function(.data2, .category) {
    
    renderText({
      # Render the HTML code for the profitability value box using the specified category
      glue("
         {op_profitability_value_box(.data2, .category)}
        ")
    })
  }
  
  # Function to render the MTD/YTD value boxes for YA and IOP categories
  render_op_profitability_mtd_ytd_ya_iop_value_box <- function(.data2, .category) {
    
    renderText({
      # Render the HTML code for the value boxes of YA and IOP categories using the specified category
      glue("
    {iop_ya_value_box(.data2, .category, 'ya')}
    {iop_ya_value_box(.data2, .category, 'iop')}
    ")
    })
  }
  
  # Output for rendering MTD and YTD profitability value boxes
  output$composite_op_profitability_mtd_value_box <- render_op_profitability_value(.data2, "mtd")
  output$composite_op_profitability_ytd_value_box <- render_op_profitability_value(.data2, "ytd")
  
  output$composite_mtd_plot <- renderPlot(
      plot_op_profitability_chart(op_profibility_graph_data,
                                 'mtd')
    )
  output$composite_ytd_plot <- renderPlot(
      plot_op_profitability_chart(op_profibility_graph_data,
                                 'ytd')
    )
  
  # # Output for rendering MTD and YTD plotly plots
  # output$composite_mtd_plot <- renderPlotly(
  #   plot_op_profitability_chart(op_profibility_graph_data,
  #                              'mtd')
  # )
  # 
  # output$composite_ytd_plot <- renderPlotly(
  #   plot_op_profitability_chart(op_profibility_graph_data, 
  #                              'ytd')
  # )

  # Output for rendering MTD/YTD YA and IOP value boxes
  output$composite_mtd_ya_iop_value_box <- render_op_profitability_mtd_ytd_ya_iop_value_box(.data2, "mtd")
  output$composite_ytd_ya_iop_value_box <- render_op_profitability_mtd_ytd_ya_iop_value_box(.data2, "ytd")
  
  # Output for rendering the OP/OP% Profitability label with the selected date option
  output$op_profitability_label <- renderText({
    
    HTML(
      glue("
      <strong>OP/OP% Profitability </strong> - 
      <font color=lightgray>
         {format(as_date(paste0(input$msr_page1_date_option, '-1')), '%B %Y')}
      </font>
    ")
    )
  })
  
  
  
  # ------------------------------------------------------- |
  
  output$net_sales_value_label <- renderText({
    HTML(
      glue("
        <strong>Net sales value </strong> - 
        <font color=lightgray>
           {format(as_date(paste0(input$msr_page1_date_option, '-1')), '%B %Y')}
        </font>
      ")
    )
  })
  
  output$controllable_gm_profitability_label <- renderText({
    HTML('<strong>Controllable GM Profitability</strong>')
  })
  
  
  output$net_sales_value_per_kilo_label <- renderText({
    HTML('<strong>Net sales value</strong>')
  })
  
  output$market_share_label <- renderText({
    HTML('<strong>Market Share</strong>')
  })
  
  output$bias_label <- renderText({
    HTML('<strong>Bias</strong>')
  })
}