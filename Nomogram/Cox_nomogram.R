
# Nomogram using Cox regression
# Author: Evan Zhu
# Email: zhulei1110@163.com
# Date Created: 2016.04.21
# Verson: 1.0

library(survival)
library(rms)
library(VIM)

data(lung)
head(lung)
aggr(lung,prop=T,numbers=T)
lung <- na.omit(lung)

dd<-datadist(lung) 
options(datadist='dd')

coxm <- cph(Surv(time,status==2)~inst+age+sex+sex+ph.ecog+ph.karno+pat.karno+wt.loss,x=T,y=T,data=lung,surv=T)

surv <- Survival(coxm)

surv1 <- function(x)surv(3*30,lp=x)
surv2 <- function(x)surv(6*30,lp=x)
surv3 <- function(x)surv(12*30,lp=x)

plot(nomogram(coxm,fun=list(surv1,surv2,surv3),lp= F,funlabel=c('1-Year Survival','3-Year survival','12-Month survival'),maxscale=10,fun.at=c('0.9','0.85','0.80','0.70','0.6','0.5','0.4','0.3','0.2','0.1')),xfrac=.45)






