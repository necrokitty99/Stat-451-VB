library(tidyverse)
library(ggplot2)
library(gridExtra)
library(cowplot)
library(dplyr)
library(stringr)
library(reshape2)
library(plotly)
library(shiny)

#opponent attack type data
attack_data_2023 <- data.frame(
  Play = c("Go", "Red", "Hut", "Mak", "Quick", "Gap", "Slide", "Bic", "Total"),
  ATT = c(895, 457, 593, 163, 235, 210, 161, 99, 3341),
  Kills = c(38, 42, 25, 22, 51, 42, 42, 35, 36),
  Efficiency = c(9, 7, 12, 15, 5, 6, 12, 17, 9),
  Blocks = c(6, 5, 6, 6, 5, 5, 7, 4, 6),
  Efficiency = c(22.9, 30.4, 7.6, 1.8, 41.7, 31.4, 23.6, 14.1, 21.6),
  FBSO = c(0.222, 0.299, 0.075, -0.075, 0.408, 0.308, 0.206, 0.186, 0.222),
  Trans = c(0.237, 0.312, 0.076, 0.049, 0.430, 0.323, 0.296, 0.107, 0.210)
)

attack_data_2023 <- attack_data_2023[attack_data_2023$Play != "Total", ]

attack_data_2023 <- attack_data_2023 %>%
  mutate(Play = fct_reorder(Play, Kills, .desc = TRUE))

# Reshape the data to long format
attack_data_long2_2023 <- melt(attack_data_2023, id.vars = "Play", measure.vars = c("Kills", "Efficiency", "Blocks"),
                               variable.name = "Metric", value.name = "Value") 

attack_data_2024 <- data.frame(
  Play = c("Go", "Red", "Hut", "Mak", "Quick", "Gap", "Slide", "Bic"),
  ATT = c(580, 263, 218, 55, 132, 113, 159, 62),
  Kills = c(32, 40, 24, 33, 37, 43, 42, 27),
  Efficiency = c(9, 11, 7, 7, 7, 6, 6, 16),
  Blocks = c(10, 8, 8, 5, 3, 4, 5, 3),
  Efficiency = c(12.9, 19.8, 8.7, 20.0, 27.3, 32.7, 31.4, 8.1),
  FBSO = c(0.197, 0.204, 0.103, 0.444, 0.189, 0.333, 0.316, 0.138),
  Trans = c(0.049, 0.188, 0.081, 0.152, 0.452, 0.319, 0.311, 0.030)
)

attack_data_2024 <- attack_data_2024 %>%
  mutate(Play = fct_reorder(Play, Kills, .desc = TRUE))

attack_data_long2_2024 <- melt(attack_data_2024, id.vars = "Play", measure.vars = c("Kills", "Efficiency", "Blocks"),
                               variable.name = "Metric", value.name = "Value") 

# Chart 1/2 Data
vball <- read.csv("downloads/UWVBStats.csv")

teamStats <- vball %>% filter(Players == 'Team')

teamStats <- teamStats %>%
  mutate(Year = as.factor(Year))

teamStats <- teamStats %>% mutate(Ace.Percentage = as.numeric(gsub("%", "", Ace.Percentage)))

# Chart 3 Data
WinLoss24 <- read.csv("downloads/UW Volleyball 2024 WinLoss Stats.csv")
WinLoss23 <- read.csv("downloads/UW Volleyball 2023 WinLoss Stats.csv")

