d <- data.frame(age=c(25,35,45,55,65),var=c("1,2,3","1,2","3","2","1"))

lev <- levels(factor(d$var))
lev <- unique(unlist(strsplit(lev, ",")))
mnames <- gsub(" ", "_", paste("var", lev, sep = "."))
result <- matrix(data = "0", nrow = length(d$var), ncol = length(lev))
char.var <- as.character(d$var)
for (i in 1:length(lev)) {
  result[grep(lev[i], char.var, fixed = TRUE), i] <- "1"
}
result <- data.frame(result, stringsAsFactors = TRUE)
colnames(result) <- mnames
d <- cbind(d,result)

vars <- c("var.1","var.2","var.3")
as.table(sapply(d[,vars], function(v) {
  sel <- as.numeric(v==1)
  sum(sel)
}))
