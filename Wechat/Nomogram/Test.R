# Cox回归 列线图
setwd('~/Downloads')

library(rms)
library(dplyr)
library(survival)
library(VIM)

data(lung)

aggr(gc,prop=T,numbers=F)

gc$Stage <- as.factor(ifelse(gc$stagefour==1,'I',ifelse(gc$stagefour==2,'II',ifelse(gc$stagefour==3,'III','IV'))))

gc$Group <- as.factor(ifelse(gc$group==1,'Trial','Control'))
gc$Location <- as.factor(ifelse(gc$location==1,'A',ifelse(gc$location==2,'B',ifelse(gc$location==3,'C','D'))))

coxm <- cph(Surv(dds,ddstat)~Stage+Group+agegroup+sex+tumorsizegroup+Location,x=T,y=T,data=gc,surv=T)

dd<-datadist(gc) 
options(datadist='dd')

surv <- Survival(coxm)

surv1 <- function(x)surv(1*12,lp=x)
surv2 <- function(x)surv(3*12,lp=x)
surv3 <- function(x)surv(5*12,lp=x)

plot(nomogram(coxm,fun=list(surv1,surv2,surv3),lp= F,funlabel=c('1-Year Survival','3-Year survival','5-Year Survival'),maxscale=10,fun.at=c('0.9','0.85','0.80','0.70','0.6','0.5','0.4','0.3','0.2')),xfrac=.45)






