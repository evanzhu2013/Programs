
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

scraping(address='广州',endyear=2016)


# simpl function

scraping <- function(address='北京',year=NULL,month=null){
        month <- str_pad(month,2,side = 'left',pad='0')
        url <- paste0('http://www.aqistudy.cn/historydata/daydata.php?city=',address,'&month=',year,'-',str_pad(month,2,side = 'left',pad='0'))
        data <- url %>% read_html() %>% html_nodes('table') %>% .[[1]] %>% html_table() %>% as.data.frame()
        Sys.sleep(5)
        return(data)
}

if ('datasets' %in% ls()) datasets <- data.frame()

datasets <- data.frame()

for (j in 2014:2016){
        for (i in 1:12){
                data <- scraping(address='深圳',year=j,month=i)
                datasets <- rbind(datasets,data)
        }
        datasets
}

write.csv(datasets,'~/Desktop/深圳.csv',fileEncoding = 'GB2312')
