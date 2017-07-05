# Read and subset data
library(data.table)
ele=fread('/Users/Evan/R/household_power_consumption.txt',header = T,sep=';')
el=ele[66637:69516,]
el$Global_active_power = as.numeric(el$Global_active_power)
el$Global_reactive_power = as.numeric(el$Global_reactive_power)

el$Date=as.POSIXct(paste(el$Date, el$Time), format="%d/%m/%Y %H:%M:%S")

# Plot 3
png('plot3.png')
plot(x=el$Date,y=el$Sub_metering_1,type = 'l',xlab='',ylab='Energy sub metering')
lines(x=el$Date,y=el$Sub_metering_2,type = 'l',xlab='',col='red')
lines(x=el$Date,y=el$Sub_metering_3,type = 'l',xlab='',col='blue')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=c(1,1,1))
dev.off()
