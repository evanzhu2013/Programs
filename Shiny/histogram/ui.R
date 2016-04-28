
library(shiny)

shinyUI(fluidPage(
  # headerPanel('Minimal example'),
  titlePanel('Plot in different Journals '),
  sidebarLayout(
    sidebarPanel(
      #  sliderInput(inputId='hist_value',label='Numbers',min=50,max=500,value=0,step=1),
      # numericInput("hist_value", "Number of observations to view:", 100),
      fileInput('uploadFile','Upload your own csv file'),
      # textInput(inputId='variable',label='choose variable',value='height'),
      uiOutput("variables"),
      textInput(inputId='title',label='Title',value=""),
      textInput(inputId='xlab',label='X-lab',value=""),
      textInput(inputId='ylab',label='Y-lab',value=""),
      selectInput('journal','choose Journal',list('BMJ','CMJ',"JAMA")),
      submitButton(text = "Plot")
      # ,downloadButton('downloadData', 'Download')
      ),

  mainPanel(
    h3('This is the histogram'),
    plotOutput('hist')
    # img(src="bigorb.png", height = 400, width = 400)
    )
    )
))


# 添加文件类型的选择项
# 添加绘制的数据类型
# 添加表格以及数据汇总结果
