# 导入数据

setwd('/Users/Evan/DataScience/Programs/Grey Model/')

library(readr)
nation_TB <- read_csv('/Users/Evan/Desktop/TB2014/nation_TB.csv')
source('grey model.R')
x0 <- gm11(nation_TB,length(nation_TB)+12)






#
# plot(case,col='blue',type='b',pch=16,xlab='时间序列',ylab='值')
# points(x0,col='red',type='b',pch=4)
# legend('topleft',c('预测结果','原始数据'),pch=c(16,4),lty=c('b','l'),col=c('blue','red'))
