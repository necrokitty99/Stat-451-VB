library(tidyverse)
library(ggplot2)
library(gridExtra)
library(cowplot)
library(dplyr)
library(stringr)

# Chart 1/2 Data
vball <- read.csv("UWVBStats.csv")

teamStats <- vball %>% filter(Players == 'Team')

teamStats <- teamStats %>%
  mutate(Year = as.factor(Year))

teamStats <- teamStats %>% mutate(Ace.Percentage = as.numeric(gsub("%", "", Ace.Percentage)))

# Chart 3 Data
WinLoss24 <- read.csv("UW Volleyball 2024 WinLoss Stats.csv")
WinLoss23 <- read.csv("UW Volleyball 2023 WinLoss Stats.csv")

function(input, output) {
  # Chart 1 Code

  # Chart 2 Code

  # Chart 3 Code
  output$WinLoss <- renderPlot({
    ggplot() + 
    geom_line(data=VB24, aes(x=Game.Number, y=Cumulative.Wins, color="2024"), linewidth=1) + 
    geom_line(data=VB23, aes(x=Game.Number, y=Cumulative.Wins, color="2023"), linewidth=1) +
    scale_color_manual(name = "Year", values = c("2024" = "blue", "2023" = "red")) +
    scale_x_continuous(n.breaks=16) + scale_y_continuous(n.breaks=18) + 
    xlab("Game Number") + ylab("Cumulative Wins in Season") +
    labs(title="Total Wins Through Season")
  })
    
}

