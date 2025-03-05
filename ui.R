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
                 h2("Step 1: Select baseline trends"),
                 p("Baseline trends capture the broader societal, technological, economic, or environmental trends in the envisioned future of 2050."),
                 p("Choose two that are relevant for your industry."),
                 layout_columns(
                   card(class = "card-box",
                        card_header("Baseline trend 1"),
                        selectInput("baseline_trend_1", "Select Baseline Trend 1:",
                                    choices = baseline_trends, 
                                    selected = NULL)  # Set default selection
                   ),
                   card(class = "card-box",
                        card_header("Baseline trend 2"),
                        selectInput("baseline_trend_2", "Select Baseline Trend 2:",
                                    choices = baseline_trends, 
                                    selected = NULL)  # Set default selection
                   )
                 )
               ),
               hr(),
               
               fluidRow(
                 h2("Step 2: Select industry drivers"),
                 p("Place holder for instruction"),
                 layout_columns(
                   card(class = "card-box",
                        card_header("Driver 1"),
                        p("Place holder for dropdown?")
                   ),
                   card(class = "card-box",
                        card_header("Driver 2"),
                        p("Placeholder for dropdown?")
                   )
                 )
               ),
               hr(),
               
               fluidRow(
                 h2("Step 3: Write alternative drivers"),
                 p("Place holder for instruction"),
                 layout_columns(
                   card(class = "card-box",
                        card_header("Alternative driver 1"),
                        p("Place holder for text box?")
                   ),
                   card(class = "card-box",
                        card_header("Alternative driver 2"),  # Fixed typo here too
                        p("Placeholder for text box?")
                   )
                 )
               ),
               hr(),
               
               fluidRow(
                 h2("Step 4: Write your four scenarios"),
                 p("Place holder for instruction"),
                 
                 h3("Scenario 1"),
                 layout_columns(
                   card(class = "card-box", p("Baseline trends")),
                   card(class = "card-box", p("Driver 1")),
                   card(class = "card-box", p("Driver 2"))
                 ),
                 layout_columns(
                   card(class = "card-box",
                        p("placeholder for textbox input")
                        )
                 ),
                 
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
                 h2("Step 5: Download the pdf"),
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
