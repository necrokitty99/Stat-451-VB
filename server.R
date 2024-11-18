library(tidyverse)
library(ggplot2)
library(gridExtra)
library(cowplot)
library(dplyr)
library(stringr)
library(reshape2)
library(shiny)

#opponent attack type data
attack_data <- data.frame(
  Play = c("Go", "Red", "Hut", "Mak", "Quick", "Gap", "Slide", "Bic", "Total"),
  ATT = c(895, 457, 593, 163, 235, 210, 161, 99, 3341),
  K_Percent = c("38%", "42%", "25%", "22%", "51%", "42%", "42%", "35%", "36%"),
  E_Percent = c("9%", "7%", "12%", "15%", "5%", "6%", "12%", "17%", "9%"),
  B_Percent = c("6%", "5%", "6%", "6%", "5%", "5%", "7%", "4%", "6%"),
  Eff = c(22.9, 30.4, 7.6, 1.8, 41.7, 31.4, 23.6, 14.1, 21.6),
  FBSO = c(0.222, 0.299, 0.075, -0.075, 0.408, 0.308, 0.206, 0.186, 0.222),
  Trans = c(0.237, 0.312, 0.076, 0.049, 0.430, 0.323, 0.296, 0.107, 0.210)
)

#opponent attack type transformations
attack_data$B_Percent <- as.numeric(sub("%", "", attack_data$B_Percent))

attack_data$K_Percent <- as.numeric(sub("%", "", attack_data$K_Percent))

attack_data <- attack_data[attack_data$Play != "Total", ]

attack_data_long2 <- melt(attack_data, id.vars = "Play", measure.vars = c("K_Percent", "Eff", "B_Percent"),
                          variable.name = "Metric", value.name = "Value")


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
  output$opponent_data <- renderPlot({
    ggplot(attack_data_long2, aes(x = Play, y = Value, fill = Metric)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      labs(title = "What plays are UW volleyball weak against?", x = "Play Type", y = "Kills / Efficiency / Blocks (%)") +
      scale_fill_manual(values = c("skyblue", "orange", "purple"), labels = c("Kills (%)", "Efficiency (%)", "Blocks (%)")) +
      theme_light() +
      theme(legend.title = element_blank())
  })

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

