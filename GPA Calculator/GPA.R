
grade <-  read.csv('./data/graduate.csv',header=T)
grade$points[grade$成绩 >= 85] <- 4.0
grade$points[grade$成绩 >= 75 & grade$成绩 < 85] <- 3.0
grade$points[grade$成绩 >= 65 & grade$成绩 < 75] <- 2.0
grade$points[grade$成绩 < 60] <- 1.0
GPA <- sum(grade$学分*grade$points)/(sum(grade$学分))