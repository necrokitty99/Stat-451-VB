library(tidyverse)
library(shiny)
library(bslib)

fluidPage(
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
                 tags$li("Attacking Efficiency  is calculated by \\(\\frac{\\text{number of kills - number of errors}}{\\text{attacking attempts}}\\), and depicts how well a team is hitting the ball"), 
                 tags$li("Passing efficiency  is rated on a 3 point scale defined as: ",
                      tags$ul(
                        tags$li("3 pt - Perfect/Good"),
                        tags$li("2 pt - Medium"),
                        tags$li("1 pt - Bad"),
                        tags$li("0 pt - Aced")
                      ),
                      "This determines how well a team is receiving a serve."),
                 tags$li("Ace Percentage is the amount of aces a team gets divided by the total number of serves.
                 An ace is defined by the ball either hitting the floor on a serve or it is unable to be played past the first contact off of the serve")
               ),
               br(),
               
               h4("What are UW Weakest Defending Points?"),
               p("blah blah blah"),
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
    # make different options to choose which stats to look at 
    # show average option
    tabPanel("Key Stats",
             h1("How does UW Compare in key stats from 2023 - 2024?"),
             p("These charts will show the key statistics for UW Vollyball from 2023 - 2024. "),
             sidebarLayout(
               sidebarPanel(
                 h3("Select a Statistic"),
                 selectInput(
                   inputId = "statistic",
                   label = "Statistic",
                   choices = c("Attacking Efficiency","Passing Efficiency","Ace Percentage"),
                   selected = "Attacking Efficiency",
                  )
               ),
               mainPanel(plotlyOutput("graph1"),
                         uiOutput("dynamicCaption")),
          ),
    ),
    tabPanel("Defense",
             h1("What are UW's weakest defending points?"),
             p("Fill this in later....."),
             ),
    tabPanel("Wins and Losses",
             h1("Comparing UW's Win-loss from 2023 to 2024"),
             p("This chart demonstrates the difference in how the season has gone in both the current season, and last years season."),
             plotOutput("WinLoss")
             ),
    tabPanel("Summary",
             h2("Conclusion"),
             p("Overall, looking at the key stats and win losses, the UW Volleyball team is looking to have a better season in 2024 compared to 2023.
               They have a higher attacking efficiency, higher passing efficiency, and more wins than in 2023. 
               This could be do to a number of reasons such as:"),
               tags$ul(
                 tags$li("Roster Expansion: the addition of new recruits and transfers to the team"),
                 tags$li("Conference Realignment: UW moved to the Big Ten from the Pac 12"),
                 tags$li("Injury Prevention and Recovery"),
                 tags$li("Improvements during Spring Training"),
               ),
               p("While we are not looking at the data from the whole season, it seems that
               UW is trending towards a more successful season compared to 2023. ")
             )
  )
  )
  
  
  
  
  
  
  
  
  
  
  
