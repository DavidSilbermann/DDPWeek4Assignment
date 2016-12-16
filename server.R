library(shiny)
shinyServer(function(input, output) {
        mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
        model1 <- lm(hp ~ mpg, data = mtcars)
        model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
        model3 <- lm(hp ~ poly(mpg ,3), data = mtcars)

        model1pred <- reactive({
                mpgInput <- input$sliderMPG
                predict(model1, newdata = data.frame(mpg = mpgInput))
        })
        
        model2pred <- reactive({
                mpgInput <- input$sliderMPG
                predict(model2, newdata = 
                                data.frame(mpg = mpgInput,
                                           mpgsp = ifelse(mpgInput - 20 > 0,
                                                          mpgInput - 20, 0)))
        })
        
        model3pred <- reactive({
                mpgInput <- input$sliderMPG
                predict(model3, newdata = data.frame(mpg = mpgInput))
        })
        
        output$plot1 <- renderPlot({
                mpgInput <- input$sliderMPG
                
                plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
                     ylab = "Horsepower", bty = "n", pch = 16,
                     xlim = c(10, 35), ylim = c(50, 350))
                if(input$showModel1){
                        abline(model1, col = "red", lwd = 2)
                }
                if(input$showModel2){
                        model2lines <- predict(model2, newdata = data.frame(
                                mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
                        ))
                        lines(10:35, model2lines, col = "blue", lwd = 2)
                }
                if(input$showModel3){
                        model3lines <- predict(model3, newdata = data.frame(
                                mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
                        ))
                        lines(10:35, model3lines, col = "green", lwd = 2)
                }
                legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction", "Model 3 Prediction"), 
                       pch = 16, col = c("red", "blue", "green"), bty = "n", cex = 1.2)
                points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
                points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
                points(mpgInput, model3pred(), col = "green", pch = 16, cex = 2)
        })
        
        output$pred1 <- renderText({
                model1pred()
        })
        
        output$pred2 <- renderText({
                model2pred()
        })
        
        output$pred3 <- renderText({
                model3pred()
        })
        
        
})