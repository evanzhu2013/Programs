
library(shiny)
library(ggplot2)
par(mar = c(5,6,2,1),family = "STXihei",mgp=c(2.5,1,0),xaxs='r')
opar=par(no.readonly=T)
options(digits=3)

shinyServer(function(input,output){

    output$hist <- renderPlot({
    inFile <- input$uploadFile

    if (is.null(inFile))
         return(NULL)
    userData <- read.csv(inFile$datapath,header= T)
    # attach(userData)
    output$variable <- renderUI({
    variableList <- unique(as.character(names(userData)))
    selectInput('variables','Choose variable',variableList)
  })

    switch(input$journal,
      'BMJ' = hist(userData[input$variable],main=input$title,xlab=input$xlab,ylab=input$ylab),
      'CMJ' =
          qplot(userData[input$variable],xlab=input$xlab,ylab=input$ylab,col='red'),
      "JAMA" =  hist(userData[input$variable],main=input$title,xlab=input$xlab,ylab=input$ylab,col='lightblue'))
    })

    # output$downloadData <- downloadHandler(
    #
    #       filename <- function() {
    #       paste("hist", Sys.Date(),".png",sep="") },
    #
    #       content <- function(file) {
    #       png(file, width = 980, height = 400,units = "px", pointsize = 12,bg = "white", res = NA)
    #
    #       myhist() <- renderPlot({
    #
    #       inFile <- input$uploadFile
    #       if (is.null(inFile))
    #            return(NULL)
    #       userData <- read.csv(inFile$datapath,header= T)
    #       hist <- hist(rnorm(userData[,2]),main=input$title,xlab=input$xlab,ylab=input$ylab)
    #       })
    #
    #       myhist <- myhist()
    #         print(myhist)
    #           dev.off()},
    #       contentType = 'image/png')
      }
      )
