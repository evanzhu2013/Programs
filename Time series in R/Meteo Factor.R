#---------------------------------------------------------------------#
# Title: The analysis of association between meteorological facotors and numbers of new tb patients
# Author:Evan
# Date Created: 2015.06.21
# Date Modified: 2015.06.21
# Version: 1.1
#---------------------------------------------------------------------#

opar=par(no.readonly=T)
options(digits=3)

# 深圳市2005-2013年结核登记数与气象因素的关联性分析
# 深圳市每天的发病数
suppressMessages(library(readxl))
suppressMessages(library(lubridate))
suppressMessages(library(xlsx))
suppressMessages(library(tidyr))
suppressMessages(library(mgcv))
suppressMessages(library(ggplot2))
suppressMessages(library(reshape2))
suppressMessages(library(gam))
suppressMessages(library(zoo))
suppressMessages(library(scales))


# 时序图 可以修改
setwd('/Users/Evan/DataScience/Data/')
tb_weather <- read.csv('tb_weather.csv')
tb_weather$Date <- as.Date(tb_weather$Date)
tb_weather$rain <- as.factor(tb_weather$rain)
tb_weather$year <- as.factor(tb_weather$year)
tb_weather$month <- as.factor(tb_weather$month)
tb_weather$week <- as.factor(tb_weather$week)
tb_weather$day <- as.factor(tb_weather$day)
tb_weather$holiday <- as.factor(tb_weather$holiday)
tb_weather$rest <- as.factor(tb_weather$rest)

# ggplot2绘图模型

ggtheme=theme(
	panel.grid.major = element_blank(),
	panel.grid.minor = element_blank(),
	panel.border= element_blank(),
	panel.background = element_blank(),
	axis.text.x = element_text(angle=45,hjust=1,vjust=1,colour='black',size=14),
	axis.title.y=element_text(size=14,colour='black'),
	axis.text.y=element_text(size=14,colour='black'),
	axis.line=element_line(colour='black',size=0.55)
	)

# 需要标明起至日期

datebreaks <- seq(as.Date('2005-01-01'),as.Date('2014-12-31'),by='6 month')

ggplot(tb_weather,aes(x=Date,y=Counts))+geom_line(size=0.2)+xlab('')+ylab('Daily Patients Number')+ggtheme+scale_x_date(breaks=datebreaks,labels=date_format('%y-%m'))
ggsave('./Pic/Daily Patients Number.png',width=24,height=18,unit='cm',dpi=300)

ggplot(tb_weather,aes(x=Date,y=ave_temp))+geom_line(colour='red')+xlab('')+ylab('Daily Average Temprature')+ggtheme+scale_x_date(breaks=datebreaks,labels=date_format('%y-%m'))
ggsave('./Pic/Daily Average Temprature.png',width=24,height=18,unit='cm',dpi=300)

ggplot(tb_weather,aes(x=Date,y=ave_mintemp))+geom_line(colour='blue')+xlab('')+ylab('Daily Min Temprature')+ggtheme+scale_x_date(breaks=datebreaks,labels=date_format('%y-%m'))
ggsave('./Pic/Daily Min Temprature.png',width=24,height=18,unit='cm',dpi=300)

ggplot(tb_weather,aes(x=Date,y=ave_maxtemp))+geom_line(colour='orange')+xlab('')+ylab('Daily Max Temprature')+ggtheme+scale_x_date(breaks=datebreaks,labels=date_format('%y-%m'))
ggsave('./Pic/Daily Max Temprature.png',width=24,height=18,unit='cm',dpi=300)

ggplot(tb_weather,aes(x=Date,y=diff_temp))+geom_line(colour='orange')+xlab('')+ylab('Daily Temprature Diff')+ggtheme+scale_x_date(breaks=datebreaks,labels=date_format('%y-%m'))
ggsave('./Pic/Daily Temprature Diff.png',width=24,height=18,unit='cm',dpi=300)

