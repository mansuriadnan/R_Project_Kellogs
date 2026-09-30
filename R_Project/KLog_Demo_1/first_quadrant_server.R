library(magrittr)
library(dplyr)
library(lubridate)
library(tibble)
library(readxl)
source("ggplot.R")

comm_single_view_server <- function(input, output, session, .data1, .data2, .data3, .data4) {
  
  
  # Check if the date column exists in your dataset
  if (!"Date" %in% colnames(data)) {
    stop("Error: 'Date' column not found in the dataset.")
  }
  
  # Convert 'Date' column to Date type
  data$Date <- as.Date(data$Date)
  
  # Check if the date column is now of Date type
  if (!inherits(data$Date, "Date")) {
    stop("Error: Unable to convert 'Date' column to Date type.")
  }
  # Calculate P6M/MAT for the first quadrant (last 6 months)
  first_quadrant_value <- data %>%
    filter(Date >= as.Date("2021-12-31") - months(6)) %>%
    summarize(P6M_MAT = sum(Qty) / sum(Sale_Price))
  
  # 12/31/2022

  # Calculate P3M/P6M for the second quadrant (last 3 months over the previous 6 months)
  second_quadrant_value <- data %>%
    filter(Date >= as.Date("2022-12-31") - months(3)) %>%
    summarize(P3M_P6M = sum(Qty) / sum(Sale_Price))
  
  
  # Calculate metrics for first quadrant (P6M/MAT)
  p6m_mat <- sum(data$Qty[data$Date >= as.Date("2021-01-01") & data$Date <= as.Date("2021-06-30")]) /
    sum(data$Qty[data$Date < as.Date("2021-01-01")]) * mean(data$Sale_Price)
  
  # Calculate metrics for second quadrant (P3M/P6M)
  p3m_p6m <- sum(data$Qty[data$Date >= as.Date("2021-10-01") & data$Date <= as.Date("2021-12-31")]) /
    sum(data$Qty[data$Date >= as.Date("2021-07-01") & data$Date <= as.Date("2021-09-30")]) * mean(data$Sale_Price)
  

  print("--------------------")
  
  print(p3m_p6m)
  
  print("--------------------")
  
 
  set.seed(123)  # for reproducibility
  sample_data_rest <- data.frame(
    date = seq(as.Date("2020-01-01"), by = "month", length.out = 10),
    dimension = rep(c("dollar", "euro"), each = 5),
    brand = rep(c("PRINGLES", "LAY'S"), times = 5),
    l12m = runif(10, min = 1000000, max = 5000000),  # Random values for l12m
    l13m = runif(10, min = 1000000, max = 5000000)   # Random values for l13m
  )
  
  # Print original sample data
 # print("Original Sample Data:")
 # print(sample_data_rest)
  
  
  
  output$composite_offtake_plot <- renderPlot(
    #composite_offtake_iris(sample_data_rest)
    composite_offtake(
      sample_data_rest
    )
  )  
  
  
  kellanova_jade <-  "#D7C0AE"
  kellanova_red <- "red"
  
  index_color <- "#975D2E"
  blue_index_color <- "#3185DB"
  
  index_value_box <- function(.index, .label) {
    background_color <- ifelse(.index >= 100, paste0(kellanova_jade), paste0(kellanova_red, '10'))
    color <- ifelse(.index >= 100, index_color, blue_index_color)
    glue("<div style='width:49%;text-align:left;background-color:{background_color};border-radius:0.5em;line-height:70%;padding-top:1.1em;padding-bottom:0.7em;padding-left:1em'>
<span style='font-size:2em;font-weight:bold;color:{color}'>{.index}</span><br><br><span style='font-size:0.8em;font-weight:bold'>{.label}</span><br><span style='font-size:0.8em'>Index</span>
</div> ")
  }
  
  
   output$composite_offtake_indices <- renderText({
     
     df <- build_composite_offtake_data(
       .data4, 
       input$comm_composite_market_id, 
       .end_date
     )
     
     p6m_mat <- df[[2]]$index[[3]]
     p3m_p6m <- df[[2]]$index[[2]]
     
     glue("<div style='display:flex'>
       {index_value_box(p6m_mat, 'P6M/MAT')}
       <div style='width:3%'></div>
       {index_value_box(p3m_p6m, 'P3M/P6M')}
     </div>")
   })
   
   output$composite_share_indices <- renderText({
    
     df <- build_composite_share_data(
       .data1, 
       input$comm_composite_market_id, 
       .end_date
     )
     
     p6m_mat <- df[[2]]$index[[3]]
     p3m_p6m <- df[[2]]$index[[2]]
     
     glue("<div style='display:flex'>
       {index_value_box(p6m_mat, 'P6M/MAT')}
       <div style='width:3%'></div>
       {index_value_box(p3m_p6m, 'P3M/P6M')}
     </div>")
   })
  
  
  render_offtake_share_indices <- function(.offtake_share) {
    
    renderText({
      p6m_mat <- 116
      p3m_p6m <- 109
      glue("<div style='display:flex;'>
          {index_value_box(p6m_mat, 'P6M/MAT')}
          <div style='width:3%;'></div>
          {index_value_box(p3m_p6m, 'P3M/P6M')}
          </div>")
    })
  }
  
  
  output$composite_offtake_indices <- render_offtake_share_indices("offtake")
  output$composite_share_indices   <- render_offtake_share_indices("share")
  
  
  # -------------------------------------------------------------------------------- |
  
  composite_reactable <- function(.df, .offtake_share = 'share') {
    if (.offtake_share == 'offtake') {
      .value_label <- "Offtake"
      .value_prefix <- '$'
      .value_suffix <- 'M'
      .growth_suffix <- '%'
      .digits <- 0
    } else {
      .value_label <- "Share"
      .value_prefix <- ''
      .value_suffix <- '%'
      .growth_suffix <- ' bps'
      .digits <- 1
    }
    reactable(
      .df %>% 
        mutate(
          from_ya_ = ifelse(from_ya >= 0, '+', ''),
          from_ya = paste0(from_ya_, from_ya)
        ), 
      defaultColDef = colDef(
        headerStyle = list(background = "#f7f7f8", fontWeight = 'normal', color = '#606060', fontSize = '0.8em')
      ),
      columns = list(
        from_ya_ = colDef(show = FALSE),
        category = colDef(
          name = "", 
         # minWidth = 50,  # Adjust the width as needed
          align = 'center', 
          style = list(fontWeight = 'bold')
        ),
        value = colDef(
          name = .value_label, 
        #  minWidth = 30,  # Adjust the width as needed
          align = 'center', 
          style = list(fontWeight = 'bold', color = '#279EFF'),
          format = colFormat(prefix = .value_prefix, suffix = .value_suffix, digits = .digits)
        ),
        from_ya = colDef(
          name = "from YA", 
        #  minWidth = 60,  # Adjust the width as needed
          align = 'center', 
          style = JS(
            glue(.open = "{{", .close = "}}",
                 "function(rowInfo) {
            const value = rowInfo.values['from_ya_']
            let color
            if (value < 100) {
              color = '{{kellanova_red}}'
            } else {
              color = '{{kellanova_jade}}'
            }
            return {color: color, fontWeight: 'bold'}
          }"
            )
          ),
          format = colFormat(suffix = .growth_suffix)
        )
      ),
      bordered = TRUE
    )
  }
  
  
  render_offtake_share_reactable <- function(.offtake_share) 
    renderReactable({
     # .fun <- paste0("build_composite_", .offtake_share, "_data")
      if(.offtake_share == "offtake") {
        .data <- 116
      } else {
        .data <- 109
      }
      #t <- expr((!!.fun)(.data, NULL, NULL))
     # df <- eval(t)[[1]] 
      df <- data.frame(
        category = c("MAT", "P6M", "P3M", "YTD"),
        Offtake = c("$96M", "$96M", "$96M", "$96M"),
        from_ya = c("$37M", "$37M", "$37M", "$37M")
      #  stringsAsFactors = FALSE
      )
      
    
      composite_reactable(
        df %>% filter(category != 'P1M'), 
        .offtake_share
      )
    })
  
  
  output$composite_offtake_table <- render_offtake_share_reactable("offtake")
  output$composite_share_table   <- render_offtake_share_reactable("share")
  # -------------------------------------------------------------------------- |
  
  
  
  render_offtake_share_title <- function(.offtake_share) {
    composite_title <- function(.value, .growth, .offtake_share) {
      redslim_end_date_by <- "April, 2024"
      if(.offtake_share == 'offtake') {
        .value_label <- "OFFTAKE"
        .value_prefix <- '$'
        .value_suffix <- 'M'
        .growth_suffix <- '%'
      } else {
        .value_label <- "SHARE"
        .value_prefix <- ''
        .value_suffix <- '%'
        .growth_suffix <- ' bps'
      }
      delta_glyph <- ifelse(.growth >= 0, "▲", "▼")
      glyph_color <- ifelse(.growth >= 0, kellanova_jade, kellanova_red)
      glue("<div style='display:flex;font-size:18px;border-bottom: 1px solid #E8E8E8;'>
<div style='width:40%;text-align:left;padding-top:0.3em;'>
<strong>{.value_label}</strong>&nbsp;&nbsp;&nbsp;<font color=gray>{redslim_end_date_by}</font>
</div>
<div style='width:36%'></div>
<div style='width:18%;text-align:right'>
<span style='font-weight:bold;font-size:1.5em'>{.value_prefix}{.value}{.value_suffix}</span>
</div>
<div style='width:1%;text-align:right'></div>
<div style='width:6%;text-align:left;font-size:0.7em;padding-top:0.6em;line-height:95%'>
<font color={glyph_color}>{delta_glyph} {.growth * 1e2}{.growth_suffix}</font><br><font color=gray>from YA</font>
</div>
</div>"
      )
    }
    
   # .fun <- paste0("build_composite_", .offtake_share, "_data")
    if(.offtake_share == "offtake") {
      .value <- 96
      .growth <- 0.1
    } else {
      .value <- 10
      .growth <- 0.05
    }
    renderText({
    #  t <- expr((!!.fun)(.data, NULL, NULL))
     # df <- eval(t)[[1]] %>% filter(category == 'P1M')
      #composite_title(round(df$value, 1), df$from_ya/100, .offtake_share)
      composite_title(.value, .growth, .offtake_share)
    })
  }
  
  
  output$composite_offtake_title <- render_offtake_share_title("offtake")
  output$composite_share_title   <- render_offtake_share_title("share")
 
}
