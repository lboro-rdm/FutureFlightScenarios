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
  
  
  # Define PDF download handler
  output$downloadPDF <- downloadHandler(
    filename = function() {
      paste("scenario_toolkit_", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      # Create a temporary .Rmd file for the report content
      tempReport <- tempfile(fileext = ".Rmd")
      
      # Write R Markdown content for the report
      reportContent <- '
      ---
      title: "Future Flight Scenario Toolkit"
      output: pdf_document
      ---

      # Baseline Trends
      - Baseline 1: `r input$baseline1`
      - Baseline 2: `r input$baseline2`

      # Scenario Matrix
      
      **Scenario driver (top):** `r input$driverTop`
      
      ```{=latex}
      \vspace{1em}
      ```

      |                  | **Scenario 1**             | **Scenario 2**             |  
      |------------------|----------------------------|----------------------------|  
      | **Alternative Driver (left)** | `r input$scenario1` | `r input$scenario2` |  
      |                  | **Scenario 3**             | **Scenario 4**             |  
      | **Alternative Driver (bottom)** | `r input$scenario3` | `r input$scenario4` |  

      ```{=latex}
      \vspace{1em}
      ```
      
      **Scenario driver (right):** `r input$driverRight`

      - **Alternative Driver (left):** `r input$altDriverLeft`
      - **Alternative Driver (bottom):** `r input$altDriverBottom`
      '
      
      # Write the report content to the temporary Rmd file
      writeLines(reportContent, tempReport)
      
      # Render the R Markdown document to a PDF file
      tryCatch(
        {
          rmarkdown::render(tempReport, output_file = file, output_format = "pdf_document")
        },
        error = function(e) {
          showNotification("Failed to generate PDF. Please check your LaTeX installation.", type = "error")
          stop("PDF rendering failed.")
        }
      )
    }
  )
}
