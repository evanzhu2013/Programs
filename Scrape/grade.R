library(rvest)
library(xlsx)
setwd('/Users/Evan/DataScience/R-programming')
url <- 'https://admission.pku.edu.cn/html/sscscj/00099.html'
raw <- read_html(url)
tables <- html_nodes(raw, "table") # list of tables on the site
grade <- rvest::html_table(tables[[1]])
names(grade) <- c("id","politics","english","c1","c2","score","rank","rank_sch","id_reg")

grade$id <- as.character(grade$id)
grade <- subset(grade,substr(grade$id,1,11)=="10001600893" & score != "")

# results <- subset(grade,score > 320)

# grade[,2:8] <- sapply(grade[,2:8],as.numeric)

grade_zz <- subset(grade,substr(grade$id_reg,1,4)=="4119" & score != "")
