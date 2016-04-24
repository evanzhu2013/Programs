# Import into data

par(family = "STXihei")
options(digits=3)

library(tree)
library(dplyr)
library(reshape2)
library(rpart)
library(readxl)
library(rpart.plot)

group123 = read.csv('/Users/Evan/Desktop/Temp/决策树分析/group123.csv')
group124 <- read_excel('/Users/Evan/Desktop/Temp/决策树分析/group124.xlsx')


group1 <- select(group123,sample,group,target,ratio)
group2 <- select(group124,sample,group,target,ratio)

group1 <-  rename(group1,value=ratio,variable=target)
group2 <-  rename(group2,value=ratio,variable=target)

groupA <- dcast(group1,sample+group~variable)
groupB <- dcast(group2,sample+group~variable)

groupA$group <- as.factor(ifelse(groupA$group=='正常人组','正常人组','非正常组'))
groupB$group <- as.factor(ifelse(groupB$group=='长期接触者','正常人组','非正常组'))

treeA <-  rpart(group ~ ATP6+CCL2+CHGB48+FLJ10489+GAL3ST4+GAPDH+IL8+JAKM+LINC00659+LOC101928143+LOC34487+MIR22+MTND1+NCF1C+SERP,data=groupA,method='class')
prp(treeA)


plot(treeA)
text(treeA,use.n=T)

treeB <-  rpart(group ~ ATP6+CCL2+CHGB48+FLJ10489+GAL3ST4+GAPDH+IL8+JAKM+LINC00659+LOC101928143+LOC34487+MIR22+MTND1+NCF1C+SERP,data=groupB)

prp(treeB)


groupA$class <- as.factor(ifelse(groupA$IL8 < 8.7,'正常人组','非正常组'))

groupB$class <- as.factor(ifelse(groupB$IL8 < 64,ifelse(groupB$IL8 < 5.9,'长期接触者','非正常组'),'长期接触者'))
