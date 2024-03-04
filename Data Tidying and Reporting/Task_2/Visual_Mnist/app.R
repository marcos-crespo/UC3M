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
library(class)  # For KNN classification

# Functions for the app

## KNN Classifier
# Create average images
load(file = "qmnist_nist.RData")

avg_train_images <- sapply(0:9, function(d) {
  colMeans(train_nist$px[train_nist$digit == d, ])
})

# Shuffle the dataset
set.seed(123)  # For reproducibility
shuffled_indices <- sample(nrow(train_nist))
train_nist_shuffled <- train_nist[shuffled_indices, ]

# Split the dataset into train and test
split_index <- nrow(train_nist_shuffled) %/% 2
train_set <- train_nist_shuffled[1:split_index, ]
test_set <- train_nist_shuffled[(split_index + 1):nrow(train_nist_shuffled), ]

# KNN Classifier
  if (!file.exists("KNN.RData")) {
    # Train the KNN model and save it
    knn_model <- knn(train = train_set$px, test = test_set$px, cl = train_set$digit, k = 10)
    save(knn_model, file = "KNN.RData")
  } else {
    # Load the saved KNN model
    load("KNN.RData")
  }

# Classifier function (existing)
classifier_avg <- function(vec_img) {
  paste(
    "The predicted digit is: ",
    which.min(colMeans((
      avg_train_images - vec_img
    ) ^ 2)) - 1,
    "; the within within-class average image mean is: ",
    min(colMeans((
      avg_train_images - vec_img
    ) ^ 2))
  )
}

# Classifier function (KNN)
classifier_knn <- function(vec_img) {
  paste(
    "The predicted digit is: ",
    predict(knn_model, newdata=255 * vec_img)
  )
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinythemes::shinytheme("lumen"),
  tags$head(
    tags$style(HTML("
      body {
        font-family: 'Arial', sans-serif; /* Cambiar a la fuente deseada */
      }
    "))
  ),
  titlePanel("Visualization and classification of Mnist images"),
  tags$div(
    style = "margin-bottom: 20px;",
    h5("This app performs classification on an Mnist image based on several methods.")
  ),
  sidebarLayout(
    sidebarPanel(
      fileInput(
        inputId = "image",
        label = "Upload your .png",
        multiple = FALSE,
        accept = ".png",
        width = "28px",
        buttonLabel = "Select file"
      ),
      actionButton("classify_knn", "Classify (KNN)")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Methodology", 
                 tags$div(
                   HTML("This task is the second part of the assignments for Data Tidying and Reporting course for Msc in Statistics for Data Science in UC3M. The first part of the project tackled all the pairwise classification problems in the Mnist <a href='#'>dataset</a> with fairly good rates. The document is available <a href='#'>here</a>. <br><br>
         In this second assignment the goal is to create a Shiny web app that the user can use in order to upload a Mnist image from the test data set and achieve a successful classification in an environment that is clear and visually appealing. <br><br>
         The images that you upload should be: <br>
         <ul>
           <li>28*28 .png images extracted from the MNIST test data set. Data set available <a href='https://github.com/marcos-crespo/UC3M/tree/main/Data%20Tidying%20and%20Reporting/Task_2/Visual_Mnist'>here</a> and the code for creating the images in R is {code chunk to display code}.</li>
         </ul>
         The methods used are: <br>
         <ul>
           <li>Within image classification calculates the mean of each class and classifies the test image to the class with the smallest Euclidean distance to its mean image.</li>
           <li>K-Nearest Neighbors (KNN) classification is a non-parametric method used for classification and regression. In KNN classification, the output class of an unseen data point is determined by the majority class among its k nearest neighbors. KNN is simple, easy to understand, and effective for small datasets. It is particularly useful when the decision boundary is highly irregular. </li>
         </ul>
         KNN Classification:<br>
         Let \( X \) be the training set with inputs \( x_1, x_2, ..., x_n \), and \( Y \) be the corresponding labels. Given a new data point \( x \), KNN classifies it by finding the \( k \) nearest neighbors in \( X \) and assigns the majority class among these neighbors to \( x \). The distance metric used can be Euclidean distance, Manhattan distance, etc. <br>
         Mathematically, for a new data point \( x \), let \( N(x) \) denote its \( k \) nearest neighbors. Then, the predicted class \( \hat{y} \) is given by: <br>
         \[ \hat{y} = \text{argmax}_{y} \sum_{x_i \in N(x)} I(y_i = y) \] <br>
         where \( I() \) is the indicator function that outputs 1 if the condition inside is true, and 0 otherwise."))
      ),
        tabPanel("Classification",
                 fluidRow(
                   column(width = 6, align = "center", imageOutput(outputId = "selected_image")),
                   column(width = 6, 
                          textOutput(outputId = "class_knn"),
                          textOutput(outputId = "class_classifier")
                   )
                 )
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
  
  observeEvent(input$classify_knn, {
    req(input$image)
    img <- as.vector(t(png::readPNG(input$image$datapath)))  # Reshape to vector
    output$class_knn <- renderPrint({
      paste("KNN Classification:", classifier_knn(img))
    })
  })
  
  output$class_classifier <- renderPrint({
    if (!is.null(input$image)) {
      img <- c(255 * t(png::readPNG(input$image$datapath)))
      classifier_avg(img)
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
