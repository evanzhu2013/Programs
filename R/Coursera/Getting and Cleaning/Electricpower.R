a <- read.table("/Users/Evan/R/Data/household_power_consumption.txt",head=T,sep=";",as.is=T)
b <- a[,-c(4:6)]
str(b)
b[,1] <- as.Date(b$Date,"%d/%m/%Y")
str(b)