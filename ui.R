library(shiny)
shinyUI(pageWithSidebar(
headerPanel("Prediction of Car's Price on Caret's cars dataset"),
sidebarPanel(
        h3("Input paramaters"),
        sliderInput('mileage', 'Mileage', min=200, max=51000, step = 100, value = 250),
        radioButtons('cyl', 'Number of Cyclinders', c(4,6,8)),
        radioButtons('doors', 'Number of Doors', c(2,4)),
        radioButtons('leather', 'Leather Seats', c('Yes','No')),
        radioButtons('make', 'Make', c('Buick','Cadillac', 'Chevy', 'Pontiac', 'Saab', 'Saturn')),
        radioButtons('type', 'Car Type', c('convertible','coupe','hatchback','sedan','wagon')),
        actionButton('predictprice', 'Predict Price')
),
mainPanel(
        tabsetPanel(
                tabPanel("Read Me", verbatimTextOutput('readme')),
                tabPanel('Predicted Price', verbatimTextOutput('prediction')),
                tabPanel('Prediction Model Summary', verbatimTextOutput('summary')),
                tabPanel('Plots', plotOutput('plot'))
        )
)
))