server<- function(input, output) {
  # Chart 1 Code
  output$graph1 <- renderPlotly({
    # Initialize plot to NULL
    plot <- NULL
    
    # Check which statistic is selected and create the plot accordingly
    if (input$statistic == 'Attacking Efficiency') {
      plot <- ggplot(data = teamStats, aes(x = Year, y = Eff, fill = Year)) + 
        geom_bar(stat = "identity", position = "dodge", color = "black", fill = c("yellow", "purple")) + 
        ylab("Attacking Efficiency") + 
        labs(title = "Attacking Efficiency Over Time") +
        scale_y_continuous(breaks = seq(0, 0.4, by = 0.05), limits = c(0, 0.4)) +
        theme_minimal(base_size = 10) +
        theme(
          plot.title = element_text(size = 16, face = "bold"),
          axis.text.x = element_text(angle = 45, hjust = 1)
        ) 
      
    } else if (input$statistic == 'Passing Efficiency') {
      plot <- ggplot(data = teamStats, aes(x = Year, y = Pass.Average, fill = Year)) + 
        geom_bar(stat = "identity", position = "dodge", color = "black", fill = c("yellow", "purple")) + 
        ylab("Average Passing (3-pt Scale)") + 
        labs(title = "Passing Efficiency Over Time") +
        scale_y_continuous(breaks = seq(0, 3, by = 1), limits = c(0, 3)) + 
        theme_minimal(base_size = 10) +
        theme(
          plot.title = element_text(size = 16, face = "bold"),
          axis.text.x = element_text(angle = 45, hjust = 1)
        )
      
    } else if (input$statistic == 'Ace Percentage') {
      plot <- ggplot(data = teamStats, aes(x = Year, y = Ace.Percentage, fill = Year)) + 
        geom_bar(stat = "identity", position = "dodge", color = "black", fill = c("yellow", "purple")) + 
        ylab("Ace Percentage (%)") + 
        labs(title = "Ace Percentage Over Time") +
        scale_y_continuous(breaks = seq(0, 50, by = 5), limits = c(0, 50)) + 
        theme_minimal(base_size = 10) +
        theme(
          plot.title = element_text(size = 16, face = "bold"),
          axis.text.x = element_text(angle = 45, hjust = 1)
        )
    }
    
    # Convert the ggplot object to a plotly object for interactivity
    ggplotly(plot, tooltip = c("x", "y"))  
  })
 ####
  output$dynamicCaption <- renderUI({
    if (input$statistic == "Attacking Efficiency") {
      p("The team has a higher attacking efficiency in 2024 compared to 2023. This means the team is scoring more efficiently on their attacking.
        Comparing to other teams in the NCAA, in 2024, UW is in the top 75, while in 2023, they were in the top 130.")
    } else if (input$statistic == "Passing Efficiency") {
      p("The team has a slightly higher passing efficiency in 2024 compared to 2023. However, the difference isn't enough to show a huge change. 
        Both seasons, the team passed just slightly better than medium on average.")
    } else if (input$statistic == "Ace Percentage") {
      p("The team has a slighly higher ace percentage in 2023 than in 2024. However, with the difference being so slight, the team is scoring similarly through their serving.")
    }
  })
 ####
  # Chart 2 Code
  output$Defense <- renderPlotly({
    if (input$Year == "2023") {
      gg_2023 <- ggplot(attack_data_long2_2023, aes(x = Play, y = Value, fill = Metric)) +
        geom_bar(stat = "identity", position = "dodge") +
        labs(title = "Opponent Weakness by Play Type (2023)", x = "Play Type", y = "Value (%)") +
        scale_fill_manual(values = c("skyblue", "orange", "purple")) +
        theme_minimal()
      ggplotly(gg_2023,)
    } else if (input$Year == "2024") {
      gg_2024 <- ggplot(attack_data_long2_2024, aes(x = Play, y = Value, fill = Metric)) +
        geom_bar(stat = "identity", position = "dodge") +
        labs(title = "Opponent Weakness by Play Type (2024)", x = "Play Type", y = "Value (%)") +
        scale_fill_manual(values = c("skyblue", "orange", "purple")) +
        theme_minimal()
      ggplotly(gg_2024)
    }
  })
  
  # Chart 3 Code
  output$WinLoss <- renderPlotly({
    plot1 <- ggplot() + 
      geom_line(data=WinLoss24, aes(x=Game.Number, y=Cumulative.Wins, color=factor(2024), label=Opponent), size=1) + 
      geom_line(data=WinLoss23, aes(x=Game.Number, y=Cumulative.Wins, color=factor(2023), label=Opponent), size=1) +
      scale_color_manual(name="Year", values=c("2024"="purple", "2023"="gold")) +
      scale_x_continuous(n.breaks=16) +
      scale_y_continuous(n.breaks=18) +
      xlab("Game Number") +
      ylab("Cumulative Wins in Season") +
      labs(title="Total Wins Through Season")

  ggplotly(plot1, tooltip=c("x", "y", "label"))
  })
    
}

