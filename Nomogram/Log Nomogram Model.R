setwd("G:/1. 科室文件/26-R 相关计算/log cox")

# 加载需要的R包
library(foreign)
library(rms)

# 读入所需csv文件
gc <- read.csv('Mydata.csv')

#删除数据的缺失值及缺失值验证
gc <- na.omit(gc)
aggr(gc,prop=F,numbers=T)

#转换分类变量，同时设置各个变量的值标签
gc$ALB <- as.factor(ifelse(gc$ALB==0,'<35g/L','>=35g/L'))
gc$'白蛋白' <- gc$ALB
# 此处省略很多

#执行log以及逐步法的结果
logm <- glm(admit ~ gre + gpa + rank, data = gc, family="binomial")
logm=step(logm)
a=predict.glm(logm)


mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
gc <- mydata

attach(gc)

# 数据转制
dd<-datadist(gc) 
options(datadist='dd')

logm <- lrm(admit ~ gre + gpa + rank, data = gc)
logm2 <- glm(admit ~ gre + gpa + rank, data = gc, family="binomial")



abc <- function(x) {1/(1+exp(-x))}

#制作列线图
plot(nomogram(logm2, fun=abc, funlabel = "发病风险", maxscale=10, lp=F,
              fun.at=c('0.9','0.85','0.80','0.70','0.6','0.5','0.4','0.3','0.1')),
              xfrac=.25)

# 












