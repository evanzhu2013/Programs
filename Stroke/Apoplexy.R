Wed Jul 15 00:30:50 CST 2015
library(readxl)
library(tree)
library(caTools)
suppressMessages(library(dplyr))

# Read in the data & Rename the data
stroke <- read_excel('/Users/Evan/R/分类树模型数据.xlsx')
names(stroke)[c(2,14,18,19)] <- c('patient','agegroup','smoke','drink')
stroke <- stroke[,-c(15:17)]
names(stroke) <-  tolower(c("ID","patient","Sex","Marriage","Job","Education","Hypertension","AF","LDL","Glycuresis" ,"SportsLack","Overweight","StrokeFamily","agegroup","smoke","drink"))

# Percentage of patients 

table(stroke$patient)/nrow(stroke)

stroke$patient <- as.factor(stroke$patient,level)
stroke$sex <- as.factor(stroke$sex)
stroke$marriage <- as.factor(stroke$marriage)
stroke$job <- as.factor(stroke$job)
stroke$education <- as.factor(stroke$education)
stroke$hypertension <- as.factor(stroke$hypertension)
stroke$af <- as.factor(stroke$af)
stroke$ldl <- as.factor(stroke$ldl)
stroke$glycuresis <- as.factor(stroke$glycuresis)
stroke$overweight <- as.factor(stroke$overweight)
stroke$strokefamily <- as.factor(stroke$strokefamily)
stroke$agegroup <- as.factor(stroke$agegroup)
stroke$smoke <- as.factor(stroke$smoke)
stroke$drink <- as.factor(stroke$drink)
stroke$sportslack <- as.factor(stroke$sportslack)

# Split the data

set.seed(0714)
spl = sample.split(stroke$patient, SplitRatio = 0.6)
strokeTrain = subset(stroke, spl==TRUE)
strokeTest = subset(stroke, spl==FALSE)


tree = rpart(patient ~ sex+marriage+job+education+hypertension+af+ldl+glycuresis+overweight+strokefamily+agegroup+smoke+drink+sportslack, data=strokeTrain)


 
