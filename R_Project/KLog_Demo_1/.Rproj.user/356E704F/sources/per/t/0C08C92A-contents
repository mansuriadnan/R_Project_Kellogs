
library(ggplot2)
library(ggtext)


composite_offtake <- function(.data) {
  plot_offtake_trend_version3(.data)
}

plot_offtake_trend_version3 <- function(.data) {
  print(.data);
  rolled_redslim_offtakes__ <- .data %>%
    mutate_at(vars(matches("l\\d{1,2}m")), ~./1e6) %>%
    select(date, dimension, brand, matches("l\\d{1,2}m$")) %>%
    filter(dimension == "dollar") %>%
    filter(brand == "PRINGLES") %>%
    mutate(date = date - days(14))
  
  print("rolled_redslim_offtakes__")
  print(rolled_redslim_offtakes__)
  
  max_date <- max(rolled_redslim_offtakes__$date)
  min_date <- max_date - years(1)
  month_max_date <- month(max_date) %% 2
  modulo <- ifelse(month_max_date == 1, 1, 0)
  
  l12m_max <- max(rolled_redslim_offtakes__$`112m`)
  l12m_min <- min(rolled_redslim_offtakes__$`112m`)
  l3m_max <- max(rolled_redslim_offtakes__$`13m`)
  l3m_min <- min(rolled_redslim_offtakes__$`13m`)
  
  scale <- l12m_max / l3m_max
  nudge <- (l12m_max - l12m_min) / 10 * 1.2
  offset <- 0
  
  transf <- function(.) ./scale + offset
  inv_transf <- function(x) scale * (x - offset)
  
  spec_orange <- '#FD9331'
  spec_blue <- '#7091F5'
  
  left_species_color <- spec_orange
  right_species_color <- spec_blue
  line_icon <- '\u25A0'
  
  rolled_redslim_offtakes__ %>%
    mutate(
      date = date,
      select_month = month(date) %% 2 == modulo,
      offtake_label12 = ifelse(date == max(rolled_redslim_offtakes__$date),
                               paste0('$', round(`112m`, 1), "M"),
                               paste0(round(`112m`, 1))),
      offtake_label3 = ifelse(date == max(rolled_redslim_offtakes__$date),
                              paste0('$', round(`13m`, 1), "M"),
                              paste0(round(`13m`, 1)))
    ) %>%
    ggplot(aes(x = date, y = '112m' )) +
    geom_line(size = 10 - 4 - 4, color = left_species_color) +
    geom_richtext(
      label.size = NA,
      data = . %>% filter(select_month),
      aes (label = offtake_label12),
      color = left_species_color, size = 3
    ) +
    geom_line(
      aes(y = inv_transf('13m')),
      color = right_species_color, size = 10 - 4,
      alpha = 1
    ) +
    geom_richtext(
      label.size = NA,
      data = . %>% filter(select_month),
      aes(
        label = offtake_label3,
        y = inv_transf('13m')
      ),
      color = right_species_color, size = 3
    ) +
    scale_y_continuous(
      sec.axis = sec_axis(trans = ~inv_transf(.), name = "Rolling-3-month offtake (million)", labels = scales::dollar_format()),
      labels = scales::dollar_format()
    ) +
    scale_x_date(
      date_labels = "%b",
      date_breaks = "2 months",
      expand = expansion(mult = c(0.05, 0.1))
    ) +
    labs(
      x = NULL,
      title = glue("<span style='color: {spec_orange}'>{line_icon}</span> **MAT OFFTAKE** <span style='color:gray'>VS</span> <span style='color:{spec_blue}'>{line_icon}</span> **P3M OFFTAKE**"),
      subtitle = glue("\u25bd <span style='color:{left_species_color}'>P12M offtake</span><span style='color:#848884'> vs. </span><span style='color:{right_species_color}'>R3M offtake</span>")
    ) +
    theme(
      axis.title = element_blank(),
      axis.text.y = element_blank(),
      axis.title.y.right = element_blank(),
      axis.text.y.right = element_blank(),
      axis.text.x = element_text(size = 12, color = "#909090"),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      plot.title = element_markdown(color = 'dimgray'),
      plot.subtitle = element_blank()
    )
}


