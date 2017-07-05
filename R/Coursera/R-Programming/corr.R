 corr <- function(directory,threshold=0){
         options(digits=4)
     files_list <- list.files(directory,full.names=TRUE)
     correlation <- as.numeric()
     for (i in 1:332){
         complete_cases <- na.omit(read.csv(files_list[i]))
         if (length(complete_cases$sulfate) > threshold ){ 
             data1 <- cor(complete_cases$sulfate,complete_cases$nitrate)
             correlation <- c(correlation,data1)
         }
     }
 return(correlation)
 }