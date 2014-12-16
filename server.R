library(shiny)
library(data.table)
library(gclus)
library(ggplot2)

data(mtcars)

dfmtcars<-data.frame(mtcars)
colnames(dfmtcars)<-c('MPG','CYLIN','DISPL','GHPWR','RATIO','WEIGHT','MTIME','VS','TRANS','FGEAR','CARBU')

dfmtcars<-cbind(CAR = rownames(dfmtcars), dfmtcars) 

# Define server logic for random distribution application
shinyServer(function(input, output) {
    
  
# 2. Data - Generate an HTML table view of the data
  output$Car<-renderPrint({paste("You have selected: '",input$Car, "' . Please Enter '",input$Car, 
                                          "' in the 'CAR' cell at end of the record list and Press Enter to display the result set.", sep="")})
  
  output$Transmission<-renderPrint({paste("You have selected: '",input$Transmission, "' . Please Enter '",input$Transmission, 
                                          "' in the 'TRANS' cell at end of the record list and Press Enter to display the result set ", sep="")})
  
  output$table <- renderDataTable({dfmtcars}, options = list(bFilter = TRUE, iDisplayLength = 3, searching = TRUE))

# 3. Features - Generate a summary and view of the data
# 3.1 Summary
  output$summary <- renderPrint({summary(mtcars[c(1,3,5,6,9)])}) 

# 3.2 View
  dfmtcars13569<-data.frame(mtcars[c(1,3,5,6,9)])
  output$view <- renderDataTable({(dfmtcars13569)},options = list(bFilter = FALSE, iDisplayLength = 32, searching = FALSE))  

# 4.1 Features - Generate a boxplot
 output$plot <- renderPlot({boxplot(mtcars$mpg ~ mtcars$am, col='green',
                            main = 'MPG by Transmission (Manual-0 versus Automatic-1)', 
                            xlab = 'Transmision', ylab = 'MPG')  
                            })
  
# 4.2 Features - Generate a scatterplot - Scatterplot Matrices from the glus Package 
  dta <- mtcars[c(1,3,5,6)]           # get data 
  dta.r <- abs(cor(dta))              # get correlations
  dta.col <- dmat.color(dta.r)        # get colors
  
# reorder variables so those with highest correlation are the closest to the diagonal
  dta.o <- order.single(dta.r)   

  output$splot <- renderPlot({cpairs(dta, dta.o, panel.colors=dta.col, 
                                     gap=.5, main="Variables Ordered and Colored by Correlation" )})

# 5. Define and Generate Prediction
# 5.1 Algorithm - Simple Linear Regression  
  fit<-lm(mpg ~ wt, data = mtcars)
  output$text2 <- renderPrint({summary(fit)})

# 5.2 Testing (t Student)
  output$text3 <- renderPrint({t.test(mpg ~ am, data = mtcars)})

# 5.3 ANOVA (Analysis Of Variance)
  output$text4 <- renderPrint({anova(lm(mpg~am, data = mtcars))})

# 6 Prediction - Simple Scatterplot and basic function fit line (x, y) using ggplot2
# 6.1 Equation
#   output$equation <- renderPrint({(paste("Mile Per Gallon Prediction Equation = ", paste(paste(round((coef(fit)[1]),digits=2), " - " 
#                                       round((coef(fit)[2]),digits=2), sep=""), " * weight", sep=""),
#                                       sep=""))})

 output$equation <- renderPrint({paste("Mile Per Gallon Prediction Equation = ", 
                                        round((coef(fit)[1]),digits=2),  
                                        " - ",
                                        abs(round((coef(fit)[2]),digits=2)),
                                        " * weight", sep="")
                                 })

# 6.2 Weight Input Value
  output$inputValue <- renderText({paste("Your Selection is: ", (as.numeric(input$WIn)*1000)," Pounds", sep="")})

# 6.3 Calculated Prediction       
  pred <- reactive({round(coef(fit)[1])+(round(coef(fit)[2])*(as.numeric(input$WIn)))})

  output$prediction <- renderText({paste("The Prediction is: ", pred(), " Miles Per Gallon", sep="")})

  output$plotwmpg <- renderPlot({qplot(wt, mpg,  data = mtcars, geom = c("point","smooth"), method = "lm")})

})