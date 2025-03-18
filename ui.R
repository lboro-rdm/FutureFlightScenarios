library(shiny)
library(shinyjs)
library(bslib)

ui <- fluidPage(
  useShinyjs(),
  navbarPage(
    title = "Future Flight Scenario Toolkit",
    
    # Tab 1: Prepare
    tabPanel("About"),
    
    # Tab 2: Imagine
    tabPanel("Imagine your future",
             fluidPage(
               h1("Imagine your future"),
               p("Placeholder for general instructions"),
               hr(),
               
               tabsetPanel(id = "imagine_tabs",
                           tabPanel("Step 1",
                                    h2("Step 1: Select trends and drivers"),
                                    layout_columns(
                                      card(class = "card-box",
                                           h3("Baseline trends"),
                                           p("Baseline trends capture the broader societal, technological, economic, or environmental trends in the envisioned future of 2050."),
                                           checkboxGroupInput(
                                             "baseline_trends_selected",
                                             label = "Choose two that are relevant for your industry:",
                                             choices = baseline_trends
                                           )
                                      ),
                                      card(class = "card-box",
                                           h3("Industry drivers"),
                                           p("Placeholder for driver text."),
                                           checkboxGroupInput(
                                             "drivers_selected",
                                             label = "Choose two drivers that you would like to work with:",
                                             choices = drivers
                                           )
                                      )
                                    ),
                                    actionButton("next1", "Next")
                           ),
                           
                           tabPanel("Step 2",
                                    h2("Step 2: Write alternative drivers"),
                                    p("Once you've selected the drivers in step 1, imagine what the alternative would be."),
                                    uiOutput("alternative_drivers_ui"),
                                    actionButton("back1", "Back"),
                                    actionButton("next2", "Next")
                           ),
                           
                           tabPanel("Step 3",
                                    h2("Step 3: Write your four scenarios"),
                                    p("Placeholder for instruction"),
                                    uiOutput("scenario_ui"),
                                    actionButton("back2", "Back"),
                                    actionButton("next3", "Next")
                           ),
                           
                           tabPanel("Step 4",
                                    h2("Step 4: Download the PDF"),
                                    p("Placeholder for instruction"),
                                    uiOutput("scenario_matrix_ui"),
                                    actionButton("back3", "Back"),
                                    downloadButton("downloadPDF", "Download PDF")
                           )
               )
             )
    ),
    
    # Tab 3: Acknowledge
    tabPanel("Acknowledgements")
  ),
  
  # Footer
  tags$div(class = "footer", 
           fluidRow(
             column(12, 
                    tags$a(href = 'https://doi.org/10.17028/rd.lboro.28525481', 
                           "Accessibility Statement",
                           style = "color: #ffffff !important; text-decoration: none;")
             )
           ),
           style = "background-color: #333; padding: 10px; margin-top: 30px; text-align: center;"
  )
)