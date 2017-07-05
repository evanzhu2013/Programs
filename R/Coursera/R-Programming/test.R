rankall <- function(outcome, num = "best") {

## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name

    out <- read.csv("outcome-of-care-measures.csv")
    out <- out[,c(2,7,11,17,23)]
    out[,3] <- as.numeric(out[,3])
    out[,4] <- as.numeric(out[,4])
    out[,5] <- as.numeric(out[,5])
    out <- na.omit(out)
    names(out) <- c("names","states","heart attack","heart failure","pneumonia")
	filtered <- split(out,out$states)
	rankout <- function(filtered){filtered[order(filtered[,"heart attack"],filtered[,1]na.last = NA),]}

	lapply(filtered,getrank)



}
	
}

getrank <- function(outcome,num="best"){
    if (num=="best") {
        one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
        return(one[1,1])
    } 
    if (num=="worst") {
    one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
        return(one[nrow(filtered),1])
    } 
    if (num > nrow(filtered)) {
        return(NA)
    }
    else {
    one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
    one[num,1]
    }