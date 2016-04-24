
# 完全随机分组

grouprand <- function(seed,group,N){
	set.seed(seed)
	block = rep(1:ceiling(N/group),times=group)
	a1 = dataframe(block,rand=runif(lenth(block)))
}

seed=13
group = 6
N=36
block = rep(1:ceiling(N/blocksize), each = blocksize)
a1 <- data.frame(No=1:length(block),rand=runif(length(block)))
a2 <- a1[order(a1$rand),]
a3 <- data.frame(a2,block)
a4 <- a3[order(a3$No),]

grouprand <- function(seed,group,N){
	set.seed(seed)
	block = rep(1:ceiling(N/group),each=N/group)
	a1 <- as.data.frame(rand=runif(length(block)))
  a2 <- a1[order(a1$rand),]
  a3 <- data.frame(a2,block)
  a4 <- a3[order(a3$No),]
  a4
}

# 随机区组设计

blockrand = function(seed,blocksize,N){
  set.seed(seed)
  block = rep(1:ceiling(N/blocksize), each = blocksize)
  a1 = data.frame(block, rand=runif(length(block)), envelope= 1: length(block))
  a2 = a1[order(a1$block,a1$rand),]
  a2$arm = rep(c("Arm 1", "Arm 2"),times = length(block)/2)
  assign = a2[order(a2$envelope),]
  return(assign)
}


