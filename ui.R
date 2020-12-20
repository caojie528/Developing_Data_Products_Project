#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Car MPG Prediction"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h4("Provide your input and click 'calculate' to get the predicted MPG for your car."), 
            radioButtons('cyl', 'Cylinders', choices = c(4, 6, 8), selected = 4), 
            sliderInput('disp', 'Displacement (cu.in.)', min = 70, max = 480, value = 190), 
            sliderInput('hp', 'Horsepower', min = 50, max = 350, value = 120), 
            sliderInput('wt', 'Weight (1000 lbs)', min = 1, max = 6, value = 3), 
            submitButton('Calculate'), 
            HTML('<br>'), 
            h4('Dataset'), 
            p('Motor Trend Car Road Test'), 
            h4('Description'), 
            p('The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).'), 
            h4('Reference'), 
            p('Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Model:"), 
            p("The fitted GLM model uses the following formula"), 
            strong("mpg ~ number of cylinders + displacement + horsepower + weight"),
            h3("Model performance"), 
            plotOutput('mpg_true_vs_pred'), 
            h3("Predicted MPG:"), 
            textOutput('newmpg')
        )
    )
))
