# IN this specific case 
# observeEvent makes sure that the event is triggered
# ONLY for the observeEvent 


server <- function(input, output, session) {
  
  # Using observeEvent we're telling Shiny only to run this code
  # if mytext gets updated.
  observeEvent(input$mytext, {
    
    # myslider is a reactive but it does not trigger the code to 
    # run here because we're using observeEvent and only specified
    # input$mytext
    input$myslider
    txt <- paste(input$mytext, sample(1:10000, 1))
    updateTextInput(session, inputId = "myresults", value = txt)  
    
  })
}

ui <- basicPage(
  
  h3("The results text box only updates when you change the top text box (slider interactions do not trigger an update)."),
  sliderInput("myslider", "A slider:", min=0, max=1000, value=500),
  textInput("mytext", "Input goes here", value = "Initial value"),
  textInput("myresults", "Results will be printed here")
  
)

shinyApp(ui = ui, server = server)
