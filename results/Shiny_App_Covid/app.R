#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

###todo -> manage exceptions in country/dataset combination 


confirmed = read.csv("data/time_series_covid19_confirmed_global.csv")
deaths = read.csv("data/time_series_covid19_deaths_global.csv")
recovered = read.csv("data/time_series_covid19_recovered_global.csv")


#The combination of Country and Province creates UNIQUE values for COUNTRIES SELECTION
confirmed <- within(confirmed,  Country.Region <- paste(Country.Region, Province.State, sep=" "))
deaths <- within(deaths,  Country.Region <- paste(Country.Region, Province.State, sep=" "))
recovered <- within(recovered,  Country.Region <- paste(Country.Region, Province.State, sep=" "))

ui <- fluidPage(
   
   # Application title
   titlePanel("Covid19"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
         selectInput(inputId = "country",
                    label = "Choose a country:",
                    choices = confirmed["Country.Region"]), 
        
         selectInput(inputId = "dataset",
                    label = "Choose a dataset:",
                    choices = c("Confirmed", "Deaths", "Recovered")),
        
         sliderInput("range", 
                     label = "Days of interest:",
                     min = -60, max = 0, value = c(-60, 0))),
         
         # textInput("country", "Country", "Write the country of interest"),
         
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
    datasetInput <- reactive({
      switch(input$dataset,
             "Confirmed" = confirmed,
             "Deaths" = deaths,
             "Recovered" = recovered)
    })
    
   
    output$distPlot <- renderPlot({
      dataset <- datasetInput()

      min = input$range[1]
      max = input$range[2]
      today = ncol(dataset)
      part  <- dataset[dataset$Country.Region == input$country,(today + min): (today +max)]
      plot(t(as.matrix(part)))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

