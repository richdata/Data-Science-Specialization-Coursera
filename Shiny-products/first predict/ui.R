library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Get Lottery Numbers"),
  sidebarPanel(
    h1('Here are your lottery numbers!!!'),
    h6('To run this app please enter the number of balls that will be used in the lottery in the first text box and then enter the number of balls to be drawn out from this number of balls. You will be returned randomly generated lottery numbers.'),
    numericInput('balls', 'Highest Number of Balls', 50, min = 1, max = 100, step = 1),
    numericInput('draws', 'Number of balls drawn', 5, min = 1, max = 10, step = 1),
    submitButton('See Your Numbers')
  ),
  mainPanel(
    h3('Results of lottery'),
    h4('Number of balls in lottery'),
    verbatimTextOutput('ballsValue'),
    h4('Number of balls drawn'),
    verbatimTextOutput('drawsValue'),
    h4("Your Lottery Numbers"),
    verbatimTextOutput('lotteryNumbers')
  )
))