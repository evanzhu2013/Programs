# Title: logistic Nomogram

# ������Ҫ��R��
library(foreign)
library(rms)

# ��������csv�ļ�
gc <- read.csv('Mydata.csv')

#ɾ�����ݵ�ȱʧֵ��ȱʧֵ��֤
gc <- na.omit(gc)
aggr(gc,prop=F,numbers=T)

#ת�����������ͬʱ���ø���������ֵ��ǩ
gc$ALB <- as.factor(ifelse(gc$ALB==0,'<35g/L','>=35g/L'))
gc$'�׵���' <- gc$ALB
# �˴�ʡ�Ժܶ�

#ִ��log�Լ��𲽷��Ľ��
logm <- glm(admit ~ gre + gpa + rank, data = gc, family="binomial")
logm=step(logm)
a=predict.glm(logm)

mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
gc <- mydata

attach(gc)

# ����ת��
dd<-datadist(gc)
options(datadist='dd')

logm <- lrm(admit ~ gre + gpa + rank, data = gc)
logm2 <- glm(admit ~ gre + gpa + rank, data = gc, family="binomial")



abc <- function(x) {1/(1+exp(-x))}

#��������ͼ
plot(nomogram(logm2, fun=abc, funlabel = "��������", maxscale=10, lp=F,
              fun.at=c('0.9','0.85','0.80','0.70','0.6','0.5','0.4','0.3','0.1')),
              xfrac=.25)

#