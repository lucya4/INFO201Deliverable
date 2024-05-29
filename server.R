library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(rsconnect)

## read in dataset
dataset <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/gayborhoods/data.csv")

## set up data columns for percentage chart
dataset <- dataset %>% mutate(total_FF = Mjoint_FF + Cns_UPFF)
dataset <- dataset %>% mutate(total_MM = Mjoint_MM + Cns_UPMM)
dataset <- dataset %>% mutate(FF_percent = Mjoint_FF / total_FF)
dataset <- dataset %>% mutate(MM_percent = Mjoint_MM / total_MM)
dataset <- dataset %>% mutate(GEOID = as.factor(GEOID10))
top50 <- dataset %>% top_n(50, Cns_TotHH) %>% arrange(TaxRate_SS)

## Josh's code not sure what it's for
top5 <- dataset %>% top_n(5, Cns_TotHH) %>% arrange(TaxRate_SS)
zipCode <- top5 %>% pull(GEOID10)

## main server function with chart outputs
function(input, output) {
  
  ## Plot for Page 1 October's Code
  output$plot1 <- renderPlotly({
    married_by_zipcode <- ggplot(top50, 
      aes(
        x = GEOID10, 
        y = if(input$checkbox1) FF_percent else MM_percent,
        color = "blue"
      )) +
      geom_bar(stat = "identity") 
    ggplotly(married_by_zipcode)
  })
  
 ## Josh Code
  output$plot2 <- renderPlotly({
    chart2 <- ggplot(top5) +
      geom_smooth(mapping = aes(
        x = TOTINDEX, 
        y = if(input$checkbox2) Mjoint_SS else Cns_RateSS,
        text = paste("# Bars:", CountBars),
        color = "blue"
      )) +
      labs(
        title = "SS Couples in Relation to Index in Dense Cities",
        x = "Gayborhood Index (weighted bars and events in area)",
        y = if (input$checkbox2) "Married SS Couples"
        else "Unmarried SS Couples"
      )
    ggplotly(chart2, tooltip = ("text"))
  })
  
  ## plot for Page 3 Octobers code inspired by Josh
  output$plot3 <- renderPlotly({
    chart3 <- ggplot(top5) +
      geom_smooth(mapping = aes(
        x = GEOID10, 
        y = if(input$checkbox3) Mjoint_FF else Mjoint_MM,
        text = paste("Registered Married Couples:"),
        color = "blue"
      )) +
      labs(
        title = if (input$checkbox3) "Registered Married Couples in high Density Cities",
        x = "GEO ID for the 5 most populated cities in the USA",
        y = if (input$checkbox3) "Married Same Sex Female Couples" 
        else "Married Same Sex Male Couples"
      )
    ggplotly(chart3, tooltip = ("text"))
  })
}