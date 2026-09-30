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
          <span style='color:gray;font-weight:300;'>vs YA</span>
        </div>
      </div>
                
      <p style='font-size:50%'>{.value_label}</p>
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
  
  #   bps <- .data %>%
  #   mutate(bps = (value - ref_value) / ref_value * 10000) %>%
  #   pull(bps)
  # .mtd_ytd_bps <- bps
  
#  print(.mtd_ytd_bps)
  
  glue("<div style='font-size:1.6vw; padding: 15px 15px 10px 15px;'>
         <div style='display:flex;align-items:center;'>
         <div style='line-height:1;display: flex;flex-direction: row; align-items: center;'>
         <span style='font-weight:900;color:var(--msr-value-color)'>{round(.mtd_ytd_value * 100)}%</span>
         <i class='fa-solid fa-arrow-{.delta_glyph}' style='font-size:70%;color:var(--msr-{.delta_glyph}-color);margin-left:0.2em'></i>
         </div>
         
         <div style='text-align:left;margin-left:0.5em;font-size:50%;'>
              <div class='net-value-sale'>
									<strong class='{.color}-color-text'>{round(.mtd_ytd_value * 100)}%</strong>
									<span style='display: block; font-weight: 700;font-size: 82%;'>net sales value</span>
				      </div>
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
  
  .iop_le <- ifelse(.iop_le == "iop", "IOP", "YA")
  
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

# Function to generate the net sales value box
render_op_profitability_value_box <- function(.mtd_ytd) {
  column(
         width = 6,
         tags$div(
         class = "index-vs-ya",
         htmlOutput(glue("composite_op_profitability_{.mtd_ytd}_value_box")),
         plotlyOutput(glue("composite_{.mtd_ytd}_plot"), height = "50px")),
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
               choices = msr_page1_date_options
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
            render_op_profitability_value_box("mtd"),  # Generate op_profitability value box for MTD
            render_op_profitability_value_box("ytd")   # Generate op_profitability value box for YTD
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

 
 plot_offtake_trend <- function(data, category) {
   print(data)
   
   filtered_data <- data %>%
     filter(category == category)
   
   .line_color <- "#D2DFE8"
   .area_color <- "#E4F4FF"
   
   p <-  ggplot(filtered_data, aes(x = period, y = value)) +
     geom_line(color = .line_color, size = 0.5) +  # Single line
     geom_area(fill = .area_color, alpha = 0.3) +  # Area under the line
  
     theme_minimal() +
     theme(
       axis.title = element_blank(),
       axis.text = element_blank(),
       axis.ticks = element_blank(),
       axis.ticks.length = unit(0, "pt"), 
       panel.grid.major = element_blank(), 
       panel.grid.minor = element_blank()
     )
     ggplotly(p, tooltip = c("x", "y", "text"), hoverinfo = "text") %>% 
       config(displayModeBar = FALSE) %>%
       layout(margin = list(l = 0, r = 0, t = 0, b = 0))

   
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
  
  render_op_profitability_value <- function(.data2, .category) {
    
    renderText({
      glue("
            {op_profitability_value_box(.data2, .category)}
           ")
          })
  }
  
  render_op_profitability_mtd_ytd_ya_iop_value_box <- function(.data2, .category) {
    
    renderText({
      glue("
      {iop_ya_value_box(.data2, .category, 'ya')}
      {iop_ya_value_box(.data2, .category, 'iop')}
      ")
    })
  }
  
  render_op_profitability_graph <- function() {
    
    renderPlot({
      
      # Generate dummy monthly data
      set.seed(123)
      months <- seq(as.Date("2024-01-01"), by = "month", length.out = 24)
      sales <- sample(100:200, 24, replace = TRUE)
      
      # Create a data frame
      sales_data <- tibble(Month = months, Sales = sales)
      
      # Plotting the line area chart with interactive data labels
      p <- sales_data %>%
        ggplot(aes(x = Month, y = Sales, label = Sales)) +
        geom_area(fill = "#E4F4FF", alpha = 0.5) +  # Area
        geom_line(color = "#C7D8E5") +  # Line
        theme_minimal() +  # Theme
        #geom_text_repel(size = 3) +  # Add data labels with repulsion
        theme(legend.position = "none", axis.title = element_blank(), 
              axis.text.x = element_blank(),
              axis.text.y = element_blank())
      
      print(p)
    }) 
    
  }
  
  # Output for MTD sales
  output$composite_mtd_sales <- render_net_sales_value(.data1, "mtd")
  
  # Output for YTD sales
  output$composite_ytd_sales <- render_net_sales_value(.data1, "ytd")
  
  # ------------------------------------------------------- |
  
  #OP Profitability Render Section
  
  output$composite_op_profitability_mtd_value_box <- render_op_profitability_value(.data2, "mtd")
  output$composite_op_profitability_ytd_value_box <- render_op_profitability_value(.data2, "ytd")
  
  output$composite_mtd_plot <- renderPlotly(
    plot_offtake_trend(op_profibility_data,'mtd')
    
  )
  
  output$composite_ytd_plot <- renderPlotly(
    plot_offtake_trend(op_profibility_data,'ytd')
  )
  
  
 # output$composite_mtd_plot <- render_op_profitability_graph()
  #output$composite_ytd_plot <- render_op_profitability_graph()
  
  
  output$composite_mtd_ya_iop_value_box <- render_op_profitability_mtd_ytd_ya_iop_value_box(.data2, "mtd")
  output$composite_ytd_ya_iop_value_box <- render_op_profitability_mtd_ytd_ya_iop_value_box(.data2, "ytd")
  
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