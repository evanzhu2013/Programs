# Example from Survival Analysis- A Self-Learning Text, Third Edition

library(survival)
addicts <- read.table('ADDICTS.txt',T)
names(addicts) <- c('id','clinic','status', 'survt','prison','dose')

# 1. 估计生存函数，观察不同组间的区别

# 建立生存对象
Surv(addicts$survt,addicts$status==1)

# 估计KM生存曲线
y <- Surv(addicts$survt,addicts$status==1)
kmfit1 <- survfit(y~1)
summary(kmfit1)
plot(kmfit1)

# 根据clinic分组估计KM生存曲线
kmfit2 <- survfit(y~addicts$clinic)
plot(kmfit2, lty = c('solid', 'dashed'), col=c('black','blue'),
     xlab='survival time in days',ylab='survival probabilities')
legend('topright', c('Clinic 1','Clinic 2'), lty=c('solid','dashed'),
       col=c('black','blue'))

# 检验显著性
survdiff(Surv(survt,status)~clinic, data=addicts)

# 用strata来控制协变量的影响
survdiff(Surv(survt,status) ~ clinic +strata(prison),data=addicts)

# 2. 用图形方法检验PH假设

plot(kmfit2,fun='cloglog',xlab='time in days using logarithmic
     scale',ylab='log-log survival', main='log-log curves by clinic')
# 不平行，不符合PH假设

#  3. 构建COX PH回归模型

y <- Surv(addicts$survt,addicts$status==1)
coxmodel <- coxph(y~ prison + dose + clinic,data=addicts)
summary(coxmodel)

# 两模型选择
mod1 <- coxph(y ~ prison + dose + clinic,data=addicts)
mod2 <- coxph(y ~ prison + dose + clinic + clinic*prison
           + clinic*dose, data=addicts)

anova(mod1,mod2)
stepAIC(mod2)
# 简洁模型更好

# 风险预测
predict(mod1,newdata=pattern1,
        type='risk')

# 4. 构建一个stratified Cox model.

# 当PH假设在clinic不成立，控制这个变量
mod3 <- coxph(y ~ prison + dose +
                strata(clinic),data=addicts)
summary(mod3)

#  5.对PH假设进行统计检验

mod1 <- coxph(y ~ prison + dose + clinic,data=addicts)
cox.zph(mod1,transform=rank)
# P值小显示PH假设不符合
# 显示系数变化图
plot(cox.zph(mod1,transform=rank),se=F,var='clinic')

#  6. 得到COX调整后生存曲线

mod1 <- coxph(y ~ prison + dose + clinic,data=addicts)
pattern1 <- data.frame(prison=0,dose=70,clinic=2)
summary(survfit(mod1,newdata=pattern1))
plot(survfit(mod1,newdata=pattern1),conf.int=F)

mod3 <- coxph(y ~ prison + dose +
                strata(clinic),data=addicts)
pattern2 <- data.frame(prison=.46,dose=60.40)
plot(survfit(mod3,newdata=pattern2),conf.int=F)

# 7. 构建参数模型

modpar1 <- survreg(Surv(addicts$survt,addicts$status) ~
                     prison +dose +clinic,data=addicts,
                   dist='exponential')
summary(modpar1)
