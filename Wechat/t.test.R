
# -----------单样本t检验(单侧)------------------------------

# 单样本t检验(样本均值小于总体均值)
# 输入样本均值sample_mean
# 输入总体均值total_mean

t <- t.test(x,mu=10,alternative="less")[[1]]
t # 统计量值
pval <- t.test(x,mu=10,alternative="less")[[3]]
pval # p值

# sample_mean  样本均值
# total_mean   总体均值  
# s  标准差
# n  样本量

# 单样本t检验(样本均值大于总体均值)
# 输入样本均值sample_mean
# 输入总体均值total_mean
t <- t.test(x,mu=10,alternative="greater")[[1]]
t # 统计量值
pval <- t.test(x,mu=10,alternative="greater")[[3]]
pval # p值



