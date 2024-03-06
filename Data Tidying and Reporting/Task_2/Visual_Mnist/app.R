library(shiny)
library(png)

# Load pre-trained models and dataset
load(file = "qmnist_nist.RData")

# Needed functions
avg_train_images <- sapply(0:9, function(d) {
  colMeans(train_nist$px[train_nist$digit == d, ])
})

# Function to calculate mean error
mean_error <- function(vec_img) {
  which.min(colMeans((avg_train_images - vec_img) ^ 2)) - 1
}

# Function to calculate Manhattan error
manhattan_error <- function(vec_img) {
  which.min(colSums(abs(avg_train_images - vec_img))) - 1
}

# Function to calculate Chebyshev error
chebysev_error <- function(vec_img) {
  which.min(apply(avg_train_images, 2, function(avg_img) {
    max(abs(avg_img - vec_img))
  })) - 1
}

# App UI
ui <- fluidPage(
  theme = shinythemes::shinytheme("readable"),
  tags$head(tags$style(
    HTML("
      body {
        font-family: 'Arial', sans-serif;
      }
    ")
  )),
  titlePanel("Mnist Image Classification"),
  sidebarLayout(
    sidebarPanel(
      fileInput(
        inputId = "image",
        label = "Upload Image",
        multiple = FALSE,
        accept = ".png",
        width = "150px",
        buttonLabel = "Select file"
      ),
      actionButton("classify", "Classify")
    ),
    mainPanel(tabsetPanel(
      tabPanel("Introduction",
               fluidRow(
                 column(width = 12,
                   h3("Methodology"), 
                   HTML(
                     "<p>This Shiny web app is the second evaluation assignment for the Data Tidying and Reporting course in MSc in Statistics for Data Science at UC3M. The <a href='https://github.com/marcos-crespo/UC3M/tree/main/Data%20Tidying%20and%20Reporting/Task_1'> first task</a> consisted of tackling the pairwise classification problems between the digits (0 to 9) on <a href='https://en.wikipedia.org/wiki/MNIST_database'>MNIST</a> images using Ridge Regression.</p>
                    <p>Now, for this second task, the goal is to create a visually appealing app using <a href='https://shiny.rstudio.com/'>Shiny</a> that allows the user to upload a .png extracted from the MNIST set and classify the image in some simple ways.</p>
                    <p>The classification approach used in this task is much simpler than the one used in the first task. Now we are using the idea of within-class average image, this is the image created by taking the mean value for each pixel for each class. This creates an average image for each digit and then we can compute the distance to this image and the one we uploaded.</p>
                     <p> The method provided by the assgiment was a mean squared difference between the images and we have added a Manhattan and Chebysev distances based methods. These are:</p>"
                   )
                        ),
                 column(
                   width = 12,
                   h3("Classification Methods"),
                   h4("Mean Squared difference"),
                   HTML(
                     "Calculates the mean squared error between the input image and the average image of each digit. It then selects the digit with the minimum mean squared error as the predicted digit."
                   ),
                   HTML(
                     "<p><strong>Mean Error = argmin<sub>d</sub> ∑<sub>i</sub>(x<sub>i</sub> - μ<sub>i</sub>)<sup>2</sup></strong></p>"
                   ),
                   HTML(
                     "where:<br>- d: digit (0 to 9)<br>- x<sub>i</sub>: pixel intensity of the mean image at pixel i<br>- μ<sub>i</sub>: pixel intensity of given image at pixel i"
                   )
                 ),
                 column(
                   width = 12,
                   h4("Manhattan Error"),
                   HTML(
                     "Calculates the sum of absolute differences between the input image and the average image of each digit. It then selects the digit with the minimum sum of absolute differences as the predicted digit."
                   ),
                   HTML(
                     "<p><strong>Manhattan Error = argmin<sub>d</sub> ∑<sub>i</sub> |x<sub>i</sub> - μ<sub>i</sub>|</strong></p>"
                   ),
                   HTML(
                     "where:<br>- d: digit (0 to 9)<br>- x<sub>i</sub>: pixel intensity of the mean image at pixel i<br>- μ<sub>i</sub>: pixel intensity of given image at pixel i"
                   )
                 ),
                 column(
                   width = 12,
                   h4("Chebyshev Error"),
                   HTML(
                     "Calculates the maximum absolute difference between the input image and the average image of each digit. It then selects the digit with the minimum maximum absolute difference as the predicted digit."
                   ),
                   HTML(
                     "<p><strong>Chebyshev Error = argmin<sub>d</sub> max<sub>i</sub>(|x<sub>i</sub> - μ<sub>i</sub>|)</strong></p>"
                   ),
                   HTML(
                     "where:<br>- d: digit (0 to 9)<br>- x<sub>i</sub>: pixel intensity of the mean image at pixel i<br>- μ<sub>i</sub>: pixel intensity of given image at pixel i"
                   )
                 )
               ),
      ),
      tabPanel("Classification",
 
                   imageOutput(outputId = "selected_image"),
                 fluidRow(column(
                   width = 12,
                   align = "center",
                   textOutput(outputId = "classification_result1"),
                   column(
                     width = 12,
                     align = "center",
                     textOutput(outputId = "classification_result2"),
                     column(
                       width = 12,
                       align = "center",
                       textOutput(outputId = "classification_result3")
                     )
                   )
                 ))),
                 tabPanel(
                   "Results",
                   h3("Results"),
                   # Placeholder for results, you can add your content here
                   verbatimTextOutput("uwu"),
                   HTML("Some insights from making some classification examples were observed during the making of this app:
                        <br>- Digit 9 is often missclassified using Mean Squared difference method. This is solved using Manhattan classifier almost in every situation. Chebysev also fails at identifying this digit.
                        <br>- Digit 0 was unsuccesfully classified using Chebysev method. Use one of the others instead.
                        <br>- Digit 5 was unsuccesfully classified using Manhattan method. Use one of the others instead.
                        <br> - Note how the error shown with the digit as solution when you click on Classify button is the minimun distance between the uploaded image and the one of the 10 mean images. It can be used to compare the errors for diferent digits using the same distance but not as a comparison for distance well fit. Those are different scales"
                        )
                 )
               ))
    ))

# App server
server <- function(input, output) {
  observeEvent(input$image, {
    req(input$image)
    output$selected_image <- renderImage({
      list(
        src    = normalizePath(file.path(input$image$datapath)),
        alt    = "Selected Image",
        width  = 200,
        height = 200
      )
    }, deleteFile = FALSE)
  })
  
  observeEvent(input$classify, {
    req(input$image)
    img <-
      255 * as.vector(t(png::readPNG(input$image$datapath)))  # Convert to vector
    
    # Perform classification using all three methods
    mean_pred <- mean_error(img)
    manhattan_pred <- manhattan_error(img)
    chebysev_pred <- chebysev_error(img)
    output$classification_result1 <- renderText({
      paste("Mean Error:", mean_pred, "With error:", min(colMeans((
        avg_train_images - img
      ) ^ 2)))
    })
    output$classification_result2 <- renderText({
      paste("Manhattan Error:",
            manhattan_pred,
            "With error:",
            min(colSums(abs(
              avg_train_images - img
            ))))
    })
    output$classification_result3 <- renderText({
      paste("Chebyshev Error:",
            chebysev_pred,
            "With error:",
            min(apply(avg_train_images, 2, function(avg_img) {
              max(abs(avg_img - img))
            })))
    })
    
  })
}


# Run the app
shinyApp(ui = ui, server = server)
