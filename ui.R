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
           textAreaInput("scenario1", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 1"), 
                     value = "", rows = 4, cols = 40)
           
    ),
    column(3,
           textAreaInput("scenario2", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 2"), 
                     value = "", rows = 4, cols = 40)
           
    ),
    column(3)
  ),
  fluidRow(
    column(3,
           div(style = "text-align: center;",
               textAreaInput("altDriverLeft", 
                         label = tags$label(style = "color: green;", "Alternative Driver"), value = "", rows = 2, cols = 40)
           )
    ),
    column(6),
    column(3,
           div(style = "text-align: center;",
               p(tags$strong(style = "color:red;", "Scenario driver")),
               div(style = "color: red;", textOutput("driverRight"))
           )
    )
  ),
  fluidRow(
    column(3),
    column(3,
           textAreaInput("scenario3", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 3"), 
                     value = "", rows = 4, cols = 40)
           
    ),
    column(3,
           textAreaInput("scenario4", 
                     label = tags$label(style = "color: #D5006D;", "Scenario 4"), 
                     value = "", rows = 4, cols = 40)
           
    ),
    column(3)
  ),
  fluidRow(
    column(12,
           div(style = "text-align: center;",
               div(style = "display: inline-block; width:20%;",
                   textAreaInput("altDriverBottom", 
                             label = tags$label(style = "color: green;", "Alternative Driver"), value = "", rows = 2, cols = 40)
               )
           )
    )
  )
)),

tabPanel("Example",
fluidRow(
  column(12,
         div(style = "text-align: left;",
             h4(style = "color:blue;", "Baseline Trends"),
             tags$ul(
               tags$li(style = "color:blue;", "More geopolitical wars, disrupting the supply of key materials and components"),
               tags$li(style = "color:blue;", "Water/food scarcity due to climate change.")
             )
         )
  )
),

         fluidRow(
           column(4),
           column(4,
                  p(),
                  div(style = "text-align: center;",
                      h3("Scenario Matrix")),
                  div(style = "text-align: center;",
                      p(tags$strong(style = "color:red;", "Scenario driver")),
                      div(style = "color: red;", "Businesses focus more on society and the environment")
                  ),
                  p()
           ),
           column(4)
         ),
         fluidRow(
           column(3),
           column(3,
                  div(style = "border: 2px solid black; padding: 10px; margin: 5px; text-align: left;",
                      p(tags$strong(style = "color:#D5006D;", "Scenario 1")),
                      div(style = "color: #D5006D;", 
                          "Businesses prioritise addressing the societal and environmental needs, yet hampered by the limited access to the most advanced FF technologies development.")
                  )
           ),
           column(3,
                  div(style = "border: 2px solid black; padding: 10px; margin: 5px; text-align: left;",
                      p(tags$strong(style = "color:#D5006D;", "Scenario 2")),
                      div(style = "color: #D5006D;", 
                          "Businesses align with societal and environmental values. Sustainable innovations flourish. Decentralised supply chains are built to resist geopolitical shocks. FF technologies are adopted, propelled by the convenience.")
                  )
           ),
           column(3)
         ),
         fluidRow(
           column(3,
                  div(style = "text-align: center;",
                      p(tags$strong(style = "color:green;", "Alternative driver")),
                      div(style = "text-align: center; color: green;", 
                          "Future Flight technologies are limited to industrial / military applications")
                  )
           ),
           column(6),
           column(3,
                  div(style = "text-align: center;",
                      p(tags$strong(style = "color:red;", "Scenario driver")),
                      div(style = "text-align: center; color: red;", 
                          "Public see the increased convenience of Future Flight technologies")
                  )
           )
         ),
         fluidRow(
           column(3),
           column(3,
                  div(style = "border: 2px solid black; padding: 10px; margin: 5px; text-align: left;",
                      p(tags$strong(style = "color:#D5006D;", "Scenario 3")),
                      div(style = "color: #D5006D;", 
                          "Capital-driven businesses and restricted access to FF technologies exacerbate geopolitical tensions. Investments in military applications overshadow the societal and environmental needs, leading to conflicts between military-industrial and civilian needs.")
                  )
           ),
           column(3,
                  div(style = "border: 2px solid black; padding: 10px; margin: 5px; text-align: left;",
                      p(tags$strong(style = "color:#D5006D;", "Scenario 4")),
                      div(style = "color: #D5006D;", 
                          "Driven by the capital, businesses keep advancing technologies to enhance daily convenience. While the new consumer market is on the rise, the underlying problems of supply chains and resource scarcity are lurking in the background.")
                  )
           ),
           column(3)
         ),
         fluidRow(
           column(4),
           column(4,
                  p(),
                  div(style = "text-align: center;",
                      p(tags$strong(style = "color:green;", "Alternative driver")),
                      div(style = "text-align: center; color: green;", 
                          "Future Flight technologies are limited to industrial / military applications")
                  )
           ),
           column(4)
         )
),

  tabPanel("About"
  )


)