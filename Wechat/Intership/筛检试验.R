#-------------------------------筛检指标的计算------------------------------------#



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

# pp为金标准和筛检试验皆诊断为病人
# np为金标准诊断为不是病人，但是筛检时间诊断为病人
# pn为金标准诊断为病人但是筛检试验诊断为不是病人
# nn为金标准和筛检试验皆诊断为病人


pp= 165
np = 80
pn = 45
nn = 730

screenfun(pp,np,pn,nn)
