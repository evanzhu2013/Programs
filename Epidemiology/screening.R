#---------------------------------------------------------------------#
# Title: 筛检指标的计算
# Author: 朱雷
# Date Created: 2015.06.23
# Date Modified: 2015.06.29
# Version: 1.1
#---------------------------------------------------------------------#


#-------------------------------筛检指标的计算------------------------------------#

# Method 1

# 创建筛检指标计算函数
screenfun <- function(pp=NUll,np=NUll,pn=NUll,nn=NUll){
	# pp diagnosed as patients with gold standard and screened as positive
	# pn diagnosed as patients with gold standard but screened as negative
	# np diagonsed as non-patients with gold standard but screened as positive
	# nn dianosed as non-patients with gold standard and screened as negative
	sensitivity <- pp/(pp+pn)
	false_negative_rate <- pn/(pp+pn)
	specificity <- nn/(np+nn)
	false_positive_rate <- np/(np+nn)
	Youden_Index <-  pp/(pp+pn)+nn/(np+nn)-1
	postive_likelihood_ratio <- sensitivity/(1-specificity)
	negative_likelihood_ratio <- (1-sensitivity)/specificity
	consistency_rate <- (pp+nn)/(pp+np+pn+nn)
	Kappa <- ((pp+pn+np+nn)*(pp+nn)-((pp+np)*(pp+pn)+(pn+nn)*(np+nn)))/(((pp+pn+np+nn))^2-((pp+np)*(pp+pn)+(pn+nn)*(np+nn)))
	postive_predictive_value <- pp/(pp+np)
	negative_predictive_value <- nn/(nn+pn)
	results1 <- c(sensitivity*100,specificity*100,false_negative_rate*100,false_positive_rate*100,consistency_rate*100,Kappa,postive_predictive_value*100,negative_predictive_value*100)
    results2 <- c(Youden_Index,postive_likelihood_ratio,negative_likelihood_ratio)
	names1 <- c('灵敏度 ','特异度 ','假阴性率 ','假阳性率 ','符合率 ','Kappa ','阳性预测值 ','阴性预测值 ')
	names2 <- c('正确指数','阳性似然比','阴性似然比 ')
    c(paste(names1,round(results1,1),'%',sep=''),paste(names2,round(results2,2),sep=' '))
}

# 输入需要计算的数据

screenfun(165,80,45,730)

# Method 2

library(epiR)
library(epicalc)

rnames=c('阳性','阴性')
cnames=c('患者','非患者')

dat <- as.table(matrix(c(165,80,45,730),byrow=T,nrow=2,dimnames=list(rnames,cnames))) # 转换数据类型

summary(epi.tests(dat))  # 筛检指标的计算

epi.kappa(dat)$kappa # Kappa值的计算

#-----------------------------------ROC曲线的制作--------------------------------------#

# ROC from a diagnostic table
library(epicalc)
rnames=as.character(1:4)
cnames=c('非患者','患者')
dat <- as.table(matrix(c(1,30,60,15,0,0,10,80),ncol=2,dimnames=list(rnames,cnames))) # 创建自定义数据集

roc.from.table(dat, title=TRUE, auc.coords=c(0.35,0.15), cex=1.2) #显示标题以及AUC大小

roctable <- roc.from.table(dat,graph=F)

text(x=roctable$diagnostic.table[,1], y=roctable$diagnostic.table[,2],  #标注截断值
	labels=rownames(roctable$diagnostic.table), cex=1.2)


# ROC curve from logistic regression

library(AER)
library(epicalc)
data(Affairs)
Affairs$ynaffair <- ifelse(Affairs$affairs>0,1,0) # 生成是否’出轨‘的二分类变量
Affairs$ynaffair <- factor(Affairs$ynaffair,levels=c(0,1),labels=c("No","Yes")) # 转为因子并加标签

fit.full <- glm(ynaffair~gender+age+yearsmarried+children+education+occupation+rating+religiousness,data=Affairs,family=binomial())
summary(fit.full)

fit.reduced <- glm(ynaffair~age+yearsmarried+rating+religiousness,data=Affairs,family=binomial())
summary(fit.full)

lroc(fit.reduced,auc.coords=c(0.4,0.15)) #计算ROC并绘制ROC曲线
