# Cox回归 列线图
setwd('~/Downloads')

library(rms)
library(dplyr)
library(survival)
library(readxl)
library(VIM)


gc_cox <- read.csv('gc_cox.csv')

gc <- select(gc_cox,one_of(c('group','agegroup','sex','bmigroup','location','tumorsizegroup','stagefour','op__modified_title','lymphaenectomy','adjuve0t_chemo','ddstat','dds')))

gc$Stage <- as.factor(ifelse(gc$stagefour==1,'I',ifelse(gc$stagefour==2,'II',ifelse(gc$stagefour==3,'III','IV'))))
gc$Group <- as.factor(ifelse(gc$group==1,'USA','CHINA'))
gc$Location <- as.factor(ifelse(gc$location==1,'L',ifelse(gc$location==2,'M',ifelse(gc$location==3,'U&G','T'))))

coxm <- cph(Surv(dds,ddstat)~Stage+Group+tumorsizegroup+Location+lymphaenectomy+op__modified_title+adjuve0t_chemo+agegroup+sex+bmigroup,x=T,y=T,data=gc,surv=T)

dd<-datadist(gc) 
options(datadist='dd')

surv <- Survival(coxm)

surv1 <- function(x)surv(1*12,lp=x)
surv2 <- function(x)surv(3*12,lp=x)
surv3 <- function(x)surv(5*12,lp=x)

plot(nomogram(coxm,fun=list(surv1,surv2,surv3),lp= F,funlabel=c('1-yearsurvival','3-yearsurvival','5-year survival'),maxscale=10,fun.at=c('0.9','0.85','0','0.80','0.70','0.6','0.5','0.4','0.3','0.2')))














