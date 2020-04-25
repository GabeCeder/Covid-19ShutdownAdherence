
# Load the necessary libraries

library(shiny)
library(tidyverse)
library(dplyr)
library(readr)
library(fivethirtyeight)
library(janitor)
library(ggthemes)
library(gt)
library(reprex)
library(magrittr)
library(stringr)
library(haven)
library(infer)
library(readxl)
library(viridis)  
library(RCurl)
library(gifski)
library(gganimate)
library(shinythemes)
library(shinyWidgets)
library(plotly)

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

    h1(strong("Does Partisan Leaning Affect Covid-19 Mobility Reduction?", style = "color: white")),

# Add subtitle

    h2("Exploring County-Level Data", style = "color:white"),

# Add name 

    h3(strong("by Gabe Cederberg", style = "color:white")),

# Create the navigation bar, making the title blank

     navbarPage("",
#            
#            # Create the dataset explorer tab. This wil render a data table, so add a
#            # sidebar layout with various different functionalities to filter the
#            # dataset.
#            
            tabPanel("Explore the Dataset"),

            tabPanel("State by State",
                     
                     sidebarLayout(
                         
                         sidebarPanel(
                             
                             # Create a selectInput for the user to select which states to view 
                             
                             selectInput(inputId = "select_state",
                                         label = "Choose which states to observe",
                                         choices = c("Alabama",
                #                                     "Alaska",
                                                     "Arizona",
                                                     "Arkansas",
                                                     "California",
                                                     "Colorado",
                                                     "Connecticut",
                                                     "Delaware",
                                                     "Florida",
                                                     "Georgia",
                           #                          "Hawaii",
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
                                         selected = "Minnesota")
                             
                         ),
                         
                         mainPanel(width = 6,
                                   h2(strong("Number of Cases in Each County", style = "background-color: white", align = "center")),
                                   
                                   # Output the plot comparing three types of wins to
                                   # the finish place of a contestant
                                   
                                   plotOutput("winsComparisonPlot"),
                                   br()
                         ),
                     )
                     ),
            tabPanel("About")

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
        
         
        # x <- county_data %>% 
        #               filter(state %in% c(input$select_state))
        
        x %>% ggplot(mapping = aes(fill = max_case, geometry = geometry)) +
            geom_sf(data = x) +
            scale_fill_viridis_c(direction = -1, option = "plasma") +
            labs(caption = "Sources: The New York Times and the American Community Survey 2014-2018",
                 color = "Total Number of Cases",
                 fill = "") +
       #     theme(fill.position = element_blank()) +
            theme_void()
    
         
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
