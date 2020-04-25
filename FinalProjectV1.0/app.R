
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

# Import county and state datasets

# county_data <- read
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

    h3("by Gabe Cederberg", style = "color:white"),

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
                             
                             # Create a selectInput for the user to select a specific
                             # season(s), or all the seasons. Multiple = TRUE so users can
                             # select more than one season.
                             
                             selectInput(inputId = "select_state",
                                         label = "Choose which states to observe",
                                         choices = c("All", levels(survivor_data$season.x)),
                                         multiple = TRUE),
            ),
            tabPanel("State by State")
,
            tabPanel("About")

 ))
    # selectInput(
    #     "state", "What's your favourite state?", state.name,
    #     multiple = TRUE
    # ),
    

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$firstplot <- renderImage({
        list(src = "firstplot.png", width = 700)
    }, deleteFile = FALSE) 
}

# Run the application 
shinyApp(ui = ui, server = server)
