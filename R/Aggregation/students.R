# 30个学生，分为2个班级，变量值性别，身高


sex <- gl(n=2,k=15) # 性别因子变量
height <- rnorm(n=30,mean=165,sd=4) # 身高假定正态分布
class <- rbinom(n=30,size = 1,prob=0.5) # 随机分班级
group <- rbinom(n=30,size = 1,prob=0.5) # 随机分组
class <- rbinom(n=30,size = 1,prob=0.5) # 随机分班级
class <- as.factor(class)
group <- as.factor(group)
students <- data.frame(sex,height,class,group) 

ftable(table(students$sex,students$class,students$group))
ftable(xtabs(~sex+class+group,data=students))
prop.table(table(students$sex,students$class,students$group))

fun <- function(x){
	c(sd=sd(x),mean=mean(x))
}

aggregate(height~class+sex,data=students,fun)




