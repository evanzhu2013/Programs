
library(gcookbook)
#加载演示中所需的数据集
library(ggplot2) ＃加载ggplot2包
sp <- ggplot(heightweight,aes(x=ageYear, y=heightIn))
sp+geom_point()+stat_smooth(method=lm,level=0.99)
# method参数指定模型的类型，此处线性模型, level参数指定置信区间的范围，
一般取0.95以及0.99）

sp+geom_point)+stat_smooth(method=loess, level=0.99)
# 只要将method改成loess即可。

library(MASS) #加载演示中所需的数据集
biopsy$classn[biopsy$class=='benign'] <- 0
biopsy$classn[biopsy$class=='malignant'] <- 1

# 根据公示获取预测值
ggplot(biopsy, aes(x=V1, y=classn))
+geom_point(position=position_jitter(width=0.3, height=0.06), alpha=0.4)
+stat_smooth(method=glm, family=binomial)

置信带的意义是：在满足线性回归的假设条件下，可以认为真实的回归直线落在弧形
