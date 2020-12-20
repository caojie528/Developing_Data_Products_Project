#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(ggplot2)

mod <- train(mpg ~ as.factor(cyl) + disp + hp + wt, method = "glm", data = mtcars)
mpg_pred <- predict(mod, mtcars)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$mpg_true_vs_pred <- renderPlot({
        ggplot(data.frame(truth = mtcars$mpg, pred = mpg_pred), 
               aes(x = pred, y = truth)) + 
            geom_point() + 
            geom_abline(intercept = 0, slope = 1, linetype = 'dashed') + 
            labs(x = "Predicted MPG", y = "True MPG", title = 'GLM Model Fit Performance') + 
            coord_fixed() + 
            xlim(c(0, 35)) + 
            ylim(c(0, 35)) + 
            theme_bw() + 
            theme(plot.title = element_text(hjust = 0.5))
    })

    output$newmpg <- renderText({
        cyl <- input$cyl
        disp <- input$disp
        hp <- input$hp
        wt <- input$wt
        newmpg <- predict(mod, newdata = data.frame(cyl, disp, hp, wt))
        as.character(newmpg)
    })

})
