composite_reactable <- function(.df, .offtake_share) {
  if (.offtake_share == "offtake") {
    .value_label <- "Offtake"; .value_prefix <- '$'; .value_suffix <- 'M'; .growth_suffix <- '%'; .digits <- 0
  } else {
    .value_label <- "Share"; .value_prefix <- ''; .value_suffix <- '%'; .growth_suffix <- bps; digits <- 1
  }
  reactable(
    .df %>%
      mutate(
        from_ya_ = ifelse(from_ya >= 0,
                          '',
                          ''),
        from_ya = paste0(from_ya_, from_ya)
      ),
    defaultColDef = colDef(
    ),
    headerStyle = list(background = "#f7f7f8", fontWeight='normal', color='#606060', fontSize='0.8em'),
    columns = list(
      from_ya_ = colDef (show = FALSE),
      category = colDef(
        name = 5,
        minWidth = 50,
        align = 'center',
        style = list(fontWeight='bold')
      ),
      value = colDef(
      ),
      name = .value_label,
      minWidth = 10,
      align='center',
      style = list(fontWeight='bold', color = '#279EFF'),
      format = colFormat(prefix = .value_prefix, suffix = .value_suffix, digits = .digits)
    ),
    from_ya=colDef(
      name = "from YA",
      minWidth = 10,
      align = 'center',
      style = JS(
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
      ),
      format = colFormat(suffix = .growth_suffix)
    ),
    bordered = TRUE
  )
}