library(rvest)
library(stringr)
library(dplyr)

url = html_session('http://www.billboard.com/charts/country-airplay/2016-05-28')
current_week <-  url %>% html_nodes(".chart-row__current-week") %>% html_text()

song  <-  url %>% html_nodes(".chart-row__song") %>% html_text()

artist <- url %>% html_nodes(".chart-row__artist") %>% html_text() %>% gsub('\n','',.) %>% str_trim(side = "both")

last_week <- url  %>% html_nodes(".chart-row__stats") %>% html_text() %>% gsub('\n','',.) %>% str_trim(side = "both") %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(2)

peak <- url %>% html_nodes(".chart-row__stats") %>% html_text() %>% gsub('\n','',.) %>% str_trim(side = "both") %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(3)

weekon <- url %>% html_nodes(".chart-row__stats") %>% html_text() %>% gsub('\n','',.) %>% str_trim(side = "both") %>% gsub('[a-zA-Z]+','',.) %>% gsub('\\s+',' ',.) %>% word(4)

data.frame(current_week,song,artist,last_week,peak,weekon) %>%  write.csv('billboard.csv',row.names = TRUE)
