library(shiny)
library(dplyr)
library(rmarkdown)
library(shinyjs)

# Define server logic
server <- function(input, output, session) {
  
  # Predefined baseline trends and scenario drivers
  baseline_trends <- c(
    "More geopolitical wars, disrupting the supply of key materials and components",
    "An increased use of drones for terrorism and weaponization",
    "Significant changes in weather (e.g., wind patterns and extreme weather)",
    "More older adults in society",
    "Fewer physical shops and more online shopping",
    "Water/ food scarcity due to climate change",
    "Prioritise drone delivery to emergency and medical services",
    "An increased awareness of sensory pollution (e.g., light and sound)"
  )
  
  scenario_drivers <- c(
    "Public sees the increased convenience of Future Flight technologies",
    "A shift to large corporations creating monopolies",
    "An increased concern of privacy near homes or public spaces",
    "Businesses focus more on society and the environment",
    "Increased public awareness and buy into Future Flight",
    "More people living in urban areas",
    "Increased congestion on the roads",
    "More public acceptance of low flying drones",
    "Decrease in wildlife (i.e. bees and birds) because of Future Flight technologies",
    "Widespread adoption of autonomous cars on roads",
    "Retail prefers drone delivery to human delivery",
    "A reduction in availability of materials critical to Future Flight batteries",
    "The airspace in public areas becomes crowded",
    "Scarce labour for freight delivery"
  )
  
  # Randomly select baseline trends and scenario drivers
  selected_baselines <- sample(baseline_trends, 2)
  selected_drivers <- sample(scenario_drivers, 2)
  
  # Display selected baseline trends and scenario drivers
  output$baseline1 <- renderText({ selected_baselines[1] })
  output$baseline2 <- renderText({ selected_baselines[2] })
  output$driverRight <- renderText({ selected_drivers[1] })
  output$driverTop <- renderText({ selected_drivers[2] })
  
  # Create the 4-quadrant space plot (placeholder)
  output$scenarioPlot <- renderPlot({
    plot(1:4, 1:4, type = "n", axes = FALSE, xlab = "", ylab = "")
    rect(1, 1, 2, 2, col = "lightblue")
    rect(2, 1, 3, 2, col = "lightgreen")
    rect(1, 2, 2, 3, col = "lightcoral")
    rect(2, 2, 3, 3, col = "lightyellow")
    
    # Add text for the user-inputted scenarios
    if (input$quad1 != "") {
      text(1.5, 2.5, input$quad1, cex = 1.2)  # Top Left
    }
    if (input$quad2 != "") {
      text(2.5, 2.5, input$quad2, cex = 1.2)  # Top Right
    }
    if (input$quad3 != "") {
      text(1.5, 1.5, input$quad3, cex = 1.2)  # Bottom Left
    }
    if (input$quad4 != "") {
      text(2.5, 1.5, input$quad4, cex = 1.2)  # Bottom Right
    }
  })
  
  # Generate PDF for download
  output$downloadPDF <- downloadHandler(
    filename = function() {
      paste0("scenario_planning_report_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      # Create a temporary Rmarkdown file
      rmd_content <- paste(
        "---",
        "title: 'Scenario Planning Report'",
        "output: pdf_document",
        "---",
        "",
        "<h2>Scenario Planning Report</h2>",
        "<p><strong>Baseline Trends:</strong></p>",
        "<ul><li>", selected_baselines[1], "</li><li>", selected_baselines[2], "</li></ul>",
        
        "<p><strong>Scenario Drivers:</strong></p>",
        "<ul><li>Left: ", selected_drivers[1], "</li><li>Bottom: ", selected_drivers[2], "</li></ul>",
        
        "<p><strong>Scenario Descriptions:</strong></p>",
        "<ul>",
        "<li><strong>Top Left:</strong> ", input$quad1, "</li>",
        "<li><strong>Top Right:</strong> ", input$quad2, "</li>",
        "<li><strong>Bottom Left:</strong> ", input$quad3, "</li>",
        "<li><strong>Bottom Right:</strong> ", input$quad4, "</li>",
        "</ul>"
      )
      
      # Save this content as an Rmd file
      rmd_file <- tempfile(fileext = ".Rmd")
      writeLines(rmd_content, con = rmd_file)
      
      # Render the Rmd file to PDF
      render(rmd_file, output_file = file, output_format = "pdf_document")
      
      # Clean up the temporary Rmd file
      unlink(rmd_file)
    }
  )
}
