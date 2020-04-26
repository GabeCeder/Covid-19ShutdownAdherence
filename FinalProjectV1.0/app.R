
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

# Import county and state datasets

 county_data <- read_rds("county_data.rds")
# state_data <- 

# Define UI for application that draws a histogram.

ui <- fluidPage(
    
# Set background image to something health related.  
    
    setBackgroundImage(src = "https://fenwayhealth.org/wp-content/uploads/covid-19-2-1140x450-1.jpg"),
    
# Change theme to cosmo using shinytheme.
    
    theme = shinytheme("cosmo"),
    
# Add application title

    h1(strong("Does Partisan Leaning Affect Covid-19 Mobility Reduction?", style = "color: white"), align = "center"),

# Add subtitle

    h2("Exploring County-Level Data", style = "color:white", align = "center"),

# Add name 

    h3(strong("by Gabe Cederberg", style = "color:white"), align = "center"),

# Create the navigation bar, making the title blank

     navbarPage("",
#            
#            # Create the dataset explorer tab. This wil render a data table, so add a
#            # sidebar layout with various different functionalities to filter the
#            # dataset.
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
                                   
                                   plotOutput("winsComparisonPlot"),
                                   br()
                         ),
                     )
            ),

     #       tabPanel("Research Process"),

            tabPanel("Findings",
                     sidebarLayout(
                         sidebarPanel(
                             width = 6,
                             h3("I ran a linear regression analysis to determine the relationship 
                                between the partisan political leaning of a county and the degree to which 
                                people followed covid-19 shutdown orders by reducing their mobility. 
                                Specifically, I studied New York, New Jersey, and Connecticut."),
                             
                             br(),
                             h3("This regression output shows that, in these 3 states, a one percentage point 
                             increase in Hillary Clinton's vote share in 2016 is associated with a 1.73 point
                             reduction in the Cuebiq Mobility Index of a given county between the week of 
                             January 6th, 2020 and the week of March 30th."),
                             
                             br(),
                             h3("Not only was partisan leaning the most statistically significant factors, it 
                                was also the factor with the greatest coefficient. This suggests that people's 
                                partisan leanings had a substantial impact on their ability and/or willingness
                                to follow the covid-19 shutown orders.")
                         ),      
                              
                     mainPanel(
                         width = 6,
                #         includeHTML("total_both.html")
                    plotOutput("regression")
                             )
                     )
            ),
                     
            tabPanel("About the Data",
                        sidebarLayout(
                            sidebarPanel(
                                width = 3,
                                h3("The goal of this project is to explore whether counties that 
                                   lean Republican or Democrat responded differently to covid-19 
                                   shutdown orders.")
                            ),
                            mainPanel(
                                width = 8, 
                                h2(strong("There are four main datasets used in my analysis:", style = "background-color: white", align = "center")),
                                
                                br(),
                                h3("1. Covid-19 Cumulative Case and Death Totals by County from 
                                   The New York Times", style = "background-color: white"),
                                h4("The first dataset is the cumulative counts of coronavirus 
                                   cases in the United States at the county level. The data can 
                                   be found here: https://github.com/nytimes/covid-19-data", style = "background-color: white"),
                                
                                br(),
                                h3("2. County Mobility Data from Cuebiq", style = "background-color: white"),
                                h4("The second dataset comes from Cuebiq, a leading consumer 
                                   insights and measurement company. The dataset that I selected 
                                   for this analysis contains the Cuebiq mobility index (CMI) scores 
                                   for every county in Connecticut, Massachusetts, New Jersey, New York, 
                                   and Rhode Island on the week of January 6th and the week of March 30th. 
                                   By determining the difference between the mobility indices from these 
                                   two dates, I was able to calculate the change in mobility over time 
                                   from a pre-pandemic baseline to a post-shutdown time period. The data 
                                   can be found here: https://www.cuebiq.com/visitation-insights-covid19/", style = "background-color: white"),
                                
                                br(),
                                h3("3. County Partisanship and Demographic Data from the MIT Election Lab", style = "background-color: white"),
                                h4("The third dataset comes from the MIT Election Lab's US Election 2018 
                                   Dataset. Using the proportions of votes for Hillary and Trump in the 
                                   2016 election, I was able to determine the partisan leaning of each 
                                   county. Futhermore, this dataset includes county-level demographic 
                                   information, such as the total population, median household income, 
                                   the percent of residents age 65 and above, and the percent of people 
                                   who do not have a high school degree. This dataset can be found here: 
                                   https://github.com/MEDSL/2018-elections-unoffical. ", style = "background-color: white"),
                                
                                br(),
                                h3("4. US Census American Community Survey 2014-2018", style = "background-color: white"),
                                h4("The fourth dataset is a US Census file from 2018 that contains 
                                   the geographic information necessary to create mapped data outputs. 
                                   I accessed this dataset using the tidycensus package in R.", style = "background-color: white")
                            )
                    )
                ),
                            
                tabPanel("Contact",
                            
                                h1(strong("Contact", style = "background-color: white"), align = "center"),
                                h2("Hey! I'm Gabe Cederberg, a Junior at Harvard College studying 
                                   Government with a secondary in Economics.", style = "background-color: white"),
                                
                                br(),
                                h2("Feel free to reach out 
                                   to me at gabrielcederberg@college.harvard.edu.", style = "background-color: white"),
                                
                                br(),
                                h2("Special thank you to Preceptor David Kane, Kaneesha Johnson, 
                                   and Jack Schroeder.", style = "background-color: white"),
                                   
                                br(),
                                h2("My code can be accessed from this GitHub repo: 
                                   https://github.com/GabeCeder/FinalProject", style = "background-color: white")
                            
                                                        )

 )

)
    
# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$winsComparisonPlot <- renderPlot ({
        
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
