library(shiny)
library(rmarkdown)

# Define the server function
server <- function(input, output, session) {
  
  # Create select inputs for baseline trends
  output$baseline_trend_1 <- renderUI({
    selectInput("baseline_trend_1", 
                "Select Baseline Trend 1", 
                choices = baseline_trends())
  })
  
  output$baseline_trend_2 <- renderUI({
    selectInput("baseline_trend_2", 
                "Select Baseline Trend 2", 
                choices = baseline_trends())
  })
  
  # Observe selected baseline trends
  observeEvent(input$baseline_trend_1, {
    selected_trend_1 <- input$baseline_trend_1
    print(paste("Selected Baseline Trend 1:", selected_trend_1))
  })
  
  observeEvent(input$baseline_trend_2, {
    selected_trend_2 <- input$baseline_trend_2
    print(paste("Selected Baseline Trend 2:", selected_trend_2))
  })
  
  # Example: Render outputs based on selections (if needed)
  output$summary <- renderText({
    paste("You selected:",
          input$baseline_trend_1, "and", input$baseline_trend_2)
  })
}