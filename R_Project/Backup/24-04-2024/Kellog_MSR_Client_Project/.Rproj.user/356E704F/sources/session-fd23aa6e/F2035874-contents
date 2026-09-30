library(tidyverse)


# test data 
dummy_net_sales_data <- tibble(
  ref = c("ya", "iop", "le", "ya", "iop", "le"),
  ref_value = c(33, 37, 40, 100, 110, 120) * 1e4,
  value = c(45, 45, 45, 130, 130, 130) * 1e4,
  category = c("mtd", "mtd", "mtd", "ytd", "ytd", "ytd")
)

dummy_op_profibility_data <- tibble(
  ref = c("ya", "iop", "le", "ya", "iop", "le"),
  ref_value = c(30, 45, 50, 110, 120, 130) * 1e4,
  value = c(50, 50, 50, 140, 140, 140) * 1e4,
  category = c("mtd", "mtd", "mtd", "ytd", "ytd", "ytd"),
  period = as_date("2024-4-1")
)

dummy_op_profibility_for_graph <- tibble(
  ref = c("ya", "iop", "le", "ya", "iop", "le"),
  value = c(30, 45, 50, 110, 120, 130) * 1e4,
  ref_value = c(50, 60, 70, 80, 90, 100) * 1e4,
  category = c("mtd", "mtd", "mtd", "ytd", "ytd", "ytd"),
  period = as_date("2024-1-1")
)

# Extract the starting date
start_date <- dummy_op_profibility_for_graph$period[1]

# Create a tibble with a sequence of dates covering 12 months
dates <- tibble(period = seq(start_date, by = "1 month", length.out = 12))

# Replicate the sample data for each month
op_profibility_graph_data <- map_dfr(dates$period, ~ mutate(dummy_op_profibility_for_graph, period = .x))



# --------------------------

ns_ <- function(i, id) NS(id, i)

setBoxStyle <- function(height, sidebar) {
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  # add padding if box sidebar
  if (!is.null(sidebar)) {
    style <- paste0(style, "; padding: 10px;")
  }
  style
}


setBoxClass <- function(status, solidHeader, collapsible, collapsed, elevation, gradient, background, sidebar) {
  cardCl <- "card bs4Dash"
  
  if (!is.null(status)) {
    cardCl <- paste0(cardCl, " card-", status)
  }
  
  if (!solidHeader) cardCl <- paste0(cardCl, " card-outline")
  
  if (collapsible && collapsed) cardCl <- paste0(cardCl, " collapsed-card")
  if (!is.null(elevation)) cardCl <- paste0(cardCl, " elevation-", elevation)
  
  if (!is.null(background)) {
    cardCl <- paste0(cardCl, " bg-", if (gradient) "gradient-", background)
  }
  
  
  if (!is.null(sidebar)) {
    sidebarToggle <- sidebar[[1]]
    startOpen <- sidebarToggle$attribs$`data-start-open`
    if (startOpen == "true") {
      cardCl <- paste0(cardCl, " direct-chat direct-chat-contacts-open")
    } else {
      cardCl <- paste0(cardCl, " direct-chat")
    }
  }
  
  cardCl
}




sidebarUserPanel2 <- function(name, image = NULL) {
  
  shiny::tags$div(
    class = "user-panel mt-3 pb-3 mb-3 d-flex", 
    if (!is.null(image)) {
      shiny::tags$div(class = "image", shiny::img(src = image, class = "img-circle elevation-2"))
    }, 
    
    shiny::tags$div(
      style = "background-color:transparent;",
      class = "info", shiny::a(class = "d-block", href = "#", name)
    )
  )
}



# ---------------------------------------------------------------- |

vertical_space <- function(.margin)
  HTML(
    glue("<div style='margin-top:{.margin}em'></div>")
  )


filler_column <- function(.width) 
  column(
    width = .width,
    align = "center"
  )

# ---------------------------------------------------------------- |

col2hex <- function(color_name){
  
  red    = col2rgb(color_name)[1] %>% as.hexmode()
  green  = col2rgb(color_name)[2] %>% as.hexmode()
  blue   = col2rgb(color_name)[3] %>% as.hexmode()
  
  if(nchar(red)   == 1) red   = paste0("0", red)
  if(nchar(green) == 1) green = paste0("0", green)
  if(nchar(blue)  == 1) blue  = paste0("0", blue)
  
  paste0("#", red, green, blue)
}

# ----------------------------------------------------------------- |





