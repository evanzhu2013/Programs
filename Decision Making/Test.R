# 两样本T检验

# 如果录入人员不按照格式输入如何处理？

# 例如：出现非数字符号，中间有多个分隔符,输入框前后有多余空格等

library(stringr)
a = '13,23,34,56,67,78,89,96'
b = '12,33,34,34,55,34,34,56'

a <- str_trim(a)
b <- str_trim(b)

A <- as.numeric(unlist(strsplit(a,split=',')))
B <- as.numeric(unlist(strsplit(b,split=',')))

# 正态性检验、方差齐性检验

t.test(A,B)

p_value = t.test(A,B)$p.value
df = t.test(A,B)$parameter
t = t.test(A,B)$statistic

# 方差分析

library(stringr)
a = '13,23,34,56,67,78,89,96'
b = '12,33,34,34,55,34,34,56'
c = '12,23,33,44,45,55,34,45'

a <- str_trim(a)
b <- str_trim(b)
c <- str_trim(c)

A <- as.numeric(unlist(strsplit(a,split=',')))
B <- as.numeric(unlist(strsplit(b,split=',')))
B <- as.numeric(unlist(strsplit(c,split=',')))

# 正态性检验、方差齐性检验
# 转换成方差分析aov格式
