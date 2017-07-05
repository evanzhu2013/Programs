complete <- function(directory,id=1:332){
        files_list <- list.files(directory,full.names=TRUE)
        nobs <- as.numeric()
        for (i in id){
                internal <- sum(complete.cases(read.csv(files_list[i])))
                nobs <-c(nobs,internal)}
        completed <- data.frame(id,nobs)
        completed
}