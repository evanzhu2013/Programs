# Activity monitoring data
library(ggplot2)

if (!file.exists('data')){
	dir.create('data')
}

setwd('./data')
fileurl <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip'
download.file(fileurl, method = 'curl', destfile='./data/activity.zip')
unzip('activity.zip')
list.files()
activity <- read.csv('activity.csv')

total <- aggregate(steps ~ date,data=activity,sum,na.rm=T)
hist(total$steps,xlab = 'Number of steps',ylab='Counts',main='Total number of steps taken each day')
mean_counts <- aggregate(steps ~ date,data=activity,mean,na.rm=T)
median_counts <- aggregate(steps ~ date,data=activity,median,na.rm=T)
