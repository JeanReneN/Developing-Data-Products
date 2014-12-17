---
title       : Car Fuel Consumption Prediction
subtitle    : Peer Assessment
author      : Jean Rene Ndeki, Data Scientist
job         : Coursera
framework   : io2012        # {io2012, html5slides, shower, dzslides,revealjs, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

- The Car Fuel Consumption Prediction is a regression model
- The data product forecasts Miles Per Gallon (MPG)
- The study and development follow the approach below

## Outline

- Question
- Data
- Features
- Algorithm
- Evaluation
- Prediction

--- .class #id 

## Question

- How many Miles Per Gallon (MPG) can a car travel?
- A simple linear regression model answers the question 
- The data product uses the weight variable to predict MPG 

## Data

- The data source is the 1974 motor trend US magazine
- The data sample includes 32 automobiles 
- The cars are 1973-74 models

## Features

- The features comprise 10 characteristics 
- They are automobile design and performance
- They also include automatic and manual transmission

---.class #id 

## Algorithm and Evaluation

### Algorithm - Simple Linear Regression 

```r
fit<-lm(mpg ~ wt, data = mtcars)
```

### Equation 

```
## [1] "Miles Per Gallon Prediction = 37.29 - 5.34 * weight"
```

### Testing - t Student

```r
t.test(mpg ~ am, data = mtcars)
```

### Analysis Of Variance - ANOVA 

```r
anova(lm(mpg~am, data = mtcars))
```

---.class #id 

## Prediction

### Example
- A car weight is 3.22 thousand pounds
- The prediction is:
[1] "20 Miles Per Gallon"

![plot of chunk unnamed-chunk-7](assets/fig/unnamed-chunk-7-1.png) 
---
