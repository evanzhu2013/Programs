
# Title : To scrape air quality websites
# Author: Evan Zhu
# Date Created: 16/6/13
# Date Last modified: 16/6/13

rm(list = ls())

setwd('/Users/Evan/DataScience/Programs/Scrape/')

library(dplyr)
library(rvest)
library(stringr)
library(readr)

# To prevent read data again

if ('datasets' %in% ls()) datasets <- data.frame()

scraping <- function(address='北京',startyear= 2014,endyear= 2016,startmonth=1,endmonth=12){
        for (j in startyear:endyear){
                for (i in startmonth:endmonth){
                        url <- paste0('http://www.aqistudy.cn/historydata/daydata.php?city=',address,'&month=',j,'-',str_pad(i,2,side = 'left',pad='0'))
                        data <- url %>% read_html() %>% html_nodes('table') %>% .[[1]] %>% html_table() %>% as.data.frame()
                        datasets <- rbind(datasets,data)
                        Sys.sleep(5)
                }
        }
        datasets
        write.csv(datasets,file=paste0(address,startyear,'-',endyear,'.csv'),fileEncoding = 'GB2312')
}

scraping(address='北京',endyear=2016)
