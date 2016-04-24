
setwd('/Users/Evan/Downloads/heatmap-source/')
library(RColorBrewer)
nba <- read.csv("ppg2008.csv", sep=",")
nba <- nba[order(nba$PTS),]
row.names(nba) <- nba$Name
nba <- nba[,2:20]
nba_matrix <- data.matrix(nba)

nba_heatmap <- heatmap(nba_matrix, scale="column", margins=c(5,10))

nba_heatmap <- heatmap(nba_matrix, col = brewer.pal(9, "Blues"), scale="column", margins=c(5,10))
