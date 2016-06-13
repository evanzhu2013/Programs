
# Date Created: 2016-06-03
# Version: 1.1
# Date Last modified: 2016-06-04

# Please install these packages firstly.

library(rvest)
library(dplyr)
library(readr)
library(stringr)


# if(!require('rvest')){
#     install.packages('rvest')
#     require('rvest')
# }
#
# if(!require('dplyr')){
#     install.packages('dplyr')
#     require('dplyr')
# }
#
# if(!require('readr')){
#     install.packages('readr')
#     require('readr')
# }
#
# if(!require('stringr')){
#     install.packages('stringr')
#     require('stringr')
# }

# Set your own work directory

setwd('/Users/Evan/DataScience/Programs/Scrape/')

html <- read_html('http://www.billboard.com/charts/country-airplay/2016-05-28') %>% html_nodes(css='.chart-row')

html_text <- html %>% html_nodes(css='.chart-row__current-week,.chart-row__song,.chart-row__artist, .chart-row__stats') %>% html_text %>% gsub('\n','',.) %>% str_trim(side = "both") %>% print

html_class <- html %>% html_nodes(css='.chart-row__history') %>% str_extract_all('--\\w*') %>% substr(3,9)

html_href <- html %>% html_nodes(css='.chart-row__artist') %>%
html_attr("href")

cbind(
    html_text[seq(1,length(html_text),4)],
    html_text[seq(2,length(html_text),4)],
    html_text[seq(3,length(html_text),4)],
    html_text[seq(4,length(html_text),4)]  %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(2),
    html_text[seq(4,length(html_text),4)] %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(3),
    html_text[seq(4,length(html_text),4)] %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(4),
    html %>% html_nodes(css='.chart-row__history') %>% str_extract_all('--\\w*') %>% substr(3,9),
    html %>% html_nodes(css='.chart-row__artist') %>%
        html_attr("href"),
    html %>% html_nodes(css='.chart-row__image') %>% as.character() %>%  str_extract_all('http://www.billboard.com/images/pref_images/[-A-Za-z0-9]*.jpg') %>% unlist()
) %>% as.data.frame() %>% mutate(rank_currentweek=V1,rank_history_status=V7,songs=V2,artist=V3,artist_intro=V8,artist_pic=V9,rank_lastweek=V4,rank_peak=V5,rank_onchart=V6) %>% select(rank_currentweek:rank_onchart) %>% write_csv('top30.csv')


# 下载文件

file <- read.csv('top30.csv')

if (!dir.exists('pic')){
    dir.create('./pic')
}

setwd('./pic')

filenames <- rep(NA,30)

url <-rep(NA,30)

file$rank_currentweek <- file$rank_currentweek %>% str_pad(width=2,'0',side='left')


# Attention! Windows Users may change the methods argument in function of download.file()

for (i in 1:nrow(file)){

    filenames[i] <-
        paste0(paste(file$rank_currentweek[i],file$artist[i],sep='-'),'.jpg')
    url[i]<- as.character(file$artist_pic[i])
    download.file(url[i],destfile=filenames[i],method='curl')
}

dir() # 查看文件

# 删除下载文件

# file.remove(list.files())
