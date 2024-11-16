library(tidyverse)
library(ggplot2)
library(gridExtra)
library(cowplot)

# Chart 1/2 Data
vball <- read.csv("UWVBStats.csv")

teamStats <- vball %>% filter(Players == 'Team')

teamStats <- teamStats %>%
  mutate(Year = as.factor(Year))

teamStats <- teamStats %>% mutate(Ace.Percentage = as.numeric(gsub("%", "", Ace.Percentage)))

function(input, output) {
  
  
}

# Chart 3 Data
# tba
