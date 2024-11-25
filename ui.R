library(tidyverse)
library(shiny)
library(bslib)
library(plotly)

ui <- fluidPage(
  theme = bs_theme(bootswatch = "cerulean"),
  navbarPage(
    titlePanel("UW Volleyball: Analyzing the 2023 and 2024 Seasons"),
    
    tabPanel("Introduction",
             h2("Major Questions"),
             br(),
             p("The primary goal of this project is to analyze and compare the University of Washington Volleyball Team from the 2023 to 2024 season. 
               There are many different statistics in the sport of volleyball, so the statistics looked at show a good look at how the team compares, but is not comprehensive."),
             br(),
             withMathJax(),
             h4("Chart 1: How does UW Volleyball Compare in Key Statistics from 2023 to 2024?"),
             p("To begin comparing the 2023 team and 2024 team, one must look at key statistics in volleyball. The three statistics we decided to look at are 
                    attacking efficiency, passing effciency, and ace percentage."),
             tags$ul(
               tags$li("Attacking Efficiency is calculated by \\(\\frac{\\text{number of kills - number of errors}}{\\text{attacking attempts}}\\), and depicts how well a team is hitting the ball"), 
               tags$li("Passing efficiency is rated on a 3 point scale defined as: ",
                       tags$ul(
                         tags$li("3 pt - Perfect/Good"),
                         tags$li("2 pt - Medium"),
                         tags$li("1 pt - Bad"),
                         tags$li("0 pt - Aced")
                       ),
                       "This determines how well a team is receiving a serve."),
               tags$li("Ace Percentage is the amount of aces a team gets divided by the total number of serves. An ace is defined by the ball either hitting the floor on a serve or it is unable to be played past the first contact off of the serve")
             ),
             br(),
             h4("What are UW's Weakest Defending Points?"),
             p("The analysis highlights that UW Women’s Volleyball team struggles the most in defending against certain play types executed by their opponents. 
               Specifically, in both the 2023 and 2024 seasons, the Quick and Gap plays consistently demonstrate high attacking efficiency (41.7% and 31.4% in 2023; 27.3% and 32.7% in 2024)."),
             br(),
             h4("What is UW's Win/Loss Count?"),
             p("By compiling an additional set of dataframes comprised of match data from the 2023 and 2024 seasons, we can end our analysis on a wider note. 
                 Simply asking, is the team encountering more, or less success? By comparing these statistics, and factoring in our previous analysis of more
                 specific variables, we can gain a start-to-finish view of the teams progression.
                 Additionally included is the opponent for each game, for further reading."),
             br(),
             h2("About the data"),
             br(),
             p("This data was collected directly from the UW Volleyball Team Technical Coordinator. 
                 During each match it is live coded for all contacts, and then cleaned following the match for accuracy.
                 Additional data was gathered from the UW Volleyball website: gohuskies.com/sports/womens-volleyball/."),
             p("When discussing the results of this data, it is important to note that this data is collected through similar points in the 
                 2023 and 2024 season. The match data for 2023 is collected from August 25th - October 29th, which was 23 matches.
                 The match data for 2024 is collected from August 30th - October 30th, which was 15 matches. However, with scheduling and conference changing,
                 there is less data for the 2024 season, so while we have a good look, we do not have a comprehensive comparison."),
             br()
    ),
    
    # Key Stats Panel
    tabPanel("Key Stats",
             h1("How does UW Compare in Key Stats from 2023 - 2024?"),
             p("These charts will show the key statistics for UW Volleyball from 2023 - 2024."),
             sidebarLayout(
               sidebarPanel(
                 h3("Select a Statistic"),
                 selectInput(
                   inputId = "statistic",
                   label = "Statistic",
                   choices = c("Attacking Efficiency", "Passing Efficiency", "Ace Percentage"),
                   selected = "Attacking Efficiency"
                 )
               ),
               mainPanel(
                 plotlyOutput("graph1"),
                 uiOutput("dynamicCaption")
               )
             )
    ),
    
    # Defense Panel
    tabPanel("Defense",
             h1("What are UW's weakest defending points?"),
             sidebarLayout(
               sidebarPanel(
                 h3("Select a year"),
                 selectInput(
                   inputId = "Year",
                   label = "Year",
                   choices = c("2023", "2024"),
                   selected = "2023"
                 )
               ),
               mainPanel(
                 plotlyOutput("Defense")
               )
             )
    ),
    
    # Season Results Panel
    tabPanel("Season Results",
             h1("How Has the Team Performed Overall This Season?"),
             p("This chart compares the wins and losses of the UW Volleyball team between 2023 - 2024."),
             mainPanel(plotlyOutput("WinLoss"))
    ),
    
    # Summary Panel
    tabPanel("Summary",
             h2("Conclusion"),
             p("Overall, looking at the key stats and win losses, the UW Volleyball team is looking to have a better season in 2024 compared to 2023.
               They have a higher attacking efficiency, higher passing efficiency, and more wins than in 2023. 
               This could be due to a number of reasons such as:"),
             tags$ul(
               tags$li("Roster Expansion: the addition of new recruits and transfers to the team"),
               tags$li("Conference Realignment: UW moved to the Big Ten from the Pac 12"),
               tags$li("Injury Prevention and Recovery"),
               tags$li("Improvements during Spring Training")
             ),
             p("While we are not looking at the data from the whole season, it seems that
               UW is trending towards a more successful season compared to 2023.")
    )
  )
)
  
  
  
  
  
  
  
  
  
  
  
