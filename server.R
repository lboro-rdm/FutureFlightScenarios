server <- function(input, output, session) {
  
  observeEvent(input$baseline_trends_selected, {
    selected <- input$baseline_trends_selected
    
    # Allow only 2 selections
    if (length(selected) > 2) {
      # Remove the last selected option
      updateCheckboxGroupInput(session, "baseline_trends_selected", selected = selected[1:2])
    }
  })
  
  observeEvent(input$drivers_selected, {
    selected <- input$drivers_selected
    
    # Allow only 2 selections
    if (length(selected) > 2) {
      # Remove the last selected option
      updateCheckboxGroupInput(session, "drivers_selected", selected = selected[1:2])
    }
  })
  
  output$alternative_drivers_ui <- renderUI({
    req(input$drivers_selected)  # Ensure drivers are selected
    
    selected_drivers <- input$drivers_selected
    fluidRow(
      lapply(1:length(selected_drivers), function(i) {
        column(6,  # Each card takes half the width
               card(class = "card-box",
                    h3(paste("Driver selected:", selected_drivers[i])),
                    textInput(inputId = paste0("alternative_driver_", i), label = "Write an alternative driver:")
               )
        )
      })
    )
    
  })
  
  output$scenario_ui <- renderUI({
    req(input$baseline_trends_selected)  # Ensure baseline trends are selected
    req(input$drivers_selected)           # Ensure drivers are selected
    
    selected_baseline_trends <- input$baseline_trends_selected
    selected_drivers <- input$drivers_selected
    
    scenarios <- lapply(1:4, function(scenario_number) {
      fluidRow(
        h3(paste("Scenario", scenario_number)),
        layout_columns(
          card(class = "card-box", 
               p(selected_baseline_trends[1]),  # First selected baseline trend
               h4("Baseline trends")
          ),
          card(class = "card-box", 
               p(selected_drivers[1]),  # First selected driver
               h4("Driver 1")
          ),
          card(class = "card-box", 
               p(selected_drivers[2]),  # Second selected driver
               h4("Driver 2")
          )
        ),
        layout_columns(
          card(class = "card-box",
               textAreaInput(inputId = paste0("scenario_input_", scenario_number), 
                             label = "Write your scenario:", 
                             rows = 3)
          )
        )
      )
    })
    
    do.call(fluidRow, scenarios)  # Combine all scenarios into a single fluidRow
  })
  
}