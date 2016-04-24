
# Date Created: 2016.04.24
# Heritability using Bootstrap
#

gene <- read.table('/Users/Evan/DataScience/Programs/Bootstrap/data.txt',header = T)

OR_fun <- function(data,indices){
  d <- data[indices,]
  A_A <-  nrow(subset(d, group==1 & genotype==2))
  C_A <-  nrow(subset(d, group==0 & genotype==2))
  A_T <-  nrow(subset(d, group==1 & genotype==3))
  C_T <-  nrow(subset(d, group==0 & genotype==3))
  B <-  nrow(subset(d, group==1 & genotype==1))
  D <-  nrow(subset(d, group==0 & genotype==1))
  lambda <- log(A_A*D/(B*C_A))/log(A_T*D/(B*C_T))
  return(lambda)
}

library(boot)
set.seed(20160424)
results <- boot(statistic = OR_fun,R=10000,data=gene)
boot.ci(results,type='bca')
