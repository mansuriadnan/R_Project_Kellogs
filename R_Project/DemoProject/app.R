library(bslib)
library(shiny)
library(htmltools)
library(plotly)
library(leaflet)
library(shinydashboard)
library(DT)

# Create the data frame
df <- data.frame(
  Offtake = c("$96M", "$96M", "$96M", "$96M"),
  `From YA` = c("$37M", "$37M", "$37M", "$37M"),
  row.names = c("MAT", "P6M", "P3M", "YTD"),
  stringsAsFactors = FALSE
)

# Add column names for better clarity
colnames(df) <- c("Offtake", "From YA")

# Create the DT table
htmltable <- datatable(df, class = "detail-table",
                       options = list(
                         paging = FALSE,
                         searching = FALSE,
                         ordering = FALSE,
                         info = FALSE
                       ),
                       rownames = TRUE) %>%
  formatStyle(
    "Offtake",
    color = styleEqual("$96M", "#279EFF"),
    fontSize = '14px',
    fontWeight = 'bold',

    fontFamily = 'Montserrat',
    textTransform = 'capitalize',

  ) %>%
  formatStyle(
    "From YA",
    color = styleEqual("$37M", "#2F9300"),
    fontSize = '14px',
    fontWeight = 'bold',
    fontFamily = 'Montserrat',
    textTransform = 'capitalize',


  )


firsttwotitle <- div(
  class = "header-outer",
  div(
    class = "header-outer-left",
    h5("Offtake"),
    span("Apr, 2023")
  ),
  div(
    class = "header-outer-right",
    h2("$10.4M"),
    div(
      class = "year-ago",
      strong(
        div(class = "arrow-color", HTML('<svg xmlns="http://www.w3.org/2000/svg" width="12" height="11" viewBox="0 0 12 11" fill="none"><path d="M6 0L12 11H0L6 0Z" fill="#2F9300"></path></svg>')),
        "112%"
      ),
      span("From Year Ago")
    )
  )
)

firsttwotitle <- div(
  class = "header-outer",
  div(
    class = "header-outer-left",
    h5("Offtake"),
    span("Apr, 2023")
  ),
  div(
    class = "header-outer-right",
    h2("$10.4M"),
    div(
      class = "year-ago",
      strong(
        div(class = "arrow-color", HTML('<svg xmlns="http://www.w3.org/2000/svg" width="12" height="11" viewBox="0 0 12 11" fill="none"><path d="M6 0L12 11H0L6 0Z" fill="#2F9300"></path></svg>')),
        "112%"
      ),
      span("From Year Ago")
    )
  )
)


SecondTwoTableTitle <- div(
  class = "header-outer",
  div(
    class = "header-outer-left",
    h5("Offtake"),
    span("Apr, 2023")
  ), div(
    class = "header-outer-right",
    tags$a(
      href = "#",
      tags$img(src = 'images/cross.svg', height = '40', width = '150'),
      )
    )
  )


lastbox <- div(
  class = "header-outer",
  div(
    class = "header-outer-left",
    h5("Offtake")
  ),
  div(
    class = "header-outer-right",
    h2("$10.4M"),
    div(
      class = "year-ago",
      strong(
        class = "red",
        div(
          class = "arrow-color",
          icon("up"),
          " 112%"
        ),
      ),
      span("From Year Ago"),
    )
  )
)


coreindexfooter <- div(
  class = "details-of-share-groth",
  span(
    class = "blue-color"
  ),
  tags$ul(
    tags$li(
      h6("CORE INDEX"),
      h5(
        class = "color-green",
        "107"
      )
    )
  )
)


dashboardBody <- dashboardBody(


#Bring in the style sheet from the www folder
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),

#Tell shiny what version of d3 we want
#tags$script(src='//d3js.org/d3.v3.min.js'),
  tags$script(src = 'https://d3js.org/d3.v7.min.js'),

  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/styledhaval.css")),


  box(firsttwotitle, id = "plot1",
      div(
        class = "draph-details",
        div(
          class = "draph-details-wrapper",
          div(
            class = "draph-details-left",
            div(
              class = "details-inner-boxes",
              valueBoxOutput("firstbox"),
              valueBoxOutput("secondbox"),
            ),
            htmltable,

          ),
          div(
            class = "graph left-graph",
#The d3 graph
            uiOutput("chartcontaine1")

          )
        )),

  ),

  box(firsttwotitle, id = "plot2",
      div(
        class = "draph-details",
        div(
          class = "draph-details-wrapper",
          div(
            class = "draph-details-left",
            div(
              class = "details-inner-boxes",
              valueBoxOutput("firstbox1"),
              valueBoxOutput("secondbox1"),
            ),
            htmltable,

          ),
          div(
            class = "graph left-graph",
#The d3 graph
            uiOutput("chartcontaine2")

          )
         )
        ),
      ),


  box(SecondTwoTableTitle, id = "plot3", class = "two-boxes",
      div(
        class = "draph-details",
        div(
          class = "draph-details-wrapper",

#The d3 graph
          div(
            class = "two-graph-left",

            uiOutput("chartcontainer3")),

          div(
            class = "two-graph-right",
            uiOutput("chartcontainer4"))
        )
      ),
  ),

  box(SecondTwoTableTitle, id = "plot4", class = "two-boxes",
      div(
        class = "draph-details",
        div(
          class = "draph-details-wrapper",

#The d3 graph
          div(
            class = "two-graph-left",
            lastbox,
            htmltable,
            coreindexfooter
          ),

          div(
            class = "two-graph-right",
            lastbox,
            htmltable,
            coreindexfooter
          )
        )
      ),
  ),
)