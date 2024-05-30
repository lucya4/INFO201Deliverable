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

top5 <- dataset %>% 
  top_n(5, Cns_TotHH) %>% 
  arrange(TaxRate_SS)
zipCode <- top5 %>% pull(GEOID10)

## main server function with chart outputs
function(input, output) {
  
  output$plot1 <- renderPlotly({
    married_by_zipcode <- ggplot(top50)+
      geom_col(mapping = aes(
        x = as.factor(GEOID10),
        y = if(input$checkbox1) FF_percent else MM_percent,
        text = paste("Zipcode:", as.factor(GEOID10))
      )) +
      labs(
        title = "Zipcode vs Ratio of Same-sex Couples",
        x = "Zipcode",
        y = if(input$checkbox1) "Ratio of Female Same-sex Couples" else "Ratio of Male Same-sex Couples"
      )
    
    ggplotly(married_by_zipcode, tooltip = ("text"))
  })
  
  output$plot2 <- renderPlotly({
    chart2 <- ggplot(dataset) +
      geom_smooth(mapping = aes(
        x = Bars_Weight, 
        y = if(input$checkbox2) Mjoint_SS else Cns_RateSS,
      )) +
      labs(
        title = "SS Couples in Relation to Index in Dense Cities",
        x = "Gayborhood Index (weighted bars in area)",
        y = if (input$checkbox2) "Married SS Couples"
        else "Unmarried SS Couples"
      )
  })
  
  output$plot3 <- renderPlotly({
    chart3 <- ggplot(top5) +
      geom_col(mapping = aes(
        x = as.factor(GEOID10), 
        y = if(input$checkbox3) Mjoint_FF else Mjoint_MM,
        text = paste("Registered Married Couples:", if(input$checkbox1) Mjoint_FF else Mjoint_MM)
      )) +
      labs(
        title = "Registered Married Couples in High Density Cities",
        x = "Zipcodes for the 5 Most Populated Cities in the USA",
        y = if (input$checkbox3) "Married Same Sex Female Couples" 
        else "Married Same Sex Male Couples"
      )
    ggplotly(chart3, tooltip = "text") 
  })
  
}