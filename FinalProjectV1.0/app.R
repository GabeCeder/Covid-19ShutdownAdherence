library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    #App title
    titlePanel("Final Project Figure for Milestone 6"),
    
    
    mainPanel(
        plotOutput("firstplot")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$firstplot <- renderImage({
        list(src = "firstplot.png", width = 700)
    }, deleteFile = FALSE) 
}

# Run the application 
shinyApp(ui = ui, server = server)
