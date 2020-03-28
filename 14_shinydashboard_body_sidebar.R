
ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  
  
  dashboardSidebar(
    sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                      label = "Search..."),
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th")),
      menuItem("Github", icon = icon("file-code-o"), 
               href = "https://github.com/TheoVerhelst/ulb-mlg-time-series-impact")
    )
  ),
  
  
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              fluidRow(
                tabBox(
                  title = "First tabBox",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabset1", height = "250px",
                  tabPanel("Tab1", "First tab content"),
                  tabPanel("Tab2", "Tab content 2")
                ),
                tabBox(
                  side = "right", height = "250px",
                  selected = "Tab3",
                  tabPanel("Tab1", "Tab content 1"),
                  tabPanel("Tab2", "Tab content 2"),
                  tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
                )
              ),
              h2("Widgets tab content")
      )
    )
    # Boxes need to be put in a row (or column)
    
    )
  )


server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}


shinyApp(ui, server)


