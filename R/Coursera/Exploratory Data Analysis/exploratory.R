# Q1
fetch_data <- function(data_url, filename = "data") {
  filename <- paste(filename, ".zip", sep="")
  if(!file.exists(filename)) {
    download.file(data_url, method="curl", destfile=filename)
    unzip(filename)
  }
}

fetch_data("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

completeCases <- complete.cases(NEI)
validData <- NEI[completeCases, ]
validData$year <- as.factor(validData$year)

total <- aggregate(Emissions ~ year, validData, sum)

png("plot1.png")
barplot(
  (total$Emissions)/10^2,
  names.arg=total$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^2 Tons)",
  main="Total emissions of PM2.5 in United States from 1999 to 2008",
  col=colorRampPalette(c("black", "gray"))(nrow(total))
)
dev.off()

fetch_data <- function(data_url, filename = "data") {
  filename <- paste(filename, ".zip", sep="")
  if(!file.exists(filename)) {
    download.file(data_url, method="curl", destfile=filename)
    unzip(filename)
  }
}

# Q2
fetch_data("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

completeCases <- complete.cases(NEI)
validData <- NEI[completeCases, ]
validData$year <- as.factor(validData$year)
validData$fips <- as.factor(validData$fips)

baltimoreData <- subset(validData, fips == "24510")
total <- aggregate(Emissions ~ year, baltimoreData, sum)

png("plot2.png")
barplot(
  (total$Emissions)/10^2,
  names.arg=total$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^2 Tons)",
  main="Total emissions from PM2.5 in Baltimore City",
  col=colorRampPalette(c("black", "gray"))(nrow(total))
)
dev.off()




# Q3

library(ggplot2)

fetch_data <- function(data_url, filename = "data") {
  filename <- paste(filename, ".zip", sep="")
  if(!file.exists(filename)) {
    download.file(data_url, method="curl", destfile=filename)
    unzip(filename)
  }
}

fetch_data("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

completeCases <- complete.cases(NEI)
validData <- NEI[completeCases, ]
validData$year <- as.factor(validData$year)
validData$fips <- as.factor(validData$fips)
validData$type <- as.factor(validData$type)

baltimoreData <- subset(validData, fips == "24510")

png("plot3.png")
g <- ggplot(baltimoreData, aes(x = year, y = Emissions))
g <- g + geom_bar(stat="identity")+
      facet_wrap(~ type, ncol = 4)+
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)"))+
      labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008"))
print(g)
dev.off()


# Q4


library(ggplot2)

fetch_data <- function(data_url, filename = "data") {
  filename <- paste(filename, ".zip", sep="")
  if(!file.exists(filename)) {
    download.file(data_url, method="curl", destfile=filename)
    unzip(filename)
  }
}

fetch_data("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

completeCases <- complete.cases(NEI)
validData <- NEI[completeCases, ]
validData$year <- as.factor(validData$year)
validData$fips <- as.factor(validData$fips)
validData$type <- as.factor(validData$type)

SCCCoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

allData <- merge(x=validData, y=SCCCoal, by='SCC')

total <- aggregate(Emissions ~ year, allData, sum)

png("plot4.png")
g <- ggplot(total, aes(year, Emissions/10^2))
g <- g + geom_bar(stat="identity",fill="grey",width=0.75) +
     labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^2 Tons)")) +
     labs(title=expression("PM"[2.5]*" Coal Combustion Emissions United States from 1999-2008"))

print(g)
dev.off()


# Q5

library(ggplot2)

fetch_data <- function(data_url, filename = "data") {
  filename <- paste(filename, ".zip", sep="")
  if(!file.exists(filename)) {
    download.file(data_url, method="curl", destfile=filename)
    unzip(filename)
  }
}

fetch_data("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

completeCases <- complete.cases(NEI)
validData <- NEI[completeCases, ]
validData$year <- as.factor(validData$year)
validData$fips <- as.factor(validData$fips)
validData$type <- as.factor(validData$type)

baltimoreData <- subset(validData, fips == "24510" & type == "ON-ROAD")
total <- aggregate(Emissions ~ year, baltimoreData, sum)

print(g)
png("plot5.png")
g <- ggplot(total, aes(year, Emissions/10^2))
g <- g + geom_bar(stat="identity", fill="grey") +
     labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^2 Tons)")) +
     labs(title=expression("PM"[2.5]*" Total Emissions  of Motor Vehicle in Baltimore City"))

print(g)
dev.off()

# Q6


library(ggplot2)

fetch_data <- function(data_url, filename = "data") {
  filename <- paste(filename, ".zip", sep="")
  if(!file.exists(filename)) {
    download.file(data_url, method="curl", destfile=filename)
    unzip(filename)
  }
}

fetch_data("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

completeCases <- complete.cases(NEI)
validData <- NEI[completeCases, ]
validData$year <- as.factor(validData$year)
validData$fips <- as.factor(validData$fips)
validData$type <- as.factor(validData$type)

baltimoreData <- subset(validData, fips == "24510" & type == "ON-ROAD")

losAngelesData <- subset(validData, fips == "06037" & type == "ON-ROAD")

baltimoreTotal <- aggregate(Emissions ~ year, baltimoreData, sum)
baltimoreTotal$Name <- "Baltimore"

losAngelesTotal <- aggregate(Emissions ~ year, losAngelesData, sum)
losAngelesTotal$Name <- "Los Angeles"

baltimoreAndLosAngeles <- rbind(baltimoreTotal, losAngelesTotal)

png("plot6.png")
g <- ggplot(baltimoreAndLosAngeles, aes(year, Emissions))
g <- g + geom_bar(aes(fill=year), stat="identity") +
         facet_wrap(~ Name, ncol = 2) +
         labs(x="year", y=expression("Total PM"[2.5]*" Emission")) +
         labs(title=expression("Emissions of Motor Vehicle \nLos Angeles County vs Baltimore, 1999-2008")) +
         guides(fill=FALSE)
print(g)
dev.off()