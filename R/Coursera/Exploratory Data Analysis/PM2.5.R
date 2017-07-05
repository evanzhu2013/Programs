## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("./Data/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC<- readRDS("./Data/exdata-data-NEI_data/Source_Classification_Code.rds")

# Q1
total=tapply(NEI$Emissions,NEI$year,sum)
barplot(total,xlab='Year',ylab='Emissions',main='Total PM2.5 Emissions')

# Q2
NEI_balt=subset(NEI,fips == "24510")
balt=tapply(NEI_balt$Emissions,NEI_balt$year,sum)
barplot(balt,xlab='',ylab='Emissions',main='Total PM2.5 Emissions in the Baltimore City')

# Q3

NEI_balt=subset(NEI,fips == "24510")
library(ggplot2)
ggplot(NEI_balt,aes(x=as.factor(year),y=Emissions))+geom_bar(stat='identity')+facet_grid(.~ type)+xlab('Year')

# Q4

SCC_coal=subset(SCC,EI.Sector=="Fuel Comb - Comm/Institutional - Coal"|EI.Sector=="Fuel Comb - Industrial Boilers, ICEs - Coal"|EI.Sector=="Fuel Comb - Electric Generation - Coal")
NEI_coal=merge(x=NEI,y=SCC_coal,by=intersect(names(NEI),names(SCC_coal)))
coal=tapply(NEI_coal$Emissions,NEI_coal$year,sum)
barplot(coal,xlab='',ylab='Emissions',main='Coal combustion-related')

# Q5

## Obtain the SCC codes for motor vehicle sources.  There are a number of 
## correct ways to do this, but here I select codes that have "vehicle" in the
## EI.Sector. 

NEI_balt_onroad=subset(NEI,fips == "24510" & type=='ON-ROAD')
balt_onroad=tapply(NEI_balt_onroad$Emissions,NEI_balt_onroad$year,sum)
barplot(balt_onroad,xlab='',ylab='Emissions',main="Motor vehicle Related Emissions in Baltimore")

NEI_LA_onroad=subset(NEI,fips == "06037" & type=='ON-ROAD')
LA_onroad=tapply(NEI_LA_onroad$Emissions,NEI_LA_onroad$year,sum)
barplot(LA_onroad,xlab='',ylab='Emissions',main="Motor vehicle Related Emissions in Los Angeles ")

# Q6

NEI <- readRDS("./Data/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC<- readRDS("./Data/exdata-data-NEI_data/Source_Classification_Code.rds")
png('plot6.png')
NEI_balt_LA_onroad=subset(NEI,fips %in% c('24510', '06037') & type=='ON-ROAD')
NEI_balt_LA_onroad$fips <- factor(NEI_balt_LA_onroad$fips,labels=c('Los Angeles','Baltimore'))
ggplot(NEI_balt_LA_onroad,aes(x=as.factor(fips),y=Emissions))+geom_bar(stat='identity')+facet_grid(.~ year)+xlab('City')
dev.off()


