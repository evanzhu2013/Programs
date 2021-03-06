# setwd('~/Downloads')

# 请先安装好各个相关包再运行代码

library(foreign) # 读取spss格式数据
library(survival)
library(rms)
library(VIM) # 包中aggr()函数，判断数据缺失情况

if (!require("VIM")) {
  install.packages("VIM", repos="https://cran.rstudio.com/")
  library("VIM")
}

par(family = "STXihei") # 指定绘制图片中的字体

# 数据来自张文彤《SPSS统计分析高级教程》，侵删！

url <- 'http://online.hyconresearch.com:4096/spss20/spss20advdata.zip' # 书中数据下载地址
file <- basename(url) # 获取文件名 spss20advdata.zip
if (!file.exists(file)) download.file(url, file) # 判断工作目录下是否有spss20advdata.zip文件，如果不存在则执行下载数据命令
unzip(file) # 解压缩zip文件

pancer <- read.spss('part4/pancer.sav') # 读取文件
pancer <- as.data.frame(pancer) # Cox回归所需数据类型为数据框格式，将其转换为数据框格式

aggr(pancer,prop=T,numbers=T) # 判断pancer各个变量的数据缺失情况，出现红色即有缺失，绘制列线图不允许缺失值存在

pancer$censor <- ifelse(pancer$censor=='死亡',1,0) # Cox回归结局变量需为数值变量

pancer$Gender <- as.factor(ifelse(pancer$sex=='男',"Male","Female"))
# 更改变量名称以及变量取值

pancer$Gendr <- relevel(pancer$Gender,ref='Female')

dd<-datadist(pancer)
options(datadist='dd') # 转换为绘制列线图格式

coxm <- cph(Surv(time,censor==1)~age+Gender+trt+bui+ch+p+stage,x=T,y=T,data=pancer,surv=T) # 建立Cox回归方程
surv <- Survival(coxm) # 建立生存函数

surv1 <- function(x)surv(1*3,lp=x) # 3月生存率
surv2 <- function(x)surv(1*6,lp=x) # 6月生存率
surv3 <- function(x)surv(1*12,lp=x) # 1年生存率

plot(nomogram(coxm,fun=list(surv1,surv2,surv3),lp= F,funlabel=c('3-Month Survival','6-Month survival','12-Month survival'),maxscale=100,fun.at=c('0.9','0.85','0.80','0.70','0.6','0.5','0.4','0.3','0.2','0.1')),xfrac=.25)

# maxscale参数指定最高分数，一般设置为100或者10分
# fun.at 设置生存率的刻度
# xfrac 设置数值轴与最左边标签的距离，可以调节下数值观察下图片变化情况

# 列线图绘制常见问题

# 1. 如何筛选变量？
# 与多变量统计分析变量筛选方法一样。列线图绘制纳入的变量即为coxm方程中的变量。

# 2. 如何更改图中变量名以及的变量值的名称，比如“sex”的"男"和"女"。
# 列线图中出现的名称，即变量名和变量值名称，修改变量名和变量值名即可修改列线图中的名称。

# 3. 如何更改多分类变量的参考组