# ggplot(tb_weather,aes(x=Date,y=ave_pres))+geom_line(colour='red')+xlab('Date')+ylab('Daily Pressure')
# ggplot(tb_weather,aes(x=Date,y=ave_humi))+geom_line(colour='blue')+xlab('Date')+ylab('Daily Relative Humidity')
# ggplot(tb_weather,aes(x=Date,y=precipitation))+geom_line(colour='orange')+xlab('Date')+ylab('Daily Precipitation')
# ggplot(tb_weather,aes(x=Date,y=sun))+geom_line(colour='pink')+xlab('Date')+ylab('Daily Sunshine')
# ggplot(tb_weather,aes(x=Date,y=sun))+geom_point(alpha=.4)

# par(mfrow=c(2,2))
# plot(x=tb_weather$Date,y=tb_weather$ave_temp,xlab="Date",ylab='Daily Temprature',type='l')
# plot(x=tb_weather$Date,y=tb_weather$ave_mintemp,xlab="Date",ylab='Daily Max Temprature',type='l')
# plot(x=tb_weather$Date,y=tb_weather$ave_maxtemp,xlab="Date",ylab='Daily Min Temprature',type='l')
# plot(x=tb_weather$Date,y=tb_weather$diff_temp,xlab="Date",ylab='Daily Temprature Difference',type='l')

# par(mfrow=c(2,2))
# plot(x=tb_weather$Date,y=tb_weather$ave_pres,xlab="Date",ylab='Daily Pressure',type='l')
# plot(x=tb_weather$Date,y=tb_weather$ave_humi,xlab="Date",ylab='Daily Relative Humidity',type='l')
# plot(x=tb_weather$Date,y=tb_weather$precipitation,xlab="Date",ylab='Daily Precipitation',type='l')
# plot(x=tb_weather$Date,y=tb_weather$sun,xlab="Date",ylab='Daily Sunshine',type='l')
# par(mfrow=c(1,1))

# 月汇总的时序图

par(mfrow=c(1,1))
Countsmonth <- aggregate(Counts~factor(month)+factor(year),data=tb_weather,sum)[3]
plot(ts(Countsmonth,start=c(2005,1),frequency=12),main="Total New TB patients each Month")

monthbreaks <- seq(as.Date('2005-01-01'),as.Date('2013-12-31'),by='1 month')
Countsmonth <- aggregate(Counts~factor(month)+factor(year),data=tb_weather,sum)[3]
month_counts <- cbind(monthbreaks,Countsmonth)

datebreaks2 <- seq(as.Date('2005-01-01'),as.Date('2014-12-31'),by='6 month')
ggplot(month_counts,aes(x=monthbreaks,y=Counts))+geom_line(size=0.4)+xlab('')+ylab('Counts')+geom_point(size=4,shape=21)+ggtheme+scale_x_date(breaks=datebreaks2,labels=date_format('%y-%m'))
ggsave('./Pic/Month sum counts.png',width=24,height=18,unit='cm',dpi=300)

# par(mfrow=c(2,2))
# ave_temp_month<- aggregate(ave_temp~month+year,data=tb_weather,mean)[3]
# plot(ts(ave_temp_month,start=c(2005,1),frequency=12),ylab='Month Average Temprature')
# ave_mintemp_month<- aggregate(ave_mintemp~month+year,data=tb_weather,mean)[3]
# plot(ts(ave_mintemp_month,start=c(2005,1),frequency=12),ylab='Month Min Temprature')
# ave_maxtemp_month<- aggregate(ave_maxtemp~month+year,data=tb_weather,mean)[3] 
# plot(ts(ave_mintemp_month,start=c(2005,1),frequency=12),ylab='Month Max Temprature')
# diff_temp_month<- aggregate(diff_temp~month+year,data=tb_weather,mean)[3]
# plot(ts(ave_mintemp_month,start=c(2005,1),frequency=12),ylab='Month Temprature Difference')

