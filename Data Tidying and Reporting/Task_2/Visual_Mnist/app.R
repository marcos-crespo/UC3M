#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

###############################################################################
###############################################################################

#Notes:

# - Make an action button for predicting?


library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Visulizaton and classification of Mnist images"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "number", label = "Digit selector",
                  min = 0, max = 9, value=7, step=1, ticks = TRUE, round=TRUE),
    ),
    mainPanel(
      imageOutput(outputId = "digit.png")
    )
  )
)

# Define server logic required to draw a histogram
server <-function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
