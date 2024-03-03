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
# - Maybe make a after-classification question for the digit it was supposed to be


library(shiny)
library(png)
library(glmnet)

# Functions for the app

## Naive within-class average image classifier
# Create average images
load(file = "qmnist_nist.RData")

avg_train_images <- sapply(0:9, function(d) {
  colMeans(train_nist$px[train_nist$digit == d, ])
})

# Classifier function
naive_classifier <- function(vec_img) {
  which.min(colMeans((avg_train_images - vec_img) ^ 2)) - 1
}

# Load training data
load(file = "mnist_train.RData")

# 10-fold cross-validation for Ridge Regression
set.seed(12345)
lambdaGrid <- 10^seq(log10(45193.6), log10(0.1), length.out = 150)
kcvRidge <- cv.glmnet(
  x = as.matrix(train_nist$px),
  y = train_nist$digit,
  alpha = 0,
  standardize = FALSE,
  family = "multinomial",
  nfolds = 10,
  lambda = lambdaGrid
)

# Best lambda
best_lambda <- kcvRidge$lambda.min

# Best Ridge Regression model
ridge_model <- glmnet(
  x = as.matrix(train_nist$px),
  y = train_nist$digit,
  alpha = 0,
  standardize = FALSE,
  family = "multinomial",
  lambda = best_lambda
)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Visualization and classification of Mnist images"),
  sidebarLayout(
    sidebarPanel(
      fileInput(
        inputId = "image",
        label = h3("Upload your 28x28 .png for classification"),
        multiple = FALSE,
        accept = ".png",
        width = "28px",
        buttonLabel = "Select file"
      ),
      actionButton("classify_naive", "Classify (Naive)"),
      actionButton("classify_ridge", "Classify (Ridge Regression)")
    ),
    mainPanel(
      fluidRow(
        column(width = 6, align = "center", imageOutput(outputId = "selected_image")),
        column(width = 6, 
               textOutput(outputId = "class_naive"),
               textOutput(outputId = "class_ridge")
        )
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  observeEvent(input$image, {
    req(input$image)
    output$selected_image <- renderImage({
      list(
        src    = normalizePath(file.path(input$image$datapath)),
        alt    = "Selected image",
        width  = 150,
        height = 150
      )
    }, deleteFile = FALSE)
  })
  
  observeEvent(input$classify_naive, {
    req(input$image)
    img <- c(255 * t(png::readPNG(input$image$datapath)))
    output$class_naive <- renderPrint({
      paste("Naive Classification:", naive_classifier(img))
    })
  })
  
  observeEvent(input$classify_ridge, {
    req(input$image)
    img <- as.vector(t(png::readPNG(input$image$datapath)))  # Reshape to vector
    output$class_ridge <- renderPrint({
      pred <- predict(ridge_model, newx = t(img), s = best_lambda, type = "class")
      paste("Ridge Regression Classification:", pred)
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)

