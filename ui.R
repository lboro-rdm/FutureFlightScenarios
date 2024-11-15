library(shiny)
library(shinydashboard)

# Define UI for application
ui <- fluidPage(
  titlePanel("Future Flight Scenario Toolkit"),
  fluidRow(
    column(9,
           h4(style = "color:blue;", "Baseline Trends"),
           tags$ul(
             tags$li(style = "color:blue;", textOutput("baseline1")),  # Display baseline trend 1
             tags$li(style = "color:blue;", textOutput("baseline2"))   # Display baseline trend 2
           ),
    ),
    column(3,
            downloadButton("downloadPDF", "Download PDF")
           )
  ),
  fluidRow(
    column(12,
           p(),
           h3("Scenario Matrix"),
           div(style = "text-align: center;",
               p(tags$strong(style = "color:red;", "Scenario driver")),
               div(style = "color: red;", textOutput("driverTop")),
              p()
           )
    )
  ),
  fluidRow(
    column(3),
    column(3,
           textInput("Scenario1", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 1"), 
                     value = "")
           
    ),
    column(3,
           textInput("Scenario2", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 2"), 
                     value = "")
           
    ),
    column(3)
  ),
  fluidRow(
    column(3,
           div(style = "text-align: center;",
               textInput("altDriverLeft", 
                         label = tags$label(style = "color: green;", "Alternative Driver"), value = "")
           )
           ),
    column(6),
    column(3,
           p(tags$strong(style = "color:red;", "Scenario driver")),
           div(style = "color: red;", textOutput("driverRight")),
           )
  ),
  fluidRow(
    column(3),
    column(3,
           textInput("Scenario3", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 3"), 
                     value = "")
           
    ),
    column(3,
           textInput("Scenario4", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 4"), 
                     value = "")
           
    ),
    column(3)
  ),
  fluidRow(
    column(12,
           div(style = "text-align: center;",
               div(style = "display: inline-block; width:20%;",
                   textInput("altDriverBottom", 
                             label = tags$label(style = "color: green;", "Alternative Driver"), value = "")
               )
           )
    )
  )
)