# par(mfrow=c(2,2))
# ave_pres_month<- aggregate(ave_pres~month+year,data=tb_weather,mean)[3]
# plot(ts(ave_pres_month,start=c(2005,1),frequency=12),ylab='Month Pressure')
# ave_humi_month<- aggregate(ave_humi~month+year,data=tb_weather,mean)[3]
# plot(ts(ave_humi_month,start=c(2005,1),frequency=12),ylab='Month Humidity')
# precipitation_month<- aggregate(precipitation~month+year,data=tb_weather,mean)[3]
# plot(ts(precipitation_month,start=c(2005,1),frequency=12),ylab='Month precipitation')
# sun_month<- aggregate(sun~month+year,data=tb_weather,mean)[3]
# plot(ts(sun_month,start=c(2005,1),frequency=12),ylab='Month Sunshine')

# 周汇总时序图

Counts_week <- aggregate(Counts~week+year,data=tb_weather,sum)[3]
plot(ts(Counts_week,start=c(2005,1),frequency=53),ylab='Week Counts',bty='l',type='o',xlab='')

# Counts_week <- aggregate(Counts~year+week,data=tb_weather,sum)
# par(mfrow=c(2,2))
# ave_temp_week <- aggregate(ave_temp~week+year,data=tb_weather,mean)[3]
# plot(ts(ave_temp_week,start=c(2005,1),frequency=53),ylab='Week Average Temprature')
# ave_mintemp_week <- aggregate(ave_mintemp~week+year,data=tb_weather,mean)[3]
# plot(ts(ave_mintemp_week,start=c(2005,1),frequency=53),ylab='Week Min Temprature')
# ave_maxtemp_week <- aggregate(ave_maxtemp~week+year,data=tb_weather,mean)[3] 
# plot(ts(ave_mintemp_week,start=c(2005,1),frequency=53),ylab='Week Max Temprature')
# diff_temp_week <- aggregate(diff_temp~week+year,data=tb_weather,mean)[3]
# plot(ts(ave_mintemp_week,start=c(2005,1),frequency=53),ylab='Week Temprature Difference')

# par(mfrow=c(2,2))
# ave_pres_week <- aggregate(ave_pres~week+year,data=tb_weather,mean)[3]
# plot(ts(ave_pres_week,start=c(2005,1),frequency=53),ylab='Week Pressure ')
# ave_humi_week <- aggregate(ave_humi~week+year,data=tb_weather,mean)[3]
# plot(ts(ave_humi_week,start=c(2005,1),frequency=53),ylab='Week HUmidity')
# precipitation_week <- aggregate(precipitation~week+year,data=tb_weather,mean)[3]
# plot(ts(precipitation_week,start=c(2005,1),frequency=53),ylab='Week precipitation')
# sun_week <- aggregate(sun~week+year,data=tb_weather,mean)[3]
# plot(ts(sun_week,start=c(2005,1),frequency=53),ylab='Week Sunshine')

# 按照月进行分析
 
fun <- function(measure,time,m,xlabs,ylabs){
    library(dplyr)
    aggregate(measure~time,data=tb_weather,m)  %>%
    ggplot(aes(x=time,y=measure))+geom_bar(stat='identity',fill='grey65',position='identity')+xlab(xlabs)+ylab(ylabs)+ggtheme+theme(axis.text.x=element_text(angle=0))
}

# 最好使用循环重写一遍

attach(tb_weather)
fun(Counts,month,mean,'Month','Average Counts')
fun(ave_temp,month,mean,'Month','Average Temprature')
fun(ave_mintemp,month,mean,'Month','Min Temprature')
fun(ave_maxtemp,month,mean,'Month','Max Temprature')
fun(diff_temp,month,mean,'Month','Temprature Difference')
# fun(ave_pres,month,mean,'Month','Average Pressure')
# fun(ave_humi,month,mean,'Month','Average Humidity')
# fun(precipitation,month,mean,'Month','Precipitation')
# fun(sun,month,median,'Month','Sunshine')
detach(tb_weather)

# 按照周的效应分析

attach(tb_weather)
fun(Counts,week,mean,'Week','Average Counts')
fun(ave_temp,week,mean,'Week','Average Temprature')
fun(ave_mintemp,week,mean,'Week','Min Temprature')
fun(ave_maxtemp,week,mean,'Week','Max Temprature')
fun(diff_temp,week,mean,'Week','Temprature Difference')

