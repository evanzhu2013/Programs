# 创建数据

data <- data.frame(variable = c('gender','age','height','weight','gene'),or=rnorm(5,1,0.5))
data$ci_upper <- data$or + rnorm(5,0.1,0.05)
data$ci_lower <- data$or - rnorm(5,0.1,0.05)


# 绘图

p <- ggplot(data,aes(x=variable,y=or))+geom_point(size=2)+geom_errorbar(aes(ymin=ci_lower,ymax=ci_upper),width=0.2)+coord_flip()+ylab('OR')+xlab('Variable')+theme_bw()+theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())

p+ geom_hline(yintercept=1,linetype=2)
