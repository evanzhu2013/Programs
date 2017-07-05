# Read and subset data
library(data.table)
ele=fread('/Users/Evan/R/household_power_consumption.txt',header = T,sep=';')
el=ele[66637:69516,]
el$Global_active_power = as.numeric(el$Global_active_power)
el$Global_reactive_power = as.numeric(el$Global_reactive_power)

el$Date=as.POSIXct(paste(el$Date, el$Time), format="%d/%m/%Y %H:%M:%S")


# Plot 1

png('plot1.png')
hist(el$Global_active_power,col='red',xlab='Global Active Power(kilowatts)',main='Global Active Power')
dev.off()