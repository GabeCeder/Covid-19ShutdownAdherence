
# Load the necessary libraries

library(shiny)
library(tidyverse)
library(dplyr)
library(readr)
library(janitor)
library(ggthemes)
library(gt)
library(magrittr)
library(stringr)
library(infer)
library(readxl)
library(viridis)  
library(RCurl)
library(gifski)
library(gganimate)
library(shinythemes)
library(shinyWidgets)
library(tidycensus)

# Census API Key

Sys.getenv("CENSUS_API_KEY")

# Import the county dataset

 county_data <- read_rds("county_data.rds")

# Define UI for the application

ui <- fluidPage(
    
# Set background image to an image of Covid-19  
    
    setBackgroundImage(src = "https://fenwayhealth.org/wp-content/uploads/covid-19-2-1140x450-1.jpg"),
    
# Change theme to cosmo using shinytheme
    
    theme = shinytheme("cosmo"),
    
# Add application title

    h1(strong("Does Partisan Leaning Affect Covid-19 Shutdown Adherence?", style = "color: white"), align = "center"),

# Add subtitle

    h2("Exploring County-Level Data", style = "color:white", align = "center"),

# Add name 

    h3(strong("by Gabe Cederberg", style = "color:white"), align = "center"),

# Create the navigation bar, while making the title blank

     navbarPage("",
#            
#            # Create a tab to explore the case totals in different states across the US.
#            
            tabPanel("Explore the Dataset",
                     
                     sidebarLayout(
                         
                         sidebarPanel(
                             
                             # Create a selectInput for the user to select which states to view 
                             
                             selectInput(inputId = "select_state",
                                         label = "Select which states to observe",
                                         choices = c("Alabama",
#                                                          "Alaska",
                                                     "Arizona",
                                                     "Arkansas",
                                                     "California",
                                                     "Colorado",
                                                     "Connecticut",
                                                     "Delaware",
                                                     "Florida",
                                                     "Georgia",
#                                                           "Hawaii",
                                                     "Idaho",
                                                     "Illinois",
                                                     "Indiana",
                                                     "Iowa",
                                                     "Kansas",
                                                     "Kentucky",
                                                     "Louisiana",
                                                     "Maine",
                                                     "Maryland",
                                                     "Massachusetts",
                                                     "Michigan",
                                                     "Minnesota",
                                                     "Mississippi",
                                                     "Missouri",
                                                     "Montana",
                                                     "Nebraska",
                                                     "Nevada",
                                                     "New Hampshire",
                                                     "New Jersey",
                                                     "New Mexico",
                                                     "New York",
                                                     "North Carolina",
                                                     "North Dakota",
                                                     "Ohio",
                                                     "Oklahoma",
                                                     "Oregon",
                                                     "Pennsylvania",
                                                     "Rhode Island",
                                                     "South Carolina",
                                                     "South Dakota",
                                                     "Tennessee",
                                                     "Texas",
                                                     "Utah",
                                                     "Vermont",
                                                     "Virginia",
                                                     "Washington",
                                                     "West Virginia",
                                                     "Wisconsin",
                                                     "Wyoming"),
                                         multiple = TRUE,
                                         selected = "Louisiana"),
                             
                             checkboxInput(inputId = "select_view",
                                           label = "View Cases per Capita",
                                           value = TRUE)
                         ),
                         
                         mainPanel(width = 6,
                                   h2(strong(" Total Cases in Each County ", style = "background-color: white", align = "center")),
                                   
                                   # Output the plot comparing three types of wins to
                                   # the finish place of a contestant
                                   
                                   plotOutput("state_cases"),
                                   br()
                         ),
                     )
            ),

            tabPanel("Research Process",
                     
                     fluidRow(
                         
                         column(4,
                                
                                wellPanel(
                                    wellPanel(
                                        h3(strong("The goal of this project is to explore whether counties that 
                                   lean Republican or Democrat responded differently to covid-19 
                                   shutdown orders.", align = "center"))
                                    )
                                    # ,
                                    # 
                                    # br(),
                                    # includeHTML("total_both.html"),
                                    # 
                                    # 
                                    # h3("")
                                )
                         ),
                         
                         column(6,
                                
                                wellPanel(
                                    h2(strong("Scope")),
                                    h4("As case totals grew exponentially over the month of March, Governors 
                                    across the country put in place increasingly stringent restrictions on 
                                    business activity and movement outside of the home."),
                                    h4("In this project, I look at county-level data in three contiguous states 
                                    that implemented lockdowns during the third week of March: Connecticut, New Jersey,
                                       and New York."),
                                    
                                    h3(strong("The Data")),
                                    h4("The first dataset for this analysis contains the cumulative covid-19 case 
                                    totals for each county. This was compiled by The New York Times."),
                                    h4("The second dataset is a county-level index that quantifies people's mobility 
                                    (i.e. how much they are going about their normal activities outside of the home). 
                                    This dataset comes from Cuebiq, a consumer analytics firm that tracks the 
                                    movement of 15 million cell phone users around the country on a daily basis."),
                                    h4("Note: The Cuebiq Mobility Index (CMI) is defined as the base 10 logarithm of 
                                       the distance between the opposing corners of a square box drawn around the 
                                       coordinates observed for an individual each day. Each county's CMI is the median
                                       CMI for all individuals in the county, and the values can be interpreted as"),
                                    h4("5 - 100 km;  4 - 10 km;  3 - 1 km;  2 - 100m;  1 - 10m"),
                                    h4("I defined a county's 'change in mobility' as the CMI for the week of March 
                                       30th minus the CMI for the week of January 6th."),
                                    h4("Then, I combined the NYT and Cuebiq datasets with county-level voting and 
                                    demographic data from the MIT Election Lab. I defined the partisan leaning of a 
                                       county based on the county's 2016 Presidential election results:"),
                                    h4("Hillary's vote share / (Hillary's vote share + Trump's vote share)"),
                                    
                                    h3(strong("Analysis")),
                                    h4("To determine the true relationship between the partisan leaning of a county
                                       and the change in mobility after the government-ordered shutdowns, I ran a 
                                       linear regresion analysis between the two variables, while also controlling 
                                       for several county-level factors."),
                                    h4("These factors included the number of covid-19 cases (in thousands), the median 
                                    household income (in thousands of dollars), the population per square mile (in
                                    thousands), the percent of the population 65 and older, and the percent of the
                                    population without a high school degree.")
                                    )
                                
                                )
                     )
            ),


            tabPanel("Findings",
                     sidebarLayout(
                         sidebarPanel(
                             width = 6,
                             h2(strong("Findings"), align = "center"),
                             h3("The linear regression analysis showed that the partisan political leaning of 
                             a county significantly impacted the degree to which people reduced their mobility 
                             following covid-19 shutdown orders in New York, New Jersey, and Connecticut."),
                             
                      #       br(),
                             h3(strong("Specifically, a one percentage point increase in a county's Democratic leaning 
                             is associated with a 1.73 point reduction in the county's Cuebiq Mobility Index 
                             between the week of January 6th, 2020 and the week of March 30th.")),
                             
                       #      br(),
                             h3("Not only was partisan leaning the most statistically significant factor, it 
                                was also the factor with the greatest coefficient. This suggests that people's 
                                partisan leanings had a substantial impact on their ability and/or willingness
                                to follow the covid-19 shutown orders.")
                         ),    
                         #    sidebarPanel(
                         #        width = 6,
                         #        h2("hello")
                         # ),
                         
                     mainPanel(
                         width = 6,
                #         includeHTML("total_both.html")
                    plotOutput("regression")
                             )
                     )
            ),
                     
            tabPanel("About the Data",
                     
                     fluidRow(
                         
                         column(3,
                                
                                wellPanel(
                                    wellPanel(
                                        h2(strong("These are the four main datasets used in my analysis:", align = "center"))
                                    )
                                    
                                )
                                ),
                         column(4,
                                
                                wellPanel(
                                    img(src = "https://18zu3o13q8pa3oob523tuov2-wpengine.netdna-ssl.com/wp-content/uploads/2020/01/the-new-york-times-logo-900x330-1.png", width = 400),
                                    h4(strong("1. Covid-19 Cumulative Case and Death Totals from 
                                           The New York Times")),
                                    h4("The first dataset is the cumulative counts of coronavirus 
                                            cases in the United States at the county level. The data can 
                                              be found here: https://github.com/nytimes/covid-19-data"),   
                                    
                                    br(),
                                    img(src = "https://alexandrawalker.design/wp-content/uploads/2019/09/MEDSL_1.png", width = 400),
                                    h4(strong("3. County Partisanship and Demographic Data from the MIT Election Lab")),
                                    h4("The third dataset comes from the MIT Election Lab's US Election 2018 
                                              Dataset. Using the proportions of votes for Hillary and Trump in the 
                                            2016 election, I was able to determine the partisan leaning of each 
                                            county. Futhermore, this dataset includes county-level demographic 
                                           information, such as the total population, median household income, 
                                            the percent of residents age 65 and above, and the percent of people 
                                           who do not have a high school degree. This dataset can be found here: 
                                            https://github.com/MEDSL/2018-elections-unoffical.")
                                )),
                         column(4,
                                
                                wellPanel(
                                    img(src = "https://findlogovector.com/wp-content/uploads/2018/12/cuebiq-logo-vector.png", width = 400),
                                         h4(strong("2. County Mobility Data from Cuebiq")),
                                         h4("The second dataset comes from consumer insights campany Cuebiq and contains 
                                                     the weekly Cuebiq mobility index (CMI) scores for every US county for all of 2020. 
                                                     The data can be found here: https://www.cuebiq.com/visitation-insights-covid19/"),  
                                
                                    br(),
                                    img(src = "https://www.vocecon.com/wp-content/uploads/american-community-survey.jpg", width = 400),
                                    h4(strong("4. US Census American Community Survey 2014-2018")),
                                    h4("The fourth dataset is a US Census file from 2018 that contains 
                                            the geographic information necessary to create mapped data outputs. 
                                            I accessed this dataset using the tidycensus package in R. Additional 
                                            population density data can be found here: https://github.com/balsama/us_counties_data")
                                ))
                         
                     )
            ),
                     

tabPanel("Contact",
         
         fluidRow(
             
             column(3,
                    
                    wellPanel(
                      img(src = "https://media-exp1.licdn.com/dms/image/C5603AQE45jkaIMDzfw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=FanZBvpWDTk1RZzOgKRvu_n3WHJKbKWCh-fGPcszDzE", width = 275)  
                        )
                    ),
             column(6,
                    
                    wellPanel(
                        wellPanel(
                            h1(strong("Contact"), align = "center")
                        ),
                        
                        h3(strong("Hey! I'm Gabe Cederberg, a Junior at Harvard College studying 
                                   Government with a secondary in Economics."), align = "center"),
                        
                        h3("Feel free to reach out 
                                   to me at gabrielcederberg@college.harvard.edu.", align = "center"),
                        
                        h3("Special thank you to Preceptor David Kane, Kaneesha Johnson, 
                                   and Jack Schroeder.", align = "center"),
                        
                        br(),
                        h3("My code can be accessed from this GitHub repo: 
                                   https://github.com/GabeCeder/FinalProject", align = "center")
                        
                    )
             )
         )
)
 )

)
    
# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$state_cases <- renderPlot ({
        
        # Require that a season is selected or else an error message will pop up
        
        req(input$select_state)
        
        x <- county_data
        
         if (input$select_state != "All") {
             x <- filter(x, state %in% c(input$select_state))
         }

        if (input$select_view == FALSE) {
            x %>% ggplot(mapping = aes(fill = max_case, geometry = geometry)) +
                geom_sf(data = x) +
                scale_fill_viridis_c(option = "plasma") +
                labs(caption = "Sources: The New York Times and the American Community Survey 2014-2018",
                     fill = "Total Cases") +
           #     theme(fill.position = element_blank()) +
                theme_void()
        }
        
        else {
            x %>% ggplot(mapping = aes(fill = cases_per_thousand, geometry = geometry)) +
                geom_sf(data = x) +
                scale_fill_viridis_c(option = "plasma") +
                labs(caption = "Sources: The New York Times and the American Community Survey 2014-2018",
                     fill = "Cases Per 1,000") +
                #     theme(fill.position = element_blank()) +
                theme_void()   
        }
        
    })
    
    output$regression <- renderImage({
        list(src = "regression.jpg", width = 500)
    }, deleteFile = FALSE) 
    
}

# Run the application 
shinyApp(ui = ui, server = server)
