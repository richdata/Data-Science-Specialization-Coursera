generateLottery = function(balls, draws) {
  if(draws > balls){
    print("Number of balls needs to be greater than the number of balls drawn", quote = F)
  }
  else { sample(1:balls, draws) }
  
  
}

shinyServer(
  function(input, output){
    output$ballsValue = renderPrint({input$balls})
    output$drawsValue = renderPrint({input$draws})
    output$lotteryNumbers = renderPrint({generateLottery(input$balls, input$draws)})
  }
  )