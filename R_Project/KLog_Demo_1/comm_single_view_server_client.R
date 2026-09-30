comm_single_view_server <- function(input, output, session, .data1, .data2, .data3, .data4) {
  
  # Generate sample data frames
  set.seed(123)  # Set seed for reproducibility
  
  # Generate sample data for data1
  .data1 <- data.frame(
    Date = seq(as.Date("2022-01-01"), as.Date("2022-12-31"), by = "month"),
    Value = rnorm(12, mean = 100, sd = 20),
    Market = sample(c("AMEA", "AU", "JP", "KR", "TH"), 12, replace = TRUE)
  )
  
  # Generate sample data for data2
  .data2 <- data.frame(
    Market = c("AMEA", "AU", "JP", "KR", "TH"),
    Value = rnorm(5, mean = 500, sd = 100)
  )
  
  # Generate sample data for data3
  .data3 <- data.frame(
    Date = seq(as.Date("2022-01-01"), as.Date("2022-12-31"), by = "month"),
    Share = runif(12, min = 0, max = 1)
  )
  
  # Generate sample data for data4
  .data4 <- data.frame(
    Date = seq(as.Date("2022-01-01"), as.Date("2022-12-31"), by = "month"),
    Offtake = rnorm(12, mean = 200, sd = 30)
  )
  
  # Generate sample data for redslim_end_date_p
  redslim_end_date_p <- as.Date("2022-12-31")
  
  #   .data1 = pringles_mcontr_and_mshare,
  #   .data2 = p_test1,
  #   .data3 = pringles_mshare,
  #   .data4 = offtakes_dollar,
  .end_date = redslim_end_date_p
  
  composite_share <- function(data, market_id, end_date) {
    # Your implementation of composite_share function goes here
    # This is just a placeholder
    
    # For demonstration purposes, let's print the arguments received
    print(data)
    print(market_id)
    print(end_date)
  }
  
  output$composite_offtake_plot <- renderPlot(
    composite_offtake(
      .data4, 
      input$comm_composite_market_id, 
      .end_date
    )
  )  
  output$composite_share_plot <- renderPlot(
    composite_share(
      .data1, 
      input$comm_composite_market_id, 
      .end_date
    )
  )
  
  index_value_box <- function(.index, .label) {
    background_color <- ifelse(.index >= 100, paste0(kellanova_jade, '10'), paste0(kellanova_red, '10'))
    color <- ifelse(.index >= 100, kellanova_jade, kellanova_red)
    glue("<div style='width:49%;text-align:left;background-color:{background_color};border-radius:0.5em;line-height:70%;padding-top:1.1em;padding-bottom:0.7em;padding-left:1em'>
<span style='font-size:2em;font-weight:bold;color:{color}'>{.index}</span><br><br><span style='font-size:0.8em;font-weight:bold'>{.label}</span><br><span style='font-size:0.8em'>Index</span>
</div> ")
  }
  
  build_composite_share_data <- function(.data, .market_id, .current_month) {
    the_months <- c(1, 3, 6, 12)
    
    # Filter data based on market_id and current_month
    dg <- .data %>%
      filter(market_id == .market_id) %>%
      filter(date == .current_month)
    
    # Extract offtake values
    offtake <- dg %>%
      select(matches("s\\d{1,2}m$")) %>%
      pivot_longer(everything(), names_to = "name", values_to = "value") %>%
      mutate(roll = parse_number(name))
    
    # Extract offtake growth values
    offtake_growth <- dg %>%
      select(matches("s\\d{1,2}m_growth")) %>%
      pivot_longer(everything(), names_to = "name", values_to = "from_ya") %>%
      mutate(roll = parse_number(name))
    
    # Extract indices values
    indices <- dg %>%
      select(matches("s\\d{1,2}m$")) %>%
      pivot_longer(everything(), names_to = "name", values_to = "value") %>%
      mutate(roll = parse_number(name)) %>%
      filter(roll %in% the_months) %>%
      arrange(roll) %>%
      mutate(
        index = value / lead(value),
        index = round(index * 1e2)
      )
    
    # Define category based on roll
    df <- offtake_growth %>%
      filter(roll %in% the_months) %>%
      left_join(offtake, by = "roll") %>%
      mutate(
        category = case_when(
          roll == 1 ~ "PIM",
          roll == 3 ~ "P3M",
          roll == 6 ~ "P6M",
          roll == 12 ~ "MAT",
          TRUE ~ NA_character_
        )
      )
    
    # Define category based on roll for YTD
    df <- df %>%
      mutate(
        category = case_when(
          roll == month(as_date(.current_month)) ~ "YTD",
          TRUE ~ NA_character_
        )
      )
    
    # Join dataframes and finalize output
    df <- bind_rows(df, df_) %>%
      select(category, value, from_ya) %>%
      mutate(
        value = value * 1e2,
        from_ya = round(from_ya * 1e4)
      )
    
    return(df)
  }
  
  
  # output$composite_segment_share_plot <- renderPlot(
  #   composite_segment_share(
  #     .data3, 
  #     input$comm_composite_market_id, 
  #     .end_date
  #   )
  # )
  # ----------------------------------------------------------------- |

  render_offtake_share_indices <- function(.offtake_share) {
    .fun <- paste0("build_composite_", .offtake_share, "_data")
    if(.offtake_share == "offtake") {
      .data <- .data4
    } else {
      .data <- .data1
    }
    renderText({
      t <- expr((!!.fun)(.data, input$comm_composite_market_id, .end_date))
      df <- eval(t)[[2]] 
      p6m_mat <- df$index[[3]]
      p3m_p6m <- df$index[[2]]
      glue("<div style='display:flex'>
      {index_value_box(p6m_mat, 'P6M/MAT')}
<div style='width:3%'></div>
      {index_value_box(p3m_p6m, 'P3M/P6M')}
</div>")
    })
  }
  output$composite_offtake_indices <- render_offtake_share_indices("offtake")
  output$composite_share_indices   <- render_offtake_share_indices("share")
  # -------------------------------------------------------------------------------- |
  
  composite_reactable <- function(.df, .offtake_share = 'share') {
    if(.offtake_share == 'offtake') {
      .value_label <- "Offtake"; .value_prefix <- '$'; .value_suffix <- 'M'; .growth_suffix <- '%'; .digits <- 0
    } else {
      .value_label <- "Share"; .value_prefix <- ''; .value_suffix <- '%'; .growth_suffix <- ' bps'; .digits <- 1
    }
    reactable(
      .df %>% 
        mutate(
          from_ya_ = ifelse(from_ya >= 0, '+', ''),
          from_ya = paste0(from_ya_, from_ya)
        ), 
      defaultColDef = colDef(
        headerStyle = list(background = "#f7f7f8", fontWeight='normal', color='#606060', fontSize='0.8em')
      ),
      columns = list(
        from_ya_ = colDef(show = FALSE),
        category = colDef(
          name     = "", 
          minWidth = 5, 
          align    = 'center', 
          style    = list(fontWeight='bold')
        ),
        value = colDef(
          name   = .value_label, minWidth = 10, align='center', 
          style  = list(fontWeight='bold', color = '#279EFF'),
          format = colFormat(prefix = .value_prefix, suffix = .value_suffix, digits = .digits)
        ),
        from_ya = colDef(
          name = "from YA", minWidth = 10, align = 'center', 
          #style = list(fontWeight = 'bold', color = kellanova_jade),
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
      .fun <- paste0("build_composite_", .offtake_share, "_data")
      if(.offtake_share == "offtake") {
        .data <- .data4
      } else {
        .data <- .data1
      }
      t <- expr((!!.fun)(.data, input$comm_composite_market_id, .end_date))
      df <- eval(t)[[1]] 
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
    
    .fun <- paste0("build_composite_", .offtake_share, "_data")
    if(.offtake_share == "offtake") {
      .data <- .data4
    } else {
      .data <- .data1
    }
    renderText({
      t <- expr((!!.fun)(.data, input$comm_composite_market_id, .end_date))
      df <- eval(t)[[1]] %>% filter(category == 'P1M')
      composite_title(round(df$value, 1), df$from_ya/100, .offtake_share)
    })
  }
  output$composite_offtake_title <- render_offtake_share_title("offtake")
  output$composite_share_title   <- render_offtake_share_title("share")
  
  # ------------------------------------------------------------------------------------- |
  render_segment_growth_value_box <- function(.core_t4bc)
    renderText({
      df <- compute_segment_share_growth_data(
        .data3, 
        input$comm_composite_market_id, 
        .end_date, 
        .core_t4bc
      )
      df <- df[[1]] %>% filter(category == 'P1M')
      composite_value_box(
        round(df$value, 1), 
        df$from_ya,
        .core_t4bc
      )
    })
  output$composite_share_growth_value_core <- render_segment_growth_value_box("Core")
  output$composite_share_growth_value_t4bc <- render_segment_growth_value_box("T4BC")
  render_segment_share_growth_reactable <- function(.core_t4bc) 
    renderReactable({
      df <- compute_segment_share_growth_data(
        .data3, 
        input$comm_composite_market_id, 
        .end_date, 
        .core_t4bc
      )
      composite_reactable(
        df[[1]] %>% filter(category != 'P1M')
      )
    })
  output$composite_share_growth_table_core <- render_segment_share_growth_reactable("Core")
  output$composite_share_growth_table_t4bc <- render_segment_share_growth_reactable("T4BC")
  render_segment_growth_indices <- function(.core_t4bc) 
    renderText({
      df <- compute_segment_share_growth_data(
        .data3, 
        input$comm_composite_market_id, 
        .end_date, 
        .core_t4bc
      )
      composite_segment_share_index(
        df[[2]]$ppi[[3]], #p6m_mat
        df[[2]]$ppi[[2]], #p3m_p6m
        .core_t4bc
      )
    })
  output$composite_share_growth_index_core <- render_segment_growth_indices("Core")
  output$composite_share_growth_index_t4bc <- render_segment_growth_indices("T4BC")
  # ------------------------------------------------------------------------------------- |
  render_segment_contr_value_box <- function(.core_t4bc) 
    renderText({
      df <- compute_segment_contr_data(
        .data2, 
        input$comm_composite_market_id
      ) %>% 
        filter(core_t4bc == .core_t4bc)
      composite_value_box(
        round(df$share * 1e2, 1), 
        df$delta,
        .core_t4bc
      )
    })
  output$composite_contr_value_core <- render_segment_contr_value_box("Core")
  output$composite_contr_value_t4bc <- render_segment_contr_value_box("T4BC")
  output$composite_contr_plot_core  <- renderPlot(composite_contr(.data2, input$comm_composite_market_id, 'Core'))
  output$composite_contr_plot_t4bc  <- renderPlot(composite_contr(.data2, input$comm_composite_market_id, 'T4BC'))
  # --------------------------------------------------------------------------------- |
  
  output$composite_contr_label <- renderText({
    glue("<strong>CONTRIBUTION BY SEGMENT</strong>&nbsp;&nbsp;&nbsp;<font color=gray>{redslim_end_date_by}</font>")
  })
  output$composite_segment_share_growth_label <- renderText({
    glue("<strong>SHARE GROWTH BY SEGMENT</strong>&nbsp;&nbsp;&nbsp;<font color=gray>{redslim_end_date_by}</font>")
  })
  
  
}
