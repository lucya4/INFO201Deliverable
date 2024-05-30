library(shiny)
library(ggplot2)
library(tidyverse)
library(plotly)
library(rsconnect)
library(bslib)

ui <- fluidPage(
  h1("Gayborhood Statistics", align = "center"),
  mainPanel(
    tabsetPanel(
      tabPanel("Introduction", includeHTML("intro.Rhtml")),
      tabPanel("Page 1", 
               plotlyOutput("plot1"),
               checkboxInput(inputId = "checkbox1", label = "Female", value = FALSE),
               hr(),
               div(
                 p(
                   
                 )
               )
            ),
      tabPanel("Page 2", 
               plotlyOutput("plot2"), 
               checkboxInput(inputId = "checkbox2", label = "Married", value = TRUE),
               hr(),
               div(
                 p("Both of these graphs showcase the correlation between the number of gay bars in a particular zipcode and the number of (un)married same-sex couples in that same zipcode. Both graphs indicate a direct relationship between the two variables, which could be for
 a variety of reasons. The most obvious reason to us is that these couples formed in the first place through the bars as an avenue. Having more
 ways to meet potential partners in an area is sure to increase the number of couples. Another potential reason is that a zipcode with more gay
 bars is more likely to be a safe area free from prejudice and discrimination. Homophobia is unfortunately rampant in many areas of the US, and
 so areas with access to queer communities attracts potential couples to move to these areas.")
               )
    ),
      tabPanel("Page 3", 
               plotlyOutput("plot3"),
               checkboxInput(inputId = "checkbox3", label = "Female", value = FALSE),
               hr(),
               div(
                 p("Switching between the male same-sex couples graph and the female same-sex couples graph, we can see that, besides some outlier zipcodes such as 11226(Brooklyn, New York) and 60657(Chicago, Illinois), the zipcodes have relatively the same number of male same-sex couples and female same-sex couples. As for the outliers, these can be explained by those specific zipcodes potentially having more history of clusters of male same-sex couples and vice versa. Besides that, the relative similarity tells us that there aren't real significant differences in patterns between men and women in terms of geographical location.")
                   
                 )
               ),
    tabPanel("Conclusion", includeHTML("conclusion.Rhtml"))
      ),
    ),
  page_navbar(
    theme = bs_theme(version = 5, bootswatch = "minty")
  )
  )
  

  
 
