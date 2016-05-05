

##自定义函数

setwd('/Users/Evan/DataScience/Programs/Collection') # 指定工作目录

result <- as.data.frame(matrix(data = 1:200, nrow = 200, ncol = 3),stringsAsFactors=T) # 创建容纳数据框

x <- read.table('data1.txt',header=T) # 导入数据

set.seed(20160505) # 设定随机种子，便于重复结果

for (i in 1:200)

{
      da <- x[sample(1:nrow(x),nrow(x),replace=TRUE),]

      TT_Ca <-  nrow(subset(da, group==1 & snp==1))
      AT_Ca <-  nrow(subset(da, group==1 & snp==2))
      AA_Ca <-  nrow(subset(da, group==1 & snp==3))
      TT_Co <-  nrow(subset(da, group==0 & snp==1))
      AT_Co <-  nrow(subset(da, group==0 & snp==2))
      AA_Co <-  nrow(subset(da, group==0 & snp==3))

      result[i,2] <- ((AT_Ca*TT_Co)/(AT_Co*TT_Ca))
      result[i,3] <- (AA_Ca*TT_Co)/(TT_Ca*AA_Co)
}

names(result) <- c('Times','AT','AA') # 数据框重命名

lam<- lm(log(result$AT) ~ log(result$AA) -1,data=result)
lam
confint(lam,,0.95)
