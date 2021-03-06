# 总体均数的置信区间

# t分布法
# 请输入均数x
# 请输入样本量n
# 请输入样本标准差s
# 请输入alpha a

ci <- c(x-s*qt(1-a/2,n-1)/sqrt(n),x+s*qt(1-a/2,n-1)/sqrt(n))
ci #置信区间

# 举例

# 已知某地27名健康成年男子血红蛋白含量的均数是125g/L, 标准差是15g/L。试估计该地健康成年男子血红蛋白平均含量的95%置信区间。

x= 125
s=15
n =27
a=0.05

# 正态分布法
# 请输入均数x
# 请输入样本量n
# 请输入样本标准差s
# 请输入alpha a

ci <- c(x-s*qnorm(1-a/2)/sqrt(n),x+s*qnorm(1-a/2)/sqrt(n))
ci 置信区间

# 已知某地27名健康成年男子血红蛋白含量的均数是125g/L, 标准差是15g/L。试估计该地健康成年男子血红蛋白平均含量的95%置信区间。

x= 125
s=15
n =27
a=0.05


# 总体概率的置信区间

# 正态性近似法
# 请输入样本的患病率p
# 请输入样本量n
# 请输入alpha a

ci <- c(p-sqrt(p*(1-p)/n)*qnorm(1-a/2),p+sqrt(p*(1-p)/n)*qnorm(1-a/2))
ci #置信区间

# 举例
# 用某种仪器检查已确诊的乳腺癌患者120名，检出乳腺癌患者94例，检出率为78.3％。试估计该仪器乳腺癌总体检出率的95%置信区间。
p=0.783
n=120
a=0.05





