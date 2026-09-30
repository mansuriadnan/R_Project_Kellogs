library(shiny)
library(bs4Dash)
library(glue)
library(reactable)

comm_single_view_ui <- function() {
  
  render_offtake_or_share_box <- function(.category) {
    div(
      class = 'col-sm-6',
      div(
        class = 'card-body'
      ),
      div(
        class = 'card-body',
        style = NULL,
        fluidRow(
          column(
            width = 12,
            htmlOutput(glue("composite_{.category}_title"))
          )
        ),
        fluidRow(
          column(
            width = 4,
            htmlOutput(glue('composite_{.category}_indices')),
            reactableOutput(glue("composite_{.category}_table"))
          )
        ),
        column(
          width = 8,
          plotOutput(glue("composite_{.category}_plot"), height = "300px")
        )
      )
    )
  }
  
  render_segment_contr_box <- function (.core_t4bc) {
    column(
      width = 6,
      htmlOutput(glue("composite_contr_value_{.core_t4bc}")),
      plotOutput(glue("composite_contr_plot_{.core_t4bc}"), height = "250px")
    )
  }
  
  render_segment_growth_box <- function(.core_t4bc) {
    column(
      width = 6,
      htmlOutput(glue("composite_share_growth_value_{.core_t4bc}")),
      reactableOutput(glue("composite_share_growth_table_{.core_t4bc}")),
      htmlOutput(glue("composite_share_growth_index_{.core_t4bc}"))
    )
  }
  
  tabPanel(
    title = HTML("I. Single View Summary"),
    fluidRow(
      render_offtake_or_share_box("offtake"),
      render_offtake_or_share_box("share")
    ),
    fluidRow(
      box(
        width = 6, maximizable = FALSE, collapsible = FALSE,
        title = htmlOutput('composite_contr_label'),
        fluidRow(
          render_segment_contr_box("core"),
          render_segment_contr_box("t4bc")
        )
      ),
      box (
        width = 6, maximizable = FALSE, collapsible = FALSE,
        title = htmlOutput('composite_segment_share_growth_label'),
        fluidRow(
          render_segment_growth_box("core"),
          render_segment_growth_box("t4bc")
        )
      )
    ),
    fluidRow(
      #filler_column(9),
      column(
        width = 3, align = "right",
        selectInput(
          inputId = "comm_composite_market_id",
          label = "Market: ",
          choices = c("AMEA", "AU", "JP", "KR", "TH")
        )
      )
    )
  )
}
