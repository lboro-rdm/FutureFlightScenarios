library(shiny)
library(shinyjs)
library(bslib)

ui <- fluidPage(
  useShinyjs(),
  tags$html(lang = "en"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  navbarPage(
    title = "Future Flight Scenario Toolkit",
    
    # Tab 1: Prepare
    tabPanel("About",
             fluidPage(
               h1("Welcome to the Future of Flight"),
               p("Delivery drones, flying taxis, or electric-powered aircraft for regional aviation could all be part of how the future of flight evolves."),
               p(),
               p(strong("Are you ready for it?")),
               p(),
               p("By working through the steps on this site, you can imagine a different world, and how you might respond to it."),
               p("Perhaps you might get your company and team to imagine different futures. It would be a great planning session to discuss what you might come up with"),
               p("Get started by clicking on the 'Imagine your future' tab.")
             )),
    
    # Tab 2: Imagine
    tabPanel("Imagine your future",
             fluidPage(
               h1("Imagine your future"),
               p("Twenty-five years from now, the world will look very different. In this section, you can imagine that world and create a possible response."),
               p("Below is a step-by-step process that will guide you."),
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
                                             label = "Choose two that reflect the trends you believe will shape the future of your organisation:",
                                             choices = baseline_trends
                                           )
                                      ),
                                      card(class = "card-box",
                                           h3("Industry drivers"),
                                           p("Driver are factors that can significantly impact the outcomes of future scenarios, such as changes in technological, environmental, or organisational contexts."),
                                           checkboxGroupInput(
                                             "drivers_selected",
                                             label = "Choose two drivers that may have significant impact on your organisation:",
                                             choices = drivers
                                           )
                                      )
                                    ),
                                    actionButton("next1", "Next")
                           ),
                           
                           tabPanel("Step 2",
                                    h2("Step 2: Write alternative drivers"),
                                    p("Alternative drivers introduce variability into your scenarios. Write the opposite or alternative directions to the drivers you have selected in Step 1."),
                                    p("Example: If selected SCENARIO DRIVER is “More people living in urban areas.” ALTERNATIVE DRIVER could be “More people living sub-urbs” OR “Growth in connected satellite towns.”"),
                                    uiOutput("alternative_drivers_ui"),
                                    actionButton("back1", "Back"),
                                    actionButton("next2", "Next")
                           ),
                           
                           tabPanel("Step 3",
                                    h2("Step 3: Write your four scenarios"),
                                    p("Now that you have selected your trends and drivers, and imagined alternative drivers, create a response to that future world."),
                                    p("Write brief descriptions for each scenario (2 – 3 sentences). Please try to capture the essence and key characteristics of each scenario."),
                                    uiOutput("scenario_ui"),
                                    actionButton("back2", "Back"),
                                    actionButton("next3", "Next")
                           ),
                           
                           tabPanel("Step 4",
                                    h2("Step 4: Review and download the PDF"),
                                    p("Below, you will see your four imagined futures. Feel free to go back to previous tabs to make changes. Once you are happy with them, download the pdf as a reference."),
                                    uiOutput("scenario_matrix_ui"),
                                    actionButton("back3", "Back"),
                                    downloadButton("downloadPDF", "Download PDF"),
                                    downloadButton("downloadExample", "Download Example PDF")
                           )
               )
             )
    ),
    
    # Tab 3: Acknowledge
    tabPanel("Acknowledgements",
             fluidPage(
               h1("Acknowledgements"),
               p("This app was based on the Future Flight Scenario Toolkit, which can be found at:"),
               tags$ul(
                 tags$li(
                   "Liao, Chenyi; Parker, Christopher J.; Parkhurst, Graham (2024). Future Flight Scenario Toolkit. Loughborough University. Online resource. ",
                   tags$a("https://doi.org/10.17028/rd.lboro.25671153", href = "https://doi.org/10.17028/rd.lboro.25671153", target = "_blank"),
                   " © CC-BY-NC 4.0."
                 )
               ),
               p("This app was created in R, with the following packages:"),
               tags$ul(
                 tags$li("Attali D (2021). ", tags$em("shinyjs: Easily Improve the User Experience of Your Shiny Apps in Seconds"), 
                         ". R package version 2.1.0, ", tags$a(href="https://CRAN.R-project.org/package=shinyjs", "https://CRAN.R-project.org/package=shinyjs"), "."),
                 tags$li("Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J, McPherson J, Dipert A, Borges B (2024). ", 
                         tags$em("shiny: Web Application Framework for R"), 
                         ". R package version 1.9.1, ", tags$a(href="https://CRAN.R-project.org/package=shiny", "https://CRAN.R-project.org/package=shiny"), "."),
                 tags$li("Sievert C, Cheng J, Aden-Buie G (2024). ", tags$em("bslib: Custom 'Bootstrap' 'Sass' Themes for 'shiny' and 'rmarkdown'"), 
                         ". R package version 0.8.0, ", tags$a(href="https://CRAN.R-project.org/package=bslib", "https://CRAN.R-project.org/package=bslib"), ".")
               ),
               p(),
               p("It has been created and maintained by Lara Skelly for Loughborough University. The code can be found on ", 
                 a("GitHub", href = "https://github.com/lboro-rdm/FutureFlightScenarios.git", target = "_blank")),
               p(),
               p("To cite this app:"),
               tags$ul(
                 tags$li(
                   "Skelly, Lara (2024). Future Flight Scenarios: a R/Shiny app that prompts imagining a future where flight is very different. Loughborough University. Online resource. ",
                   tags$a("https://doi.org/10.17028/rd.lboro.27852363", href = "https://doi.org/10.17028/rd.lboro.27852363", target = "_blank"),
                   " © MIT."
                 )
               ),
               p(),
               p("Throughout the creation of this Shiny app, ChatGPT acted as a conversation partner and a code checker."),
               p(),
               p("This app was funded by the ", a("Arts Council England Develop Your Creative Practice Grant", href = "https://www.artscouncil.org.uk/dycp")),
               tags$img(src = "logo.png", width = "300px", alt = "Arts Council England logo")
             )
             )
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