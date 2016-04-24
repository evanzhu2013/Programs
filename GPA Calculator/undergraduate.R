undergraduate  <- read.csv('./data/undergraduate.csv',colClasses = c('character','character','numeric','numeric','numeric'))
View(undergraduate)
undergraduate$points[undergraduate$成绩 >= 85] <- 4.0
undergraduate$points[undergraduate$成绩 >= 75 & undergraduate$成绩 < 85] <- 3.0
undergraduate$points[undergraduate$成绩 >= 60 & undergraduate$成绩 < 75] <- 2.0
undergraduate$points[undergraduate$成绩 < 60] <- 1.0
GPA <- sum(undergraduate$学分*undergraduate$points)/(sum(undergraduate$学分))
