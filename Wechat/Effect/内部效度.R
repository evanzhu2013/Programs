# installed.packages("foreign")
library(foreign)
library(boot)

mydata=read.spss("/Users/Evan/DataScience/Effect/alldata.sav")
names(mydata)
mydata=data.frame(mydata)
lm1 = lm(PFS1 ~ as.factor(group)+as.factor(sex)+age+as.factor(smoke)+as.factor(stage),data = mydata)
summary(lm1)
lm1$coefficients

betas<-function(formula,data,indices){
  d<-data[indices,]
  fit<-lm(formula,data=d)
  return(coef(fit))
}

results<-boot(data=mydata,statistic=betas,R=1000,formula = PFS1 ~ group+sex+age+smoke+stage)
