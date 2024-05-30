## loading data
```{r}
library(tidyverse)
library(dplyr)

## url to raw data page of gayborhood data on github
data_url <- "https://raw.githubusercontent.com/the-pudding/data/master/gayborhoods/data.csv"

## reading the data into a dataset for analysis using the raw data url
dataset <- read.csv(data_url)
```

## Value 1: percent of married FF couples to total FF couples per zip code
# printed value is the average percent across all zipcodes
```{r}
## creates new columns in original dataset with total FF households and total MM households per zipcode
dataset <- dataset %>% mutate(total_FF = Mjoint_FF + Cns_UPFF)
dataset <- dataset %>% mutate(total_MM = Mjoint_MM + Cns_UPMM)

## creates new column in data set calculating the ratio of married / unmarried FF couples per row (zipcode)
dataset <- dataset %>% mutate(FF_percent = Mjoint_FF / total_FF)
print(mean(dataset$FF_percent, na.rm = TRUE))
```

## Value 2: Ratio of married MM couples to unmarried MM couples per zip code
# printed value is the average ratio across all zipcodes
```{r}
## creates new column in data set calculating the ratio of married / unmarried FF couples per row (zipcode)
dataset <- dataset %>% mutate(MM_percent = Mjoint_MM / total_MM)
print(mean(dataset$MM_percent, na.rm = TRUE))
```

## Value 3: % of total FF couples that are married
```{r}
## creates a new dataset showing summary statistics of the total married and total unmarried households in the data for MM and FF
totals <- summarise(dataset, married_FF = sum(Mjoint_FF), married_MM = sum(Mjoint_MM), unmarried_FF = sum(Cns_UPFF), unmarried_MM = sum(Cns_UPMM))

## added a column for the total MM hosueholds and FF households to the totals dataset
totals <- totals %>% mutate(MM_households = unmarried_MM + married_MM)
totals <- totals %>% mutate(FF_households = unmarried_FF + married_FF)

# prints the married FF ratio
FF_married_percent <- totals$married_FF / totals$FF_households
print(FF_married_percent)
```

## Value 4: % of total MM couples that are married
```{r}
## calculated % MM couples that are married
MM_married_percent <- totals$married_MM / totals$MM_households
print(MM_married_percent)
```

## Value 5: ratio of % FF married couples vs % of MM married couples
```{r}
## calculated % FF couples that are married
print(FF_married_percent / MM_married_percent)
```

## Value 6: number of zipcodes with higher % FF
```{r}
## new dataset only including rows where the total FF households is higher than MM households
high_FF_areas <- dataset %>% filter(total_FF > total_MM)
num_higher_FF <- nrow(high_FF_areas)
print(num_higher_FF)
```

## Value 7: number of zipcodes with higher % MM
```{r}
## new dataset only including rows where the total MM households is higher than FF households
high_MM_areas <- dataset %>% filter(total_MM > total_FF)
num_higher_MM <- nrow(high_MM_areas)
print(num_higher_MM)
```

## Value 8: ratio of zipcodes higher FF to higher MM
```{r}
## finds the ratio 
FF_to_MM_ratio <- num_higher_FF / num_higher_MM
print(FF_to_MM_ratio)
```