fun(ave_pres,week,mean,'Week','Average Pressure')
fun(ave_humi,week,mean,'Week','Average HUmidity')
fun(precipitation,week,mean,'Week','Precipitation')
fun(sun,week,median,'Week','Sunshine')
detach(tb_weather)

# 按照月份描述其分布

par(mfrow=c(2,2))
plot(x=tb_weather$month,y=tb_weather$ave_temp,xlab="Month",ylab='Daily Temprature')
plot(x=tb_weather$month,y=tb_weather$ave_mintemp,xlab="Month",ylab='Daily Max Temprature')
plot(x=tb_weather$month,y=tb_weather$ave_maxtemp,xlab="Month",ylab='Daily Min Temprature')
plot(x=tb_weather$month,y=tb_weather$diff_temp,xlab="Month",ylab='Daily Temprature Difference')

par(mfrow=c(2,2))
plot(x=tb_weather$month,y=tb_weather$ave_pres,xlab="Month",ylab='Daily Pressure')
plot(x=tb_weather$month,y=tb_weather$ave_humi,xlab="Month",ylab='Daily Relative Humidity')
plot(x=tb_weather$month,y=tb_weather$precipitation,xlab="Month",ylab='Daily Precipitation')
plot(x=tb_weather$month,y=tb_weather$sun,xlab="Month",ylab='Daily Sunshine')
par(mfrow=c(1,1))

# 新增登记结核患者数

ggplot(tb_weather,aes(x=month,y=Counts))+geom_violin()+geom_boxplot(width=.1,fill='violet')+stat_summary(fun.y=median,geom='point',fill='white',shape=21,size=2.5)+xlab('Month')+ylab('Counts')+theme_light()+theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),axis.text.x = element_text(hjust=1,vjust=1))+xlab('')

# 各年月均发病数

month_mean <- aggregate(Counts~month+year,data=tb_weather,mean) 
month_mean$numb <- 1:nrow(month_mean)
ggplot(month_mean,aes(x=numb,y=Counts))+geom_line()+xlab('Months')+ylab('Counts') # 这种线型如何拟合？

# 按照周为单位进行模型拟合

tb_counts <- ts(tb_weather$Counts,start=c(2005,01,01),frequency=365)
acf(tb_counts)
pacf(tb_counts)

# 气温与新增结核发病数关系
summary(lm(tb_weather$Counts~tb_weather$Date))

# Timescale decompostion of ave_temp
detach('package:dplyr')
library(stats)
ave_temp <- tb_weather$ave_temp
ave_temp.yearly <- filter(ave_temp,rep(1/365,365)) 
z <- ave_temp-ave_temp.yearly 
z.seasonal <- filter(z,rep(1/90,90))
u <- z-z.seasonal
u.weekly <- filter(u,rep(1/7,7))
r <- u-u.weekly
fit1 <- lm(tb_counts~ave_temp.yearly+z.seasonal+z.seasonal+u.weekly+r)
summary(fit1)

# Timescale decompostion of Counts
Counts <- tb_weather$Counts
Counts.yearly <- filter(Counts,rep(1/365,365)) 
zc <- Counts-Counts.yearly 
zc.seasonal <- filter(zc,rep(1/90,90))
uc <- zc-zc.seasonal
uc.weekly <- filter(uc,rep(1/7,7))
rc <- uc-uc.weekly

par(mfrow=c(4,2))
plot(ave_temp.yearly)
plot(Counts.yearly)
plot(z.seasonal)
plot(zc.seasonal)
plot(u.weekly)
plot(uc.weekly)
plot(r)
plot(rc)

# Correlation at different timescales
library(tsModel)
counts.dc <- tsdecomp(tb_counts,c(1,2,15,3287))
par(mfrow=c(3,1),mar=c(3,4,2,1)+0.1)
date <- seq(as.Date('2005-01-01'),as.Date('2013-12-31'),'1 day')
plot(date,counts.dc[,1],type='l',ylab='Trend',main='(a)')
plot(date,counts.dc[,2],type='l',ylab='Seasonal',main='(b)')
plot(date,counts.dc[,3],type='l',ylab='Residual',main='(c)')

