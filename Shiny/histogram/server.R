
library(shiny)
par(mar = c(5,6,2,1),family = "STXihei",mgp=c(2.5,1,0),xaxs='r')
opar=par(no.readonly=T)
options(digits=3)

shinyServer(function(input,output){

    output$hist <- renderPlot({
    inFile <- input$uploadFile
    if (is.null(inFile))
         return(NULL)
    userData <- read.csv(inFile$datapath,header= T)
    hist <- hist(rnorm(userData[,2]),main=input$title,xlab=input$xlab,ylab=input$ylab)
    print(hist)
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
