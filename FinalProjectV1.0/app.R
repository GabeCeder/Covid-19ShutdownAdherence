# Welcome to my code for this Shiny App

# Loading the necessary libraries

library(shiny)
library(tidyverse)
library(readr)
library(janitor)
library(ggthemes)
library(viridis)  
library(gganimate)
library(shinythemes)
library(shinyWidgets)
library(tidycensus)
library(plotly)

# Census API Key

Sys.getenv("CENSUS_API_KEY")

# Import the county and state datasets

county_data <- read_rds("county_map_data.rds")
state_data <- read_rds("state_data.rds")
county_sip_data <- read_rds("county_sip_data.rds")

# Avoid scientific notation

options(scipen=999)

# Define UI for the application

ui <- fluidPage(
    
# Set background image to an image of COVID-19  
    
    setBackgroundImage(src = "https://fenwayhealth.org/wp-content/uploads/covid-19-2-1140x450-1.jpg"),
    
# Change theme to cosmo using shinytheme
    
    theme = shinytheme("cosmo"),
    
# Add application title

    h1(strong("Does Partisan Leaning Affect COVID-19 Shelter-In-Place Adherence?", 
              style = "color: white"), align = "center"),

# Add subtitle

    h2("Exploring County-Level Data", style = "color:white", align = "center"),

# Add name 

    h3(strong("by Gabe Cederberg", style = "color:white"), align = "center"),

# Create the navigation bar, while making the title blank

     navbarPage("",
            
            # Create a tab to explore the case totals in different states across the US.
            
            tabPanel("Explore the Dataset",
                     
                     fluidRow(
                         
                         column(4,
                                
                                wellPanel(
                                    wellPanel(h1(strong("Explore the Dataset"), align = "center"),
                                    h3("County Case Totals on May 14th", align = "center")
                                    ),
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
                                )
                         ),
                         
                         column(7, 
                                
                                wellPanel(h2(strong("Total Cases in Each County "), align = "center"),
                                   
                                   # Output the plot comparing three types of wins to
                                   # the finish place of a contestant
                                   
                                   plotlyOutput("state_cases"),
                                   br()
                            )
                         )
                     )
            ),

            # Adding tab on political context of this investigation. This emphasizes the importance
            # of the findings of this analysis. 
            
            tabPanel("Context",
                    
                    fluidRow(
                        
                        column(3, 
                            
                               br(),
                               br(),
                               br(),
                               
                            wellPanel(
                                   img(src = "https://www.idahostatesman.com/latest-news/iy0v2g/picture241476241/alternates/FREE_768/Maddow.JPG", width = 280),
                                   h4("March 13th, 2020", align = "center"),
                                   
                                   br(),
                                   
                                   img(src = "https://web.archive.org/web/20200407075841if_/https://www.bridgemi.com/sites/default/files/styles/article_hero_image/public/hero_images/whitmer-10.jpg?itok=cpX8uZw8", width = 280),
                                   h4("March 17th, 2020", align = "center"),
                                   
                                   br(),
                                   
                                   img(src = "https://i2.wp.com/www.towleroad.com/wp-content/uploads/2020/03/hayes.jpg?w=1200&ssl=1", width = 280),
                                   h4("March 24th, 2020", align = "center")
                            )
                        ),
                        
                        column(6, 
                            
                            wellPanel(
                                
                                h1(strong("Context"), align = "center"),
                                
                                h3(strong("As COVID-19 spread across the United States in early 2020, conservative 
                                    politicians and media figures had vastly different messages about the 
                                    threat of the virus compared to their liberal counterparts."), align = "center"),
                                
                                wellPanel(
                                 h4("On March 24th, President Trump ",
                                    a(href = "https://www.realclearpolitics.com/video/2020/03/24/president_trump_coronavirus_town_hall_is_it_realistic_to_open_the_country_by_easter.html", "told", 
                                        .noWS = "outside"), .noWS = c("after-begin", "before-end"),
                                 " Fox News that he \"would love to have the 
                                    country opened up and just raring to go by Easter.\" He continued, saying 
                                    \"We lose thousands and thousands of people to the flu. We don't turn 
                                    the country off. We lose much more than that to automobile accidents.\"", align = "center")
                                ),
                                wellPanel(
                                 h4("On the same day, New York Governor Andrew Cuomo ", 
                                    a(href = "https://www.rev.com/blog/transcripts/andrew-cuomo-coronavirus-briefing-march-24-governor-criticizes-fema-says-curve-isnt-flattening-in-fiery-conference", "spoke", 
                                        .noWS = "outside"), .noWS = c("after-begin", "before-end"),
                                 " of the virus' looming threat to 
                                   cities around the country: \"Address the curve here, and then that curve is 
                                   going to be going all across the country... You’re going to have the governor 
                                   of California several weeks from now saying the same thing. You’re going 
                                   to have the governor of Illinois saying the same thing. The governor of the 
                                   state of Washington saying the same thing. Do it right here. We’re just 
                                   the first case. We’re just the first template.\"", align = "center")
                                 ),

                                h3(strong("To see whether politically divergent messages around COVID-19 had a tangible effect 
                                          on people's behavior in late March, I am exploring whether the partisan leaning of a county
                                    is related to how much the county adhered to shelter-in-place orders."), align = "center")
                            )
                        ),
                        
                        column(3,

                               br(),
                               br(),
                               br(),
                               
                             wellPanel( 
                               img(src = "https://i.insider.com/5e59596efee23d0fb873eb46?width=2500&format=jpeg&auto=webp", width = 280),
                                 h4("February 27th, 2020", align = "center"),
                                 
                               br(),
                               
                               img(src = "https://cdn-prod.opendemocracy.net/media/images/hannity-coronavirus-hysteria.max-760x504.png", width = 280),
                               h4("March 9th, 2020", align = "center"),
                               
                               br(),
                               
                               img(src = "https://politicaldig.com/wp-content/uploads/2020/03/trump-wants-to-open-country-back-up-for-easter.jpg", width = 280),
                                 h4("March 24th, 2020", align = "center")
                             )
                        )
                        
                    )
            ),
            
# The research process tab describes the calculations I did for this analysis and shows a figure
# demonstrating the case growth rates in each state after they reached 100 confirmed cases. 

            tabPanel("Research Process",
                     
                     fluidRow(
                         
                         column(4,
                                
                                wellPanel(
                                    wellPanel(
                                        h3(strong("The goal of this project is to explore whether counties that 
                                   lean Republican or Democrat responded differently to COVID-19 
                                   shelter-in-place orders in late March 2020."), align = "center")
                                    ),
                                    
                                    br(),
                                    
                                    wellPanel(img(src = "https://help.cuebiq.com/hc/article_attachments/360055311451/Screen_Shot_2020-04-22_at_10.58.26_AM.png", 
                                        width = 360)),
                                    
                                    h1(""),
                                    h1(""),
                                    
                                    plotlyOutput("cases_plot"),
                                    
                                    br()
                                     
                                )
                         ),
                         
                         column(7,
                                
                                wellPanel(
                                    h2(strong("Did Democrats stay at home more than Republicans?"), align = "center"),
                                    
                                    br(),
                                    
                                    wellPanel(
                                    h4(strong("To answer that question, I analyzed county-level 
                                              datasets for all 16 states that enacted shelter-in-place 
                                              orders on or before March 24th, 2020."), align = "center")),
                                    
                                    h2(strong("Data"), align = "center"), 
                                    
                                    h4("First, I calculated the increase in the percent of people 
                                       staying at home between the week of January 6th, 2020 and 
                                       the week of March 30th, 2020. In counties that followed 
                                       shelter-in-place orders closely, the increase between the 
                                       weeks of January 6th and March 30th is large. Where people 
                                       ignored shutdown orders, the change was small."),
                                    
                                    h4("Next, I combined the shelter-in-place dataset with datasets 
                                       that show the number of confirmed cases in each county on April 
                                       3rd, the political leaning of each county, and several demographic 
                                       factors."),
                                    
                                    wellPanel(
                                    h2(strong("Analysis"), align = "center"),
                                    
                                    h4(strong("I then ran a linear regression analysis between the partisan 
                                       leaning of a county and the change in the percent of people 
                                       staying at home in that county."), align = "center"),
                                    h4(strong("In this regression model, I controlled for the effects of 
                                         population density, the number of COVID-19 cases in the county, median household 
                                         income, education, and the percent of the population above age 65."), 
                                       align = "center")
                                                ),
                                    
                                    h3(""),
                                    
                                    h3(strong("States Included in this Analysis"), align = "center"),
                                    
                                    h4("The 16 states included in this analysis all implemented shelter-in-place 
                                       orders by March 24th. This ensures that all states in the analysis were 
                                       under the same orders during the week preceding March 30th, when the 
                                       percent of people staying at home was being recorded."),
                                    
                                    h4("The states are diverse in terms of population, location, size, density, 
                                       partisan leaning, and economic activity."),
                                    
                                    h4("California, Connecticut, Delaware, Illinois, Indiana, Louisiana, 
                                       Massachusetts, Michigan, New Jersey, New Mexico, New York, Ohio, 
                                       Oregon, Vermont, Washington, West Virginia"),
                            
                                    h3(""),
                                    
                                    h3(strong("Shortcomings of the Data"), align = "center"),
                                    
                                    h4("First, it would be most accurate to compare the percent of 
                                       people at home the week of March 30th, 2020 to the percent at 
                                       home the same week in years prior. Unfortunately, the publicly 
                                       available dataset begins at the beginning of 2020."),
                                    
                                    h4("Second, the shelter-in-place analysis is based on the percent 
                                       of people in each county that do not move more than 330 feet from 
                                       their home. The data is collected by tracking cell phone locations, 
                                       so it does not account for movement that occurs without a cell phone."),
                                    
                                    h4("Third, this analysis defined a county’s partisan leaning as: Hillary’s 
                                       2016 vote share / (Hillary’s 2016 vote share + Trump’s 2016 vote share). 
                                       This measurement of county partisanship is potentially outdated and 
                                       does not account for third party voters.")

                                    )
                                
                                )
                     )
            ),

# The findings tab shows a figure that users can hover over to see the individual counties underlying
# the regression analysis that I've performed. It also includes the regression outputs. 

            tabPanel("Findings",
                     
                     fluidRow(
                         
                         column(6,
                             
                            wellPanel(
                            
                             h2(strong("Findings"), align = "center"),
                             
                             wellPanel(h3(strong("Yes, Democratic-leaning counties had a higher percentage of people 
                                staying at home, even when controlling for each county’s COVID-19 cases 
                                and demographic, economic, and geographic variables."), align = "center")),
                             
                             h3("This regression output shows that a one percent increase in a county’s 2016 
                                Democratic vote share is associated with a 0.126 percentage point increase in the proportion
                                of people staying at home during the week of March 30th."),
                             
                             h3("While this appears to be an incrementally small effect, when comparing 
                                counties that are 40% Democratic versus those that are 60% Democratic, 
                                this regression shows that partisanship could responsible for a 2 
                                percentage point difference in the percent of people staying at home 
                                during the COVID-19 shutdowns."),
                             
                             br(),
                             
                             h3(strong("Standardizing the Regression Output"), align = "center"),
                             
                             h3("Furthermore, by standardizing the independent and dependent variables, 
                                a county’s partisan leaning emerges as the variable with the second greatest 
                                effect on the percent of people staying at home (behind median household income)."),
                             
                             h3("This makes sense because high income jobs are often easier to perform remotely, 
                                and because higher income individuals face less pressure to seek out new sources 
                                of income outside of the home."),
                    wellPanel(         
                             h3("A one standard deviation increase in the county’s Democratic vote share (15.71%) 
                                is associated with a 0.29 standard deviation increase in the percent of people staying at 
                                home (1.85%)."),
                             
                             h3("For comparison, a one standard deviation increase in the number of thousands of 
                                confirmed COVID-19 cases in a county (1.39) is only associated with a 0.17 
                                standard deviation increase in the percent of people staying at home (1.10%).")
                             ),
                             
                             h3("Interestingly, several variables were strongly statistically significant, 
                                suggesting that these variables also have clear statistical relationships with 
                                the percent of people staying at home."),
                             
                             wellPanel(
                                 h3(strong("Looking Forward"), align = "center"),
                                 
                                 h3("It would be valuable to examine whether the difference in the percent 
                                    of people staying at home between Democratic and Republican counties 
                                    narrowed after March 30th, as politicians and media figures from both 
                                    parties began to view the virus’ threat more similarly.")
                                )
                             
                             )
                            ),

                         column(6,
                                wellPanel(
                                    br(),
                    plotlyOutput("sip_partisanship"),
                        br()
                    ),
                        wellPanel(
                            br(),
                    plotOutput("regression", height = "100%")
                    ),
                                wellPanel(
                                    br(),
                    plotOutput("regression_2", height = "100%"),
                    br()
                                )
                             )
                     )
            ),

# This tab helps people find the datasets that I used for this analysis.                      

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
                                    h4(strong("1. COVID-19 Cumulative Case and Death Totals from 
                                           The New York Times")),
                                    h4("The first dataset is the cumulative counts of confirmed coronavirus 
                                            cases in the United States. The data is compiled daily at the 
                                            county and state levels. The data can 
                                              be found ",
                                       a(href = "https://github.com/nytimes/covid-19-data", "here", 
                                         .noWS = "outside"), .noWS = c("after-begin", "before-end"), 
                                       ".")
                                    ),   
                                
                                wellPanel(
                                    img(src = "https://alexandrawalker.design/wp-content/uploads/2019/09/MEDSL_1.png", width = 400),
                                    h4(strong("3. County Partisanship and Demographic Data from the MIT Election Lab")),
                                    h4("The third dataset comes from the MIT Election Lab's US Election 2018 
                                              Dataset. It includes county-level voting data, as well several other county-level demographic 
                                              factors. This dataset can be found ",
                                       a(href = "https://github.com/MEDSL/2018-elections-unoffical.", "here", 
                                         .noWS = "outside"), .noWS = c("after-begin", "before-end"), 
                                       ".")
                                    )
                                ),
                         column(4,
                                
                                wellPanel(
                                    img(src = "https://findlogovector.com/wp-content/uploads/2018/12/cuebiq-logo-vector.png", width = 400),
                                         h4(strong("2. Shelter in Place Analysis from Cuebiq")),
                                         h4("The second dataset comes from consumer insights company Cuebiq and contains 
                                                     the percent of people staying at home in every US county 
                                                     for each week of 2020. The data can be found ",
                                            a(href = "https://www.cuebiq.com/visitation-insights-covid19/", "here", 
                                              .noWS = "outside"), .noWS = c("after-begin", "before-end"), 
                                            ".")
                                    ),  
                                
                                wellPanel(
                                    img(src = "https://www.vocecon.com/wp-content/uploads/american-community-survey.jpg", width = 400),
                                    h4(strong("4. US Census American Community Survey 2014-2018")),
                                    h4("The fourth dataset is a US Census file from 2018 that contains 
                                            the geographic information necessary to create mapped data outputs. 
                                            I accessed this dataset using the tidycensus package in R. Additional 
                                            population density data can be found ",
                                            a(href = "https://github.com/balsama/us_counties_data", "here", 
                                         .noWS = "outside"), .noWS = c("after-begin", "before-end"), 
                                       ".")
                                    )
                                )
                         
                     )
            ),
           
# This tab helps people contact me if they want to reach out, and it thanks people who have been helpful 
# in this process. 

tabPanel("Contact",
         
         fluidRow(
             
             column(1, 
                    h1("")
                    ),
             
             column(3,
                    
                    wellPanel(
                      img(src = "https://media-exp1.licdn.com/dms/image/C4E03AQF5_J0BskIQTg/profile-displayphoto-shrink_400_400/0/1604699131052?e=1618444800&v=beta&t=WNC3v4fd6FTpEmoG8Q9FsqncA0qq4vKb46SeU0DSCGo", width = 275)  
                        )
                    ),
             column(6,
                    
                    wellPanel(
                        
                        h3(strong("Hi, I'm Gabe Cederberg, a Junior at Harvard College studying 
                                   Government with a secondary in Economics."), align = "center"),
                        
                        br(),
                        
                        h4(strong("Feel free to reach out 
                                   to me at gabrielcederberg@college.harvard.edu"), align = "center"),
                        
                        br(),
                        
                        h3("Special thank you to Preceptor David Kane, Kaneesha Johnson, 
                                   and Jack Schroeder.", align = "center"),
                        br(),
                        
                        wellPanel(
                        h3("Code and image credits can be accessed from this GitHub repository:", align = "center"),
                        h4(strong(a(href = "https://github.com/GabeCeder/Covid-19ShutdownAdherence", 
                             "https://github.com/GabeCeder/Covid-19ShutdownAdherence", 
                             .noWS = "outside"), .noWS = c("after-begin", "before-end")), align = "center"))
                        
                    )
             )
         )
)
 )

)
    
# Define server logic 

server <- function(input, output) {
    
    # Write underlying code for the Research Process figure showing case growth since 100 cases
    
    output$cases_plot <- renderPlotly({
        cases_plotted <- ggplot(state_data, aes(days_since_100_cases, cases, color = state,
                                                text = paste("State:", state, "<br>"))) +
            geom_line() +
            theme_classic() +
            labs(
                title = "Case Growth by State",
                y = "Cases",
                x = "Days Since 100 Confirmed Cases",
                caption = "Data from The New York Times",
                color = "State") +
            scale_y_continuous(trans = "log10") +
            theme(legend.position = "none") + 
            scale_color_viridis_d(option = "plasma", direction = -1)

        ggplotly(cases_plotted, tooltip = "text")
    })
    
    # Write underlying code for the Findings plot that shows each county's SIP percent and 2016 
    # Democratic vote share. 
    
    output$sip_partisanship <- renderPlotly({
        
        c <- county_sip_data %>% 
            ggplot(aes(pct_dem, delta_sip, text = paste("", county, "<br>",
                                                        "", state, "<br>",
                                                        "Dem Vote Share:", round(pct_dem, 1), "%", "<br>",
                                                        "Change:", delta_sip, "%", "<br>"))) + 
            geom_point(aes(color = state)) +
            geom_smooth(aes(pct_dem, delta_sip)) +
            theme_classic() +
            labs(
                title = "County Partisanship and Percent of People Staying at Home",
                y = "Change in Percent of People Staying at 
                Home Between January and March 2020",
                x = "Democratic 2016 Presidential Vote Share") +
            theme(legend.position = "none") + 
            scale_color_viridis_d(option = "plasma", direction = -1)
        
        fit <- lm(delta_sip ~ pct_dem, data = county_sip_data)
        
        ggplotly(c, tooltip = "text") %>% 
            add_lines(x = county_sip_data$pct_dem, y = fitted(fit))
        
    })
    
    # This is the underlying code for the landing page that helps people explore case totals in 
    # counties in different states. 
    
    output$state_cases <- renderPlotly ({
        
        # Require that an input is put in place
        
        req(input$select_state)
        
        x <- county_data
        
         if (input$select_state != "All") {
             x <- filter(x, state %in% c(input$select_state))
         }

        if (input$select_view == FALSE) {
             a <- x %>% ggplot(mapping = aes(fill = cases, geometry = geometry,
                                             text = paste("County:", county, "<br>",
                                                          "State:", state, "<br>",
                                                          "Cases:", cases, "<br>"))) +
                geom_sf(data = x) +
                scale_fill_viridis_c(option = "plasma") +
                labs(caption = "Sources: The New York Times and the American Community Survey 2014-2018",
                     fill = "Total Cases") +
                theme_void()
            
            ggplotly(a, tooltip = "text")
            
        }
        
        else {
            b <- x %>% ggplot(mapping = aes(fill = cases_per_thousand, geometry = geometry,
                                            text = paste("County:", county, "<br>",
                                                         "State:", state, "<br>",
                                                         "Cases per Thousand:", round(cases_per_thousand, 2), "<br>"))) +
                geom_sf(data = x) +
                scale_fill_viridis_c(option = "plasma") +
                labs(caption = "Sources: The New York Times and the American Community Survey 2014-2018",
                     fill = "Cases Per 1,000") +
                #     theme(fill.position = element_blank()) +
                theme_void()  
            
            ggplotly(b, tooltip = "text")
        }
        
    })
    
    # The underlying code for the regression output images in the Findings page. 
    
    output$regression <- renderImage({
        list(src = "reg_1.jpg", width = 610)
    }, deleteFile = FALSE) 
    
    output$regression_2 <- renderImage({
        list(src = "reg_2.jpg", width = 610)
    }, deleteFile = FALSE) 
    
}

# Run the application using all of this code
shinyApp(ui = ui, server = server)
