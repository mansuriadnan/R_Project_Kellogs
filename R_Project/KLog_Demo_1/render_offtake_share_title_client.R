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
