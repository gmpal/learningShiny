#The shinythemes package from RStudio allows you to take advantage of a number of pre-created themes that allow for a complete change of style with limited coding

library(shinythemes)


server <- function(input, output, session) {
  
}

ui <- fluidPage(theme=shinytheme("cosmo"),
                
                titlePanel("Use an existing theme"),
                
                sidebarLayout(
                  
                  sidebarPanel(
                    h3("Note the button is black. This is different from the previous app."),
                    actionButton("button", "A button")
                  ), 
                  
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Plot"), 
                      tabPanel("Summary"), 
                      tabPanel("Table")
                    )
                  )
                )
)

shinyApp(ui = ui, server = server)
