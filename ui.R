library(shiny)
shinyUI(fluidPage(
        titlePanel("Predict Horsepower from MPG"),
        p("This application predictes the horsepower of an automobile based on its mileage.  The 
          application uses three models:"),
        p("Model 1 - A linear model"),
        p("Model 2 - A linear model with an inflection point"),
        p("Model 3 - A model based on a 3rd order polynomial"),
        br(),
        p("Usage:  To predict the horsepower of an automobile, select it's mileage using the slider."),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
                        #sliderInput("sliderPoly", "What order polynomial should be used for the model?", 1, 5, value = 3),
                        checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
                        checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
                        checkboxInput("showModel3", "Show/Hide Model 3", value = TRUE)
                ),
                mainPanel(
                        plotOutput("plot1"),
                        h3("Predicted Horsepower from Model 1:"),
                        textOutput("pred1"),
                        h3("Predicted Horsepower from Model 2:"),
                        textOutput("pred2"),
                        h3("Predicted Horsepower from Model 3:"),
                        textOutput("pred3")
                )
        )
))