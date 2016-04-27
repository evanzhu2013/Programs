
library(shiny)
shinyServer(function(input,output){
  output$textDisplay <- renderText({
    paste0("You said' ",input$comment,"' characters in this.'")
    })
  })
