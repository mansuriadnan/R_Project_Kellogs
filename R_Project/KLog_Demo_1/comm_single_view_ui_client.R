library(shiny)
library(bs4Dash)
library(glue)
library(reactable)
library(ggplot2)


comm_single_view_ui <- function() {
  
  vertical_space <- function(height) {
    tags$div(style = paste0("height: ", height * 100, "px;"))
  }
  filler_column <- function(width) {
  column(width = width, htmlOutput("filler_column"))
}

  setBoxClass <- function(bg = "bg-info", border = NULL, text = NULL, solidHeader = FALSE, status = NULL, solid = FALSE, title = NULL, collapsed = FALSE) {
    class_vec <- c("box", "box-default")
    
    if (!is.null(bg)) {
      class_vec <- c(class_vec, bg)
    }
    if (!is.null(border)) {
      class_vec <- c(class_vec, paste0("border-", border))
    }
    if (!is.null(text)) {
      class_vec <- c(class_vec, paste0("text-", text))
    }
    if (solidHeader) {
      class_vec <- c(class_vec, "collapsed-box")
    }
    if (!is.null(status)) {
      class_vec <- c(class_vec, paste0("box-", status))
    }
    if (solid) {
      class_vec <- c(class_vec, "box-solid")
    }
    if (!is.null(title)) {
      class_vec <- c(class_vec, paste0("with-border", ifelse(collapsed, "", "-collapsed")))
    }
    
    return(class_vec)
  }
  
  
  render_offtake_or_share_box <- function(.category)
    tags$div(
      class = 'col-sm-6',
      
      tagAppendChildren(
        tags$div(
          class = setBoxClass(NULL, FALSE, FALSE, FALSE, NULL, FALSE, NULL, NULL)
        ),
        tags$div(
          class = 'card-body',
          style = NULL, #setBoxStyle(NULL, NULL),
          fluidRow(
            column(
              width = 12,
              htmlOutput(glue("composite_{.category}_title")),
              vertical_space(0.6)
            )
          ),
          fluidRow(
            column(
              width = 4,
              htmlOutput(glue('composite_{.category}_indices')),
              vertical_space(0.6),
              reactableOutput(glue("composite_{.category}_table"))
            ),
            column(
              width = 8,
              plotOutput(glue("composite_{.category}_plot"), height = "300px")
            )
          )
        )
      )
    )
  render_segment_contr_box <- function(.core_t4bc)
    column(width = 6,
           htmlOutput(glue("composite_contr_value_{.core_t4bc}")),
           vertical_space(0.2),
           plotOutput(glue("composite_contr_plot_{.core_t4bc}"), height = "250px")
    )
  render_segment_growth_box <- function(.core_t4bc) 
    column(width = 6,
           htmlOutput(glue("composite_share_growth_value_{.core_t4bc}")),
           reactableOutput(glue("composite_share_growth_table_{.core_t4bc}")),
           vertical_space(0.6),
           htmlOutput(glue("composite_share_growth_index_{.core_t4bc}"))
    )
  tabPanel(
    title = HTML("I. Single View Summary"),
    vertical_space(0.5),
    fluidRow(
      render_offtake_or_share_box("offtake"),
      render_offtake_or_share_box("share")
    ),
    vertical_space(0.5),
    fluidRow(
      box(width = 6, maximizable = FALSE, collapsible = FALSE,
          title = htmlOutput('composite_contr_label'), 
          fluidRow(
            render_segment_contr_box("core"),
            render_segment_contr_box("t4bc")
          )
      ),
      box(width = 6, maximizable = FALSE, collapsible = FALSE,
          title = htmlOutput('composite_segment_share_growth_label'),
          
          fluidRow(
            render_segment_growth_box("core"),
            render_segment_growth_box("t4bc")
          )
      )
    ),
    fluidRow(
      filler_column(9),
      column(width = 3, align = "right",
             selectInput(
               inputId = "comm_composite_market_id",
               label = "Market:",
               choices = c("AMEA", "AU", "JP", "KR", "TH")
             )
      )
    )
  )
}

