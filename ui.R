library(shiny)
library(rmarkdown)
library(shinyjs)
library(bslib)

ui <- tags$html(
  lang = "en",
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),           
  navbarPage(
    useShinyjs(),
    title = "Future Flight Scenario Toolkit",
    
    # Tab 1: Prepare ----------------------------------------------------------
    
    tabPanel("Prepare"),
    
    # Tab 2: Imagine ----------------------------------------------------------
    
    tabPanel("Imagine",
             fluidPage(
               h1("Imagine your future"),
               p("Placeholder for general instructions"),
               hr(),
               
               fluidRow(
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
               ),
               hr(),
               
               fluidRow(
                 h2("Step 2: Write alternative drivers"),
                 p("Once you've selected the drivers in step 1, imagine what the alternative would be."),
                 uiOutput("alternative_drivers_ui")
               ),
               hr(),
               
               fluidRow(
                 h2("Step 3: Write your four scenarios"),
                 p("Place holder for instruction"),
                 
                 h3("Scenario 1"),
                 uiOutput("scenario_ui"),
                 
                 h3("Scenario 2"),
                 layout_columns(
                   card(class = "card-box", p("Baseline trends")),
                   card(class = "card-box", p("Driver 1")),
                   card(class = "card-box", p("Alternative driver 2"))
                 ),
                 layout_columns(
                   card(class = "card-box",
                        p("placeholder for textbox input")
                   )
                 ),
                 
                 h3("Scenario 3"),
                 layout_columns(
                   card(class = "card-box", p("Baseline trends")),
                   card(class = "card-box", p("Alternative driver 1")),
                   card(class = "card-box", p("Driver 2"))
                 ),
                 layout_columns(
                   card(class = "card-box",
                        p("placeholder for textbox input")
                   )
                 ),
                 
                 h3("Scenario 4"),
                 layout_columns(
                   card(class = "card-box", p("Baseline trends")),
                   card(class = "card-box", p("Alternative driver 1")),
                   card(class = "card-box", p("Alternative driver 2"))
                 ),
                 layout_columns(
                   card(class = "card-box",
                        p("placeholder for textbox input")
                   )
                 )
               ),
               hr(),
               
               fluidRow(
                 h2("Step 4: Download the pdf"),
                 p("Place holder for instruction"),
                 layout_columns(
                   card(class = "card-box",
                        card_header("Download pdf"),
                        p("Place holder for pdf download button?")
                   )
                 )
               ),
               hr()
             )
    ),
    
    # Tab 3: Acknowledge ------------------------------------------------------
    
    tabPanel("Acknowledge")
  ),
  
  # Footer ------------------------------------------------------------------
  
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
