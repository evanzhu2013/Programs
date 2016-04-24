# 四格表卡方的计算

#--------------
｜  a  ｜ b  ｜
#--------------
｜  c  ｜ d  ｜ 
#--------------

data= matrix(c(a,b,c,d),nrow=2)
chisq.test(data)
fisher.test(data)


# example:

data= matrix(c(24,43,23,39),nrow=2)
X_squared =chisq.test(data)[[1]]
dfc=chisq.test(data)[[2]]
p.value=chisq.test(data)[[3]]

data= matrix(c(24,43,23,39),nrow=2)
p.value=fisher.test(data)[[1]]
ci=fisher.test(data)[[2]]
OR=fisher.test(data)[[3]]

