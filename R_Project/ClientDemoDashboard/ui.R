library(shiny)
library(reactable)

ui <- fluidPage(
  titlePanel("Custom reactable example"),
  reactableOutput("table")
)

server <- function(input, output, session) {
  
  # Sample dynamically loaded data
  data <- reactive({
    data.frame(
      Offtake = c("$96M", "$96M", "$96M", "$96M"),
      `From YA` = c("$37M", "$37M", "$37M", "$37M"),
      row.names = c("MAT", "P6M", "P3M", "YTD"),
      stringsAsFactors = FALSE
    )
  })
  
  output$table <- renderReactable({
    reactable(
      data = data(),
      columns = list(
        colDef(
          name = "Offtake",
          aggregate = "sum",
          format = list(
            `sum(Offtake)` = htmltools::html(
              function(value) {
                paste0("$", sum(as.numeric(gsub("\\D", "", value))))
              }
            )
          )
        ),
        colDef(
          name = "From YA",
          aggregate = "sum",
          format = list(
            `sum(From YA)` = htmltools::html(
              function(value) {
                paste0("$", sum(as.numeric(gsub("\\D", "", value))))
              }
            )
          )
        )
      ),
      defaultColDef = colDef(
        minWidth = 100
      )
    )
  })
}

shinyApp(ui, server)
