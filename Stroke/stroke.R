
library(readxl)
library(tree)
library(caTools)
suppressMessages(library(dplyr))

# Read in the data & Rename the data
stroke <- read_excel('/Users/Evan/DataScience/Data/分类树模型数据.xlsx')
names(stroke)[c(2,14,18,19)] <- c('patient','agegroup','smoke','drink')
stroke <- stroke[,-c(15:17)]
names(stroke) <-  tolower(c("ID","patient","Sex","Marriage","Job","Education","Hypertension","AF","LDL","Glycuresis" ,"SportsLack","Overweight","StrokeFamily","agegroup","smoke","drink"))

# Percentage of patients 

table(stroke$patient)/nrow(stroke)

stroke$patient <- ifelse(stroke$patient==1,2,1)

stroke$patient <- factor(stroke$patient,levels=c(1,2),order=T,labels=c('No',"Yes"))
stroke$sex <- factor(stroke$sex,levels=c(1,2),labels=c("male",'female'))
stroke$marriage <- factor(stroke$marriage,levels=c(10,20,30,40),labels=c('未婚','已婚','丧偶','离婚'))
stroke$job <- factor(stroke$job)
stroke$education <- factor(stroke$education)
stroke$hypertension <- factor(stroke$hypertension,levels=c(0,1),labels=c('No',"Yes"))
stroke$af <- factor(stroke$af,levels=c(0,1),labels=c('No','Yes'))
stroke$ldl <- factor(stroke$ldl)
stroke$glycuresis <- factor(stroke$glycuresis)
stroke$overweight <- factor(stroke$overweight)
stroke$strokefamily <- factor(stroke$strokefamily)
stroke$agegroup <- factor(stroke$agegroup)
stroke$smoke <- factor(stroke$smoke)
stroke$drink <- factor(stroke$drink,levels=c(0,1),labels=c('No','Yes'))
stroke$sportslack <- factor(stroke$sportslack)

# Split the data

set.seed(0714)
spl = sample.split(stroke$patient, SplitRatio = 0.6)
strokeTrain = subset(stroke, spl==TRUE)
strokeTest = subset(stroke, spl==FALSE)

stroke.tree <- tree(patient~.-id,data=strokeTrain)
summary(stroke.tree)

plot(stroke.tree)
text(stroke.tree,pretty=0)




