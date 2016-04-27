
library(shiny)

shinyUI(fluidPage(
  # headerPanel('Minimal example'),
  titlePanel('Minimal example'),
  sidebarLayout(
    sidebarPanel(
      #  sliderInput(inputId='hist_value',label='Numbers',min=50,max=500,value=0,step=1),
      # numericInput("hist_value", "Number of observations to view:", 100),
      fileInput('uploadFile','Upload your own csv file'),
      textInput(inputId='title',label='Title',value=""),
      textInput(inputId='xlab',label='X-lab',value=""),
      textInput(inputId='ylab',label='Y-lab',value=""),
      selectInput('journal','choose Journal',list('BMJ','CMJ',"Jama")),
      submitButton(text = "Produce output")
      # ,downloadButton('downloadData', 'Download')
      ),

  mainPanel(
    h3('This is the histogram'),
    plotOutput('hist')
    # img(src="bigorb.png", height = 400, width = 400)
    )
    )
))
