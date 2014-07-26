library(shiny)
par(mfrow = c(2,2))
shinyServer(
        function(input, output){
                #Load datasets
                library(caret)
                data(cars)
                
                ## Create the optimum multivariate linear model
                fit <- lm(Price ~ Mileage+Cylinder+Doors+Leather+Buick+Cadillac+Pontiac+Saab+convertible+hatchback+sedan, data=cars)
                
                ## Render summary of model created
                output$summary <- renderPrint({summary(fit)})
                
                ## Render model plots 
                output$plot <- renderPlot({
                        par(mfrow = c(2,2))
                        plot(fit)})
                
                ## Add the documentation for the app
                output$readme <- renderText({
                        "This app creates a multivariate linear regression model using the caret's cars data set. The model created is used to predict the resale price of a car based upon user's inputs in the left panel. 

Input Parameters:
Mileage: number of miles the car has been driven
Cylinder: number of cylinders in the engine        
Doors: number of doors	
Leather: indicator variable representing whether the car has leather seats (1 = leather)
Make: manufacturer of the car such as Saturn, Pontiac, and Chevrolet
Type: body type such as sedan, coupe, etc."
                })
                
                ## Extract user inputs from ui.R and preidict the price usinf the
                ## regression model generated above
                output$prediction <- renderText({ 
                        input$predictprice
                        isolate({
                                mileage <- as.integer(input$mileage); 
                                cyl <- as.integer(input$cyl)
                                doors <- as.integer(input$doors)
                                leather <- input$leather
                                make <- input$make
                                type <- input$type
                                
                                if(leather == 'Yes'){
                                        leather =1
                                } else {
                                        leather = 0
                                }
                                buick <- 0
                                cadillac <- 0
                                pontiac <- 0
                                saab=0
                                if(make == 'Buick')
                                        buick <- 1
                                else if (make == 'Cadillac')
                                        cadillac <- 1
                                else if (make == 'Pontiac')
                                        pontiac <- 1
                                else if (make == 'Saab')
                                        saab <- 1
                                
                                conv <- 0
                                hb <- 0
                                sedan <- 0
                                if(type == 'convertible')
                                        conv <- 1
                                else if(type == 'hatchback')
                                        hb <- 1
                                else if (type == 'sedan')
                                        sedan = 1 
                                
                                newData <- data.frame(Mileage=mileage, 
                                                      Cylinder= cyl,
                                                      Doors = doors,
                                                      Cruise = 0,
                                                      Sound = 0,
                                                      Leather = leather,
                                                      Buick = buick,
                                                      Cadillac = cadillac,
                                                      Chevy=0,
                                                      Pontiac = pontiac,
                                                      Saab = saab,
                                                      Saturn=0,
                                                      convertible = conv,
                                                      coupe = 0,
                                                      hatchback = hb,
                                                      sedan = sedan,
                                                      wagon=0)
                                        
                                predict(fit, newData)
                        })
                })
                   
                
                                        
        }
)