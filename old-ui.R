library(shiny)
library(shinydashboard)
library(shinyjs)
library(pagedown)  # For PDF generation

# Define UI for application
ui <- fluidPage(
  useShinyjs(),  # for dynamic UI actions
  titlePanel("Scenario Planning"),
  
  fluidRow(
    # Baseline Trends section
    column(8, 
           h3("Baseline Trends"),
           tags$ul(
             tags$li(textOutput("baseline1")),  # Display baseline trend 1
             tags$li(textOutput("baseline2"))   # Display baseline trend 2
           ),
           
           h3("Scenario Matrix"),
           textOutput("driverTop"),  # Scenario driver top
           
           # Arrange scenarioPlot and driverRight side by side
           fluidRow(
             # Left column for driverLeft
             column(2,
                    textInput("driverLeft", label = "Alternative Driver", value = "")
             ),
             # Left column for scenarioPlot
             column(8,
                    plotOutput("scenarioPlot", height = "300px")  # Placeholder for the 4-quadrant plot
             ),
             
             # Right column for driverRight
             column(2,
                    textOutput("driverRight")  # Scenario driver right
             )
           ),
           textInput("driverBottom", label = "Driver (Bottom)", value = "")
    ),
    
    # User Inputs for Quadrants and Alternative Drivers
    column(4, 
           # Alternative Drivers
           h3("Alternative Drivers"),
           textInput("altDriverLeft", label = "Alternative Driver Left", value = ""),
           textInput("altDriverBottom", label = "Alternative Driver Bottom", value = ""),
           
           h3("Write Scenarios for Each Quadrant"),
           textInput("quad1", label = "Top Left Quadrant Scenario", value = ""),
           textInput("quad2", label = "Top Right Quadrant Scenario", value = ""),
           textInput("quad3", label = "Bottom Left Quadrant Scenario", value = ""),
           textInput("quad4", label = "Bottom Right Quadrant Scenario", value = ""),
           
           downloadButton("downloadPDF", "Download PDF")  # Button to download PDF
    )
  )
)
