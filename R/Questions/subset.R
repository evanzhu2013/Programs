a=c(1:4)
b=c(NA,1:3)
c=data.frame(a,b)
c[c$b==1,]
subset(c,b==1)

c[1]
c[[1]]
c[,1]
c[1,]