ave_temp.dc <- tsdecomp(tb_weather$ave_temp,c(1,2,15,3287))
par(mfrow=c(3,1),mar=c(3,4,2,1)+0.1)
date <- seq(as.Date('2005-01-01'),as.Date('2013-12-31'),'1 day')
plot(date,ave_temp.dc[,1],type='l',ylab='Trend',main='(a)')
plot(date,ave_temp.dc[,2],type='l',ylab='Seasonal',main='(b)')
plot(date,ave_temp.dc[,3],type='l',ylab='Residual',main='(c)')

c1 <- cor(counts.dc[,1],ave_temp.dc[,1])
c2 <- cor(counts.dc[,2],ave_temp.dc[,2])
c3 <- cor(counts.dc[,3],ave_temp.dc[,3])

# single lags

f0<- glm(tb_counts~lag(ave_temp,0),family=poisson)
f1<- glm(tb_counts~lag(ave_temp,1),family=poisson)
f2<- glm(tb_counts~lag(ave_temp,2),family=poisson)
f3<- glm(tb_counts~lag(ave_temp,3),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,4),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,5),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,6),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,7),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,8),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,9),family=poisson)
f4<- glm(tb_counts~lag(ave_temp,10),family=poisson)

ss <- list(summary(f0),summary(f1),summary(f2),summary(f3),summary(f4))

models <- lapply(ss,function(x) x$coefficients[2,])

coefdata <- data.frame()
for (i in 1:20){
    coefdata <- rbind(coefdata,summary(glm(tb_counts~lag(ave_temp,i),family=poisson))$coefficients[2,])
}
# 控制时间趋势

par(mfrow=c(2,2))
for (i in 1:8){
fitcount <- glm(Counts~ns(Date,df=i*9),family=poisson(),data=tb_weather)
plot(ts(fitcount[[2]]),xlab='Days',ylab='Counts',main=paste('λ',i,sep='='))
# acf(fitcount[[2]])
}

par(mfrow=c(1,1))
plot(rollmean(tb_counts,7),ylab='Week Counts') # 周滑动平均 plot(rollmean(tb_counts,30),col='red',ylab='Month Counts') # 月滑动平均 plot(rollmean(tb_counts,365),col='blue',ylab='Year Counts',ylim=c(0,20)) # 年滑动平均 par(mfrow=c(1,1)) Countsmonth <- aggregate(Counts~factor(year)+factor(month),data=tb_weather,sum)[3] plot(ts(Countsmonth,start=c(2005,1),frequency=12))w # 广义相加模型的拟合 # fit<-gam(Counts~ns(Date,k=3*9)+s(ave_temp,k=6*9)+rain+s(ave_humi,k=4*9)+DOW+,family=poisson,method="REML",data=tb_weather) # plot(fit) # summary(fit)
# 按照周进行汇总分析

# 计算预测值

# 气温与发病数的散点图
ggplot(tb_weather,aes(x=ave_temp,y=Counts))+geom_point(shape=1,size=4)+ggtheme+xlab('Temperature')+ylab('Counts')+stat_smooth(method=loess)+theme(axis.text.x=element_text(angle=0))
ggsave('./Pic/Temperature and counts.png',width=24,height=18,unit='cm',dpi=300)


# 气温自由度的选择
par(mfrow=c(2,2))
for (i in 1:8){
fitcount <- glm(Counts~ns(ave_temp,df=i*9),family=poisson(),data=tb_weather)
plot(ts(fitcount[[2]]),xlab='Days',ylab='Counts',main=paste('λ',i,sep='='))
# acf(fitcount[[2]])
}

fit1<-gam(Counts~s(Date,k=8)+s(ave_temp,k=5)+DOW+holiday,family=poisson,method="REML",data=tb_weather)
plot(fit1)

tb_weather$log=log(tb_weather$Counts)
tb_weather$DOW=as.factor(tb_weather$DOW)
tb_weather$holiday=as.factor(tb_weather$holiday)
tb_weather$time<-1:length(tb_weather[,1])

fitcount2<-glm(Counts~ns(time,k=6)+ns(ave_temp,k=9)+DOW+holiday,family='poisson',data=tb_weather)
plot(fitcount2)



