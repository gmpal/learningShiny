# Including HTML tags - just for some of them - while for some is not necessary - check Rstudio HTML TAGS for details

#### server
server <- function(input, output, session) {}

#### user interface
ui <- basicPage(
  h1("Title without tags$"),
  tags$blockquote("But block quote requires tags$ because it is less common than h3, h1 or code"),
  h3("H3 is fine without tags and so is code here"),
  code("data.frame(a=1:10, b=1:10)")
)

shinyApp(ui = ui, server = server)

