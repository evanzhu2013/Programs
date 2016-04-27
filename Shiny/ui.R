#ui.R#
library(shiny)
options(shiny.maxRequestSize=10*1024^2)

shinyUI(fluidPage(
  titlePanel(h2("Plot",align="center")),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv','text/comma-separated-values,text/plain','.csv'))
    mainPanel(
      plotOutput('newHist')

      )
    )
  )
))
