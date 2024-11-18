library(tidyverse)

fluidPage(
  navbarPage(
    titlePanel("Comparing UW Volleyball from 2023 to 2024 Seasons"),
      
      tabPanel("Introduction",
               
               h2("Major Questions"),
               br(),
               
               p("The primary goal......"),
               br(),
               
               h4("How does UW Volleyball compare in key Statistics from 2023 to 2024"),
               p("blah blah blah"),
               br(),
               
               h4("What are UW Weakest Defending Points?"),
               p("blah blah blah"),
               br(),
               
               h4("What is UW's Win/Loss Count?"),
               p("By compiling an additional set of dataframes comprised of match data from the 2023 and 2024 seasons, we can end our analysis on a wider note. 
                 Simply asking, is the team encountering more, or less success? By comparing these statistics, and factoring in our previous analysis of more
                 specific variables, we can gain a start-to-finish view of the teams progression."),
               br(),
               
               h2("About the data"),
               br(),
               
               p("the data came from....."),
               # Win/Loss statistics were gathered from https://gohuskies.com/sports/womens-volleyball/, with no data added when compiling into a streamlined CSV file. 
               
               p("When discussing the results of this data...."),
               br()
          ),
    # make different options to choose which stats to look at 
    # show average option
    tabPanel("Chart 1",
             h1("How does UW Compare in key stats from 2023 - 2023"),
             p("fill this in later....."),
             ),
    tabPanel("Chart 2",
             h1("What are UW's weakest defending points?"),
             p("Fill this in later....."),
             ),
    tabPanel("Chart 3",
             h1("Comparing UW's Win-loss from 2023 to 2024"),
             p("fill this in Later...."),
             plotOutput("WinLoss")
             ),
    tabPanel("Summary",
             h2("Key Takeaways/Conclusion")
             )
  )
  )
  
  
  
  
  
  
  
  
  
  
  
