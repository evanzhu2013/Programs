#---------------------------------------------------------------------#
# Title: The analysis of association between meteorological facotors and numbers of new tb patients
# Author:Evan
# Date Created: 2015.06.21
# Date Modified: 2015.06.21
# Version: 1.1
#---------------------------------------------------------------------#

opar=par(no.readonly=T)
options(digits=3)

# 深圳市2005-2011年结核登记数与气象因素的关联性分析
# 深圳市每天的发病数

library(readxl)
library(lubridate)
library(dplyr)
library(xlsx)
library(tidyr)
library(mgcv)
library(ggplot2)
library(reshape2)
library(gam)
library(zoo)

list <- list.files('./Surveillance/',full.names=T)
tb <- data.frame()
for (i in 1:length(list)){
	data <- read_excel(list[i]) 
	data <- select(data,contains('就诊'),contains('首诊日期'))
    names(data) <- 'Date'
    data$Date <- ymd(data$Date)
    tb <- rbind(data,tb) 
}
tb <- filter(tb,as.Date(tb$Date) > as.Date('2005-01-01'))
tab=table(tb$Date)
write.csv(tab,'numbers.csv',row.names=F)
tab=read.csv('numbers.csv')
names(tab) <- c('Date','Counts')
tab$Date <- as.Date(tab$Date)
Date=seq(as.Date('2005-01-01'),as.Date('2013-12-31'),by='1 day')
Date=data.frame(Date)
total <- merge(Date,tab,by='Date',all.x=T)
total$Counts[is.na((total$Counts))] <- 0
# write.xlsx2(total,'total.xlsx')

# daily weather from 2005 to 2013
list <- list.files('./深圳市气候资料1999-2013/',full.names=T)
lis <- list.files('./深圳市气候资料1999-2013/')
weather <- data.frame(Date=seq(as.Date('2005-01-01'),as.Date('2013-12-31'),by='1 day'))
for (j in 1:length(list)){
lists <- list.files(list[j],full.names=T)
datasets <- data.frame()

for (i in 1:length(lists)){
	data <-  read_excel(lists[i],skip=1)
	datasets <- rbind(datasets,data)
}

names(datasets)[1] <- 'date'
dta <- gather(datasets,day,measure,-date)
dta <- na.omit(dta)
dta$day <- factor(dta$day,labels=1:31)
dta$Date <- paste(dta$date,dta$day,'日',sep='')
dta$Date <- ymd(dta$Date)
dta <- dta[order(dta$Date),]
dta <- dta[,3]
weather <- cbind(weather,dta)
}
names(weather)[2:8] <- lis
names(weather)[2:8] <-c('ave_pres','ave_temp','ave_humi','ave_mintemp','ave_maxtemp','precipitation','sun')

# View(weather)
# summary(weather)

# 处理缺失值
min.date <- weather$Date[which.min(weather$ave_pres)] 
n=3
sum(weather$ave_pres[min.date-n<=  weather$Date & weather$Date <= min.date+n])/(2*n)
weather$ave_pres[which.min(weather$ave_pres)] <- 1006

# 统计分析的预处理
tb_weather <- merge(total,weather,by='Date')

# tb_weather$ID <- 1:nrow(tb_weather)

tb_weather$year <- factor(year(tb_weather$Date))
tb_weather$month <- factor(month(tb_weather$Date)) # 年终年末数据可以设置哑变量进行控制
tb_weather$week <- factor(week(tb_weather$Date))
tb_weather$DOW <- factor(weekdays(tb_weather$Date))
tb_weather$day <- day(tb_weather$Date)
tb_weather$diff_temp <- tb_weather$ave_maxtemp-tb_weather$ave_mintemp
tb_weather$rain <- ifelse(tb_weather$precipitation > 0,1,0)


# 节假日分析

holidays <- read_excel('/Users/Evan/R/Data/放假天数.xlsx',1)
names(holidays) <- c('Date','holiday')
holidays$Date <- as.Date(holidays$Date)
tb_weather <- merge(tb_weather,holidays,by='Date',all.x=TRUE)
tb_weather$holiday <- ifelse(is.na(tb_weather$holiday),0,1)

write.csv('tb_weather')

# 国家法定节假日分析

tb_weather$rest <- ifelse(tb_weather$DOW %in% c('Saturday','Sunday')|tb_weather$holiday==1,1,0)

year_holidays <- aggregate(rest~year,data=tb_weather,sum)

ggplot(year_holidays,aes(x=year,y=rest))+geom_bar(stat='identity')

ggplot(year_holidays,aes(x=year,y=rest))+geom_point(size=3,colour='red')+theme(panel.grid.major.x=element_blank(),panel.grid.minor.x=element_blank(),panel.grid.major.y=element_line(colour='grey60',linetype='dashed'))+xlab('Year')+ylab('Holidays')

