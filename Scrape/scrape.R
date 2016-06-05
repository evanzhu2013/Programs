
# Date Created: 2016-06-03
# Version: 1.1
# Date Last modified: 2016-06-04

library(rvest)
library(dplyr)
library(readr)
library(stringr)

if(!require('rvest')){
    install.packages('rvest')
    require('rvest')
}

if(!require('dplyr')){
    install.packages('dplyr')
    require('dplyr')
}

if(!require('readr')){
    install.packages('readr')
    require('readr')
}

if(!require('stringr')){
    install.packages('stringr')
    require('stringr')
}

getwd()

html <- read_html('http://www.billboard.com/charts/country-airplay/2016-05-28') %>% html_nodes(css='.chart-row__current-week,.chart-row__song,.chart-row__artist, .chart-row__stats ') %>% html_text %>% gsub('\n','',.) %>% str_trim(side = "both") %>% print

cbind(
    html[seq(1,length(html),4)],
    html[seq(2,length(html),4)],
    html[seq(3,length(html),4)],
    html[seq(4,length(html),4)]  %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(2),
    html[seq(4,length(html),4)] %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(3),
    html[seq(4,length(html),4)] %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(4)
    ) %>% as.data.frame() %>% mutate(rank_currentweek=V1,songs=V2,artist=V3,rank_lastweek=V4,rank_peak=V5,rank_onchart=V6) %>% select(rank_currentweek:rank_onchart) %>% write_csv('billboard.csv')
