library(shiny)
library(shinydashboard)
library(shinyjs)  # Add this for enabling/disabling the button

# Define UI for application
ui <- navbarPage(
  useShinyjs(),  # Initialize shinyjs
  title = "Future Flight Scenario Toolkit",
  tabPanel("Imagine",
           fluidPage(
             p("INSTRUCTIONS: Consider the two baseline trends, then read the two scenario drivers. Input alterative drivers in the spaces provided and with that information consider four scenarios, each takes a combonation of scenario drivers and alternative drivers. Finally, download the pdf with your reflections, which you can bring to your team for discussion."),
  p(),
  p("Baseline trends capture the broader societal, technological, economic, or environmental trends in the envisioned future of 2050."),
  p(),
  p("Scenario drivers capture key factors that can significantly impact
the outcomes of future scenarios, such as changes in technological, environmental, or organisational contexts."),
  p("Each time you refresh this page, you will see new baseline trends and scenario drivers."),
  p("Click on the example tab to see an example."),
  p(),
  p(),
  p(),
  fluidRow(
    column(9,
           h4(style = "color:blue;", "Baseline Trends"),
           tags$ul(
             tags$li(style = "color:blue;", textOutput("baseline1")),  # Display baseline trend 1
             tags$li(style = "color:blue;", textOutput("baseline2"))   # Display baseline trend 2
           ),
    ),
    column(3,
           downloadButton("downloadPDF", "Download PDF", disabled = TRUE)  # Initially disabled
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
           textInput("scenario1", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 1"), 
                     value = "")
           
    ),
    column(3,
           textInput("scenario2", 
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
           div(style = "color: red;", textOutput("driverRight"))
    )
  ),
  fluidRow(
    column(3),
    column(3,
           textInput("scenario3", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 3"), 
                     value = "")
           
    ),
    column(3,
           textInput("scenario4", 
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
)),

  tabPanel("Example"
  ),

  tabPanel("About"
  )


)