library(shiny)
library(ggplot2)
library(tidyverse)
library(plotly)
library(rsconnect)

ui <- fluidPage(
  h1("Gayborhood Statistics", align = "center"),
  mainPanel(
    tabsetPanel(
      tabPanel("Introduction", includeHTML("intro.Rhtml")),
      tabPanel("Page 1", plotlyOutput("plot1"),
               checkboxInput(inputId = "checkbox1", label = "Female", value = FALSE)),
      tabPanel("Page 2", plotlyOutput("plot2"), 
               checkboxInput(inputId = "checkbox2", label = "Married", value = TRUE)),
      tabPanel("Page 3", plotlyOutput("plot3"),
               checkboxInput(inputId = "checkbox3", label = "Female", value = FALSE)),
      tabPanel("Conclusion", includeHTML("conclusion.Rhtml")),
    )
  )
)  
