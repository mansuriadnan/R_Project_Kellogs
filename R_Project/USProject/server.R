server <- function(input, output, session) {
  data <- data.frame(
    date = c(
      "2020-04-01", "2020-06-01", "2020-08-01", "2020-10-01", "2020-12-01", "2021-02-01", "2021-04-01",
      "2020-04-01", "2020-06-01", "2020-08-01", "2020-10-01", "2020-12-01", "2021-02-01", "2021-04-01"
    ),
    population = c(62, 59.8, 62.8, 73.1, 79.8, 84.2, 96, 16.8, 15, 18.2, 25, 28, 30, 27),
    line = c(
      "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE", "MAT OFFTAKE",
      "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE", "P3M OFFTAKE"
    )
  )
  json_data <- toJSON(data, pretty = TRUE)
  
  #Lets look for changes in our vehicle class dropdown then crunch the data and serve it to D3
  observeEvent(input$goevent, {
    print(json_data)
    session$sendCustomMessage(type = "jsondata", json_data)
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  
  #This tells shiny to run our javascript file "script.js" and send it to the UI for rendering
  output$chartcontaine1 <- renderUI({
    HTML('<script type="text/javascript", src="scriptjson1.js">  </script>')
  })
  
  
  observeEvent(input$goevent1, {
    print(json_data)
    session$sendCustomMessage(type = "jsondata1", json_data)
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  
  #This tells shiny to run our javascript file "script.js" and send it to the UI for rendering
  output$chartcontaine2 <- renderUI({
    HTML('<script type="text/javascript", src="scriptjson2.js">  </script>')
  })
  
  
  observeEvent(input$goevent2, {
    print(json_data)
    session$sendCustomMessage(type = "jsondata2", json_data)
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  
  #This tells shiny to run our javascript file "script.js" and send it to the UI for rendering
  output$chartcontainer3 <- renderUI({
    HTML('<script type="text/javascript", src="jsoncharttwo.js">  </script>')
  })
  
  
  observeEvent(input$goevent3, {
    print(json_data)
    session$sendCustomMessage(type = "jsondata3", json_data)
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  
  #This tells shiny to run our javascript file "script.js" and send it to the UI for rendering
  output$chartcontainer4 <- renderUI({
    HTML('<script type="text/javascript", src="jsoncharttwo1.js">  </script>')
  })
  
  spantag <- tags$div(
    tags$strong("P6M/MAT"),
    tags$span("index")
  )

  
  output$firstbox <- renderValueBox({
    valueBox(
      "116", spantag,
    )
  })
  
  output$secondbox <- renderValueBox({
    valueBox(
      "109", spantag
    )
  })
  
  
  output$firstbox1 <- renderValueBox({
    valueBox(
      "116", spantag
    )
  })
  
  
  output$secondbox1 <- renderValueBox({
    valueBox(
      "109", spantag
    )
  })
  
  output$list <- renderUI({
    tags$div(class = "nav-menu",
             div(
               class = "actionbutton",
               style="display: none",
               actionButton("goevent", "Go"),
               actionButton("goevent1", "Go1"),
               actionButton("goevent2", "Go2"),
               actionButton("goevent3", "Go3"),
             ),
             tags$ul(
               lapply(c("Fiscal Years", last_five_years), function(year) {
                 if (year == "Fiscal Years") {
                   tags$li(year, class = "fiscal-years")
                 } else {
                   tags$li(year,href="#")
                 }
               })
             )
    )
  })
}