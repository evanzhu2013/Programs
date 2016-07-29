# Data Created: 16/7/19
# Title: Simulation

# 随机种子，习惯为日期

rm(list = ls())

set.seed(20170719)

poolA <- rbinom(10000,1,0.5)
poolB <- rbinom(10000,1,0.5)
Table <-  matrix(rbind(table(poolA),table(poolB)),nrow=2,dimnames=list(c('A','B'),c('0','1')))

fisher.test(Table)$p.value

p_pool = c()

for (i in 1:1000){

        A <- sample(poolA,20,replace=F)
        B <- sample(poolB,20,replace=F)

        Table <-  matrix(rbind(table(A),table(B )),nrow=2,dimnames=list(c('A','B'),c('0','1')))

        p_pool <- c(fisher.test(Table)$p.value,p_pool)

}

sum(p_pool>0.05)
