library(shiny)
library(bs4Dash)
library(reactable)
library(glue)

first_quadrant_view_ui <- function()  {
  #fiscal_years <- NULL
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
   
    tabPanel(
      title = HTML("I. Single View Summary"),
    #  tableOutput("table"),
     # vertical_space(0.5),
      fluidRow(
        column(width = 6, h3("Header Data: Last Five Years")),
        column(
          width = 6,
          #align = "right",
         # uiOutput("year_links")
         selectInput(
           inputId = "comm_composite_market_id",
           label = "Market:",
           choices = c("2022", "2021", "2020", "2019", "2018")
         )
        )
      )
    ,
      fluidRow(
        render_offtake_or_share_box("offtake"),
        render_offtake_or_share_box("share")
      )
    )
  }