library(shiny)
library(rCharts)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
  
# Application title
headerPanel("Car Fuel Consumption Prediction"),

# Sidebar with controls to make a selection
sidebarPanel(    

  
          selectInput('Car', h6('Select a Car and Click the Data Panel:'), 
          choices = c('All Cars' = '  ','AMC Javelin' = 'AMC Javelin','Cadillac Fleetwood' = 'Cadillac Fleetwood',
                      'Camaro Z28' = 'Camaro Z28','Chrysler Imperial' = 'Chrysler Imperial','Datsun 710' = 'Datsun 710',
                      'Dodge Challenger' = 'Dodge Challenger','Duster 360' = 'Duster 360','Ferrari Dino' = 'Ferrari Dino',
                      'Fiat X1-9' = 'Fiat X1-9','Ford Pantera L' = 'Ford Pantera L','Honda Civic' = 'Honda Civic',
                      'Hornet 4 Drive' = 'Hornet 4 Drive','Hornet Sportabout' = 'Hornet Sportabout','Lincoln Continental' = 'Lincoln Continental',
                      'Lotus Europa' = 'Lotus Europa','Maserati Bora' = 'Maserati Bora','Mazda RX4' = 'Mazda RX4',
                      'Mazda RX4 Wag' = 'Mazda RX4 Wag','Mercedes 230' = 'Merc 230','Mercedes 2400' = 'Merc 240D',
                      'Mercedes 280' = 'Merc 280','Mercedes 280C' = 'Merc 280C','Mercedes 450SE' = 'Merc 450SE','Mercedes 450SL' = 'Merc 450SL',
                      'Mercedes 450SLC' = 'Merc 450SLC','Pontiac Firebird' = 'Pontiac Firebird','Porsche 914-2' = 'Porsche 914-2',
                      'Toyota Corolla' = 'Toyota Corolla','Toyota Corona' = 'Toyota Corona','Valiant' = 'Valiant'),selected = ""),

#           actionButton("goButton", "Go!"),
          br(),
          
          radioButtons("Transmission", h6("Select Transmission and Click the Data Panel:"),list("Automatic and Manual"= "BLANK ", "Automatic" = "1","Manual" = "0"), selected = ""),         
          br(),
          
          sliderInput("WIn",h6("Select Weight(1,000 Pounds) and Click the Prediction Panel:"),value = 3.2,min = 1.5,max = 5.5)),
          
mainPanel(
        tabsetPanel(        
            tabPanel("Question", 
               h6("I. Introduction"),
               p("The Car Fuel Consumption Prediction data product is a statistical regression model that predicts car fuel consumption, Miles Per Gallon (MPG). 
                 The data source is the 1974 motor trend US magazine. The sample includes 32 automobiles (1973-74 models). 
                 The features comprise 10 characteristics of automobile design and performance, including automatic and manual transmission."), 
               h6("II. Methodology"),
               p("The approach is:"), 
               p("1. Question: predict MPG in function of weight variable "),
               p("2. Exploratory Data Analysis: Feature analysis (summary and plots). MPG and weight correlation coefficient 
                   is relatively high (-0.87)"),
               p("3. Simple Linear Regression Model: Algorithm definition and evaluation. Equation for MPG Prediction = 37.29 - 5.34 * Weight"), 
               p("4. Testing and ANOVA: t Student test: true difference in means between automatic and manual transmission: 24.39 versus 17.15 MPG."), 
               h6("III. Results"),
               p("The prediction is performed using the weight input slider reactive function and linear regression equation."), 
               h6("IV. Conclusion"),
               p("The exploratory data analysis, results, equation, and prediction confirm the relationship between MPG (outcome) and weight."), 
               strong("Important Note:",style = "color:red"),
               em("Package shiny was built under R version 3.1.2",style = "color:blue")),
            tabPanel("Data", 
               h6("Car Brand"),
               textOutput("Car"),
               h6("Transmission"),
               textOutput("Transmission"), 
               h6("Record List"),
               dataTableOutput(outputId="table"),downloadButton('downloadData', 'Download')),
            tabPanel("Features - Summary", 
               h6("Summary"),
               p(em("Miles Per Gallon/mpg, Displacement (cu.in.)/disp, Rear axle ratio/drat, Weight (lb/1000)/wt, Transmission (0 = automatic, 1 = manual)/am"),
                 style = "color:blue"),
               verbatimTextOutput("summary"),
               h6("Observations"),
               dataTableOutput(outputId="view")),
            tabPanel("Features - Plots",
               h3('Boxplot', align = "center"),
               plotOutput("plot"),
               h3('Scatterplot Matrix', align = "center"),
               plotOutput("splot")),
            tabPanel("Algorithm - Evaluation", 
               h6('Simple Linear Regression Model', align = "center"),
               br(),
               h6('Algorithm', align = "center"),
               textOutput("text2"),
               br(),
               h6('t Student Test', align = "center"),
               textOutput("text3"),
               br(),
               h6('ANOVA (Analysis Of Variance)', align = "center"),
               textOutput("text4")),
          tabPanel("Prediction", 
               h6('Simple Linear Equation', align = "center"),
               textOutput("equation"),
               h6('Selected Weight', align = "center"), 
               textOutput("inputValue"),
               h6('MPG Prediction', align = "center"), 
               textOutput("prediction"),
               h6('Scatterplot and Fit Line', align = "center"),
               plotOutput("plotwmpg")),
          
          tabPanel("Help",
             h6("What is the Car Fuel Consumption Prediction Data Product?"),
             helpText("The Car Fuel Consumption Prediction data product represents a simple regression model that predicts Miles Per Gallon (MPG)"),
             h6("How to View the Panels?"),
             helpText("1. Open the application. The user interface becomes visible."), 
             helpText("2. Click the tab of interest. You have the choice to view Question, or Data, or Features-Summary, or Features-Plots, or Algorithm-Evaluation, 
             or Prediction, or Help tab."),
             h6("How to Use the Widgets?"),
             helpText("1. Select a car and click the Data Panel. 
                          You see the selected car. Enter the car name in the box named CAR under the record list.
                          Press ENTER. The result set is displayed. To view all cars erase the CAR box"),
             helpText("2. Select a transmission type and click the Data Panel. 
                          You see the selected transmission (0 or 1).
                          Enter 0 or 1 in the box named TRANS under the record list. 
                          Press ENTER. The result set is displayed. 
                          To view all transmmission types, erase the TRANS box"),
             helpText("3. Click the Summary - Data Panel to see some features summary as well as observations"),
             helpText("4. Click the Summary - Plots to see the MPG/Transmission boxplot and some feature correlations"),          
             helpText("5. Click the Prediction Panel.
                          Move the Input Slider to a desired weight.
                          Observe the selected weight reactive display as well as the MPG prediction.")),
          
          tabPanel("About",
                   h6("About The Car Fuel Consumption Prediction Data Product"),
                   helpText("Copyright (c) 2014 Jean-Rene Ndeki (Author)"),
                   br(),      
                   helpText("Permission is hereby granted, free of charge, to any person obtaining
                            a copy of this software and associated documentation files, 
                            to deal in the Software without restriction, including
                            without limitation the rights to use, copy, modify, merge, publish,
                            distribute, sublicense, and to permit persons to whom the Software 
                            is furnished to do so, subject to the following conditions:"),
                   br(),         
                   helpText("The above copyright notice and this permission notice shall be
                            included in all copies or substantial portions of the Software."),
                   br(),         
                   helpText("THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
                            EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
                            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
                            SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
                            DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
                            OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
                            OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."))
        )
    )
))