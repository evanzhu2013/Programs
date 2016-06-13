# Date Created: 2016-06-03
# Version: 1.1
# Date Last modified: 2016-06-08

# check to see if libraries need to be installed

libs <- c('rvest','dplyr','readr','stringr')
packages <- sapply(libs,function(x) if(!require(x,character.only=T))
install.packages(packages))

# Set your own work directory

setwd('/Users/Evan/DataScience/Programs/Scrape/')

# Download html
html <- read_html('http://www.billboard.com/charts/country-airplay/2016-05-28')

# Scrape the key information

cbind(
html %>% html_nodes(css='.chart-row__current-week') %>% html_text(),
html %>% html_nodes(css='.chart-row__artist') %>% html_text(trim=T),
html %>% html_nodes(css='.chart-row__song') %>% html_text(),
html %>% html_nodes(css='.chart-row__value') %>% html_text() %>% .[(seq(1,90,3))],
html %>% html_nodes(css='.chart-row__value') %>% html_text() %>% .[(seq(2,90,3))],
html %>% html_nodes(css='.chart-row__value') %>% html_text() %>% .[(seq(3,90,3))],
html %>% html_nodes(css='.chart-row__history') %>% str_extract_all('--\\w*') %>% substr(3,9),
html_href <- html %>% html_nodes(css='.chart-row__artist') %>%
html_attr("href"),
html %>% html_nodes(css='.chart-row__image') %>% as.character() %>%  str_extract_all('http://www.billboard.com/images/pref_images/[-A-Za-z0-9]*.jpg') %>% unlist()
) %>% as.data.frame() %>% mutate(rank_currentweek=V1,rank_history_status=V7,songs=V2,artist=V3,artist_intro=V8,artist_pic=V9,rank_lastweek=V4,rank_peak=V5,rank_onchart=V6) %>% select(rank_currentweek:rank_onchart) %>% write_csv('top30.csv')


# Download pictures

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

# dir() # 查看文件
list.files(pattern='.jpg') # find the pictures

# 删除下载文件

# if (getwd()=="/Users/Evan/DataScience/Programs/Scrape/pic"){
#     file.remove(list.files())
# }

# 撰写网页抓取函数,批量抓取网页
