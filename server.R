library(shiny)
library(shinyjs)

server <- function(input, output, session) {
  # Hide all steps except Step 1 at the start
  observe({
    shinyjs::hide(selector = "ul.nav.nav-tabs li a[data-value='Step 2']")
    shinyjs::hide(selector = "ul.nav.nav-tabs li a[data-value='Step 3']")
    shinyjs::hide(selector = "ul.nav.nav-tabs li a[data-value='Step 4']")
    shinyjs::disable("next1")  # Disable Next button at start
    shinyjs::disable("next2")  # Disable Next button for Step 2
  })
  
  # Function to check if selections are valid
  validate_selections <- function() {
    length(input$baseline_trends_selected) == 2 && length(input$drivers_selected) == 2
  }
  
  # Observe changes in selections and enable/disable Next button (Step 1)
  observe({
    if (validate_selections()) {
      shinyjs::enable("next1")
    } else {
      shinyjs::disable("next1")
    }
  })
  
  # Restrict to only 2 selections in baseline trends
  observeEvent(input$baseline_trends_selected, {
    selected <- input$baseline_trends_selected
    if (length(selected) > 2) {
      updateCheckboxGroupInput(session, "baseline_trends_selected", selected = selected[1:2])
    }
  })
  
  # Restrict to only 2 selections in industry drivers
  observeEvent(input$drivers_selected, {
    selected <- input$drivers_selected
    if (length(selected) > 2) {
      updateCheckboxGroupInput(session, "drivers_selected", selected = selected[1:2])
    }
  })
  
  # Generate alternative drivers UI
  output$alternative_drivers_ui <- renderUI({
    req(input$drivers_selected)
    
    selected_drivers <- input$drivers_selected
    fluidRow(
      lapply(seq_along(selected_drivers), function(i) {
        column(6,
               card(class = "card-box",
                    h3(paste("Driver selected:", selected_drivers[i])),
                    textInput(inputId = paste0("alternative_driver_", i), label = "Write an alternative driver:")
               )
        )
      })
    )
  })
  
  # Observe text inputs and enable Next button on Step 2
  observe({
    req(input$drivers_selected)
    
    all_filled <- all(sapply(seq_along(input$drivers_selected), function(i) {
      !is.null(input[[paste0("alternative_driver_", i)]]) && input[[paste0("alternative_driver_", i)]] != ""
    }))
    
    if (all_filled) {
      shinyjs::enable("next2")
    } else {
      shinyjs::disable("next2")
    }
  })
  
  output$scenario_ui <- renderUI({
    req(input$baseline_trends_selected, input$drivers_selected)
    
    selected_baseline_trends <- input$baseline_trends_selected
    selected_drivers <- input$drivers_selected
    alternative_drivers <- sapply(seq_along(selected_drivers), function(i) {
      input[[paste0("alternative_driver_", i)]]
    })
    
    scenarios <- lapply(1:4, function(scenario_number) {
      driver_1 <- switch(scenario_number,
                         selected_drivers[1],  # Scenario 1
                         selected_drivers[1],  # Scenario 2
                         alternative_drivers[1],  # Scenario 3
                         alternative_drivers[1])  # Scenario 4
      
      driver_2 <- switch(scenario_number,
                         selected_drivers[2],  # Scenario 1
                         alternative_drivers[2],  # Scenario 2
                         selected_drivers[2],  # Scenario 3
                         alternative_drivers[2])  # Scenario 4
      
      fluidRow(
        h3(paste("Scenario", scenario_number)),
        layout_columns(
          card(class = "card-box", 
               h4("Baseline trends"),
               p(selected_baseline_trends[1]),  
               p(selected_baseline_trends[2])  
               
          ),
          card(class = "card-box", 
               h4("Driver 1"),
               p(driver_1)
                         ),
          card(class = "card-box", 
               h4("Driver 2"),
               p(driver_2)  
               
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
    
    do.call(fluidRow, scenarios)
  })
  
  # Observe scenario inputs and enable Next button on Step 3
  observe({
    req(input$drivers_selected)  # Ensure drivers are selected first
    
    all_scenarios_filled <- all(sapply(1:4, function(scenario_number) {
      !is.null(input[[paste0("scenario_input_", scenario_number)]]) && 
        input[[paste0("scenario_input_", scenario_number)]] != ""
    }))
    
    if (all_scenarios_filled) {
      shinyjs::enable("next3")
    } else {
      shinyjs::disable("next3")
    }
  })
  
  output$scenario_matrix_ui <- renderUI({
    req(input$drivers_selected, 
        input$alternative_driver_1, 
        input$alternative_driver_2, 
        input$scenario_input_1, 
        input$scenario_input_2, 
        input$scenario_input_3, 
        input$scenario_input_4)
    
    selected_drivers <- input$drivers_selected
    alternative_drivers <- c(input$alternative_driver_1, input$alternative_driver_2)
    
    tagList(
      # First row: Empty space + Driver 1 label + Empty space
      fluidRow(
        column(4, ""),  
        column(4, 
               p(strong("Driver 1")),
               p(selected_drivers[1])
               ),  
        column(4, "")   
      ),
      
      # Second row: Driver 2 label + Scenario grid + Alternative Driver 2 label
      fluidRow(
        column(4, 
               p(strong("Driver 2")),
               p(selected_drivers[2])
               ),  
        column(4, div(style = "border: 2px solid black; padding: 20px; text-align: center;",
                      fluidRow(
                        column(6, p(paste0("Scenario 1: ", input$scenario_input_1))),
                        column(6, p(paste0("Scenario 2: ", input$scenario_input_2)))
                      ),
                      fluidRow(
                        column(6, p(paste0("Scenario 3: ", input$scenario_input_3))),
                        column(6, p(paste0("Scenario 4: ", input$scenario_input_4)))
                      )
        )),
        column(4, 
               p(strong("Alternative Driver 2")),
               p(alternative_drivers[2])
               )  
      ),
      
      # Third row: Empty space + Alternative Driver 1 label + Empty space
      fluidRow(
        column(4, ""),  
        column(4, 
               p(),
               p(strong("Alternative Driver 1")),
               p(alternative_drivers[1])
               ),  
        column(4, "")  
      )
    )
  })
  
  output$downloadPDF <- downloadHandler(
    filename = function() { paste("Future_Flight_Scenario_Report-", Sys.Date(), ".pdf", sep = "") },
    
    content = function(file) {
      # Ensure inputs exist before proceeding
      req(input$baseline_trends_selected, input$drivers_selected,
          input$scenario_input_1, input$scenario_input_2,
          input$scenario_input_3, input$scenario_input_4,
          input$alternative_driver_1, input$alternative_driver_2)
      
      # Define selections explicitly
      selected_baselines <- input$baseline_trends_selected
      selected_drivers <- input$drivers_selected
      alternative_drivers <- c(input$alternative_driver_1, input$alternative_driver_2)
      
      # Temporary file path for the RMarkdown document
      tempReport <- file.path(tempdir(), "report.Rmd")
      
      # Copy the Rmd template to the temporary location
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      # Render the RMarkdown document with the correct parameters
      rmarkdown::render(tempReport, output_file = file,
                        params = list(
                          baseline1 = selected_baselines[1], 
                          baseline2 = selected_baselines[2],
                          driverTop = selected_drivers[1],
                          driverLeft = selected_drivers[2],
                          scenario1 = input$scenario_input_1,
                          scenario2 = input$scenario_input_2,
                          scenario3 = input$scenario_input_3,
                          scenario4 = input$scenario_input_4,
                          altDriverRight = alternative_drivers[2],
                          altDriverBottom = alternative_drivers[1]
                        ),
                        envir = new.env(parent = globalenv())
      )
    }
  )
  
  
  # Navigation with Next/Back buttons and showing tabs dynamically
  observeEvent(input$next1, {
    shinyjs::show(selector = "ul.nav.nav-tabs li a[data-value='Step 2']")
    updateTabsetPanel(session, "imagine_tabs", selected = "Step 2")
  })
  
  observeEvent(input$back1, {
    updateTabsetPanel(session, "imagine_tabs", selected = "Step 1")
  })
  
  observeEvent(input$next2, {
    shinyjs::show(selector = "ul.nav.nav-tabs li a[data-value='Step 3']")
    updateTabsetPanel(session, "imagine_tabs", selected = "Step 3")
  })
  
  observeEvent(input$back2, {
    updateTabsetPanel(session, "imagine_tabs", selected = "Step 2")
  })
  
  observeEvent(input$next3, {
    shinyjs::show(selector = "ul.nav.nav-tabs li a[data-value='Step 4']")
    updateTabsetPanel(session, "imagine_tabs", selected = "Step 4")
  })
  
  observeEvent(input$back3, {
    updateTabsetPanel(session, "imagine_tabs", selected = "Step 3")
  })
}
