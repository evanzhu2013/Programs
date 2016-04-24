# -----------单样本t检验(双侧)------------------------------
# 单样本t检验(双侧)

# 输入样本均值sample_mean
# 输入总体均值total_mean

t=(sample_mean-total_mean)/(s/sqrt(n))
t # 统计量值
pval= 2*pt(t,df=n-1)
pval # p值

# sample_mean  样本均值
# total_mean   总体均值  
# s  标准差
# n  样本量

# -------------配对本t检验(双侧)-----------------------------

# 配对t检验

# 请输入配对两组差值均数
# 请输入对子数

t=(d-0)/(s/sqrt(n))
t # 统计量值
pval= 2*pt(t,df=n-1)
pval # p值

# d  两组差值
# s  标准差
# n  样本量

# example:

d=3.25
n=12
s=2.491

# -------------两样本t检验(双侧)-----------------------------

# 两样本t检验

v = ((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2) # 自由度
t = (x1-x2)/(sqrt(v^2*(1/n1+1/n2))) 
t # 统计量值
pval= 2*pt(t,df=n1+n2-1)
pval # p值

# ---------------------两样本t'检验(双侧)--------------------

# 请输入对照组均值x1
# 请输入对照组标准差s1
# 请输入对照组样本了n1

# 请输入病例组均值x2
# 请输入病例组标准差s2
# 请输入病例组样本了n2


t=(x1-x2)/sqrt(s1^2/n1+s2^2/n2)
t # 统计量值
v= (s1^2/n1+s2^2/n2)^2/((s1^2/n1)^2/(n1-1)+(s2^2/n2)^2/(n2-1) # 自由度
pval= 2*pt(t,df=v)
pval # p值



# ---------------------四格表卡方的计算--------------------

#--------------
｜  a  ｜ b  ｜
#--------------
｜  c  ｜ d  ｜ 
#--------------

# 请输入病例组患病人数 a
# 请输入病例组正常人数 b 
# 请输入对照组患病人数 c
# 请输入对照组正常人数 d

data= matrix(c(a,b,c,d),nrow=2)
chisq.test(data) 
X_squared =chisq.test(data)[[1]] # 卡方值
dfc=chisq.test(data)[[2]] # 自由度
p.value=chisq.test(data)[[3]] # p值


fisher.test(data)
p.value=fisher.test(data)[[1]] # p值
OR=fisher.test(data)[[3]]   # 比值比
ci_low=fisher.test(data)[[2]][1]   # 置信区间下限
ci_upper=fisher.test(data)[[2]][2]   # 置信区间上限


# example:

data= matrix(c(24,43,23,390),nrow=2)
X_squared =chisq.test(data)[[1]]
dfc=chisq.test(data)[[2]]
p.value=chisq.test(data)[[3]]

data= matrix(c(24,43,23,390),nrow=2)
p.value=fisher.test(data)[[1]]
OR=fisher.test(data)[[3]]
ci=fisher.test(data)[[2]]



