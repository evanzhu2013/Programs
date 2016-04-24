# 一个均值（双侧）
library(TrialSize)
size=OneSampleMean.Equality(alpha,beta,sigma,margin)

# alpha 显著水平
# beta 功效= 1-beta
# sigma 标准差
# margin 样本均值与总体均值之差


# 两个均值 （双侧）
library(TrialSize)
sizeA=TwoSampleMean.Equality(alpha, beta, sigma, k, margin)
sizeB=k*sizeA
# alpha 显著水平
# beta 功效= 1-beta
# sigma 2组样本的标准差
# k 试验组和对照组之比
# margin 样本均值与总体均值之差

# 两个样本均值等效试验
library(TrialSize)
sizeA=TwoSampleMean.Equivalence(alpha, beta, sigma, k, delta, margin)
sizeB= sizeA*k

# alpha 显著水平
# beta 功效= 1-beta
# sigma 2组样本的标准差
# k 试验组和对照组之比
# delta 两组预设定差值
# margin 样本均值与总体均值之差

# 两个样本均值优效／非劣效试验
sizeA=TwoSampleMean.NIS(alpha, beta, sigma, k, delta, margin)
sizeB=sizeA*k
# alpha 显著水平
# beta 功效= 1-beta
# sigma 2组样本的标准差
# k 试验组和对照组之比
# delta 两组预设定差值
# margin = μ2 − μ1

# 单样本比例（双侧）
library(TrialSize)
size= OneSampleProportion.Equality(alpha, beta, p, delta)

# alpha 显著水平
# beta 功效= 1-beta
# p 比例
# delta=p-p0
# 两样本比例比较

library(TrialSize)
sizeA=TwoSampleProportion.Equality(alpha, beta, p1, p2, k, delta)
sizeB=k*sizeA
# alpha 显著水平
# beta 功效= 1-beta
# p1 试验组的率
# p2 对照组的率
# k 试验组和对照组样本量之比
# delta = p1-p2


# 两个样本比例等效试验
library(TrialSize)
sizeA=TwoSampleProportion.Equivalence(alpha, beta, p1, p2, k, delta, margin)
sizeB=sizeA*k

# alpha 显著水平
# beta 功效= 1-beta
# p1 试验组的率
# p2 对照组的率
# k 试验组和对照组样本量之比
# delta = p1-p2

# 两个样本比例优效／非劣效试验
library(TrialSize)
sizeA=TwoSampleProportion.NIS(alpha, beta, p1, p2, k, delta,margin)
sizeB=sizeA*k

# alpha 显著水平
# beta 功效= 1-beta
# p1 试验组的率
# p2 对照组的率
# k 试验组和对照组样本量之比
# delta = p1-p2
# margin 两组预设定差值


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

data= matrix(c(24,43,23,39),nrow=2)ａ
X_squared =chisq.test(data)[[1]]
dfc=chisq.test(data)[[2]]
p.value=chisq.test(data)[[3]]


data= matrix(c(24,43,23,39),nrow=2)
fisher.test(data)[[1]]
fisher.test(data)[[2]]
fisher.test(data)[[3]]


# 单个均值的95%置信区间

# t分布法
m 为均数
n 为样本量
s 为标准差
a 为置信度

CI_down  = m - qt(a/2,n-1)*s/sqrt(n)
CI_upper = m - qt(a/2,n-1)*s/sqrt(n)
CI_down
CI_upper

# 正态近似法

t分布法
m 为均数
n 为样本量
s 为标准差
α 为置信度

CI_down  = m- qnorm(1-a/2)*s/sqrt(n)
CI_upper = m- qnorm(1-a/2)*s/sqrt(n)
CI_down
CI_upper












