library(shiny)
library(rmarkdown)

server <- function(input, output, session) {
  
  # Define baseline trends and scenario drivers
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
  
  # Display selected baseline trends and scenario drivers in the UI
  output$baseline1 <- renderText({ selected_baselines[1] })
  output$baseline2 <- renderText({ selected_baselines[2] })
  output$driverRight <- renderText({ selected_drivers[1] })
  output$driverTop <- renderText({ selected_drivers[2] })
  
  # PDF download handler
  output$downloadPDF <- downloadHandler(
    filename = function() { paste("Future_Flight_Scenario_Report", Sys.Date(), ".pdf", sep = "") },
    content = function(file) {
      # Temporary file path for the RMarkdown document
      tempReport <- file.path(tempdir(), "report.Rmd")
      
      # Copy the Rmd template to the temporary location
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      # Render the RMarkdown document with parameters
      rmarkdown::render(tempReport, output_file = file,
                        params = list(
                          baseline1 = selected_baselines[1], 
                          baseline2 = selected_baselines[2],
                          driverTop = selected_drivers[2],
                          driverRight = selected_drivers[1],
                          scenario1 = input$scenario1,
                          scenario2 = input$scenario2,
                          scenario3 = input$scenario3,
                          scenario4 = input$scenario4,
                          altDriverLeft = input$altDriverLeft,
                          altDriverBottom = input$altDriverBottom
                        ),
                        envir = new.env(parent = globalenv())
      )
    }
  )
}
