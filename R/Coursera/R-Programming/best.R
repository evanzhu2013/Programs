
best <- function(state,outcome){
    out <- read.csv("outcome-of-care-measures.csv",stringsAsFactors=FALSE)
    out <- out[,c(2,7,11,17,23)]
    out[,3] <- as.numeric(out[,3])
    out[,4] <- as.numeric(out[,4])
    out[,5] <- as.numeric(out[,5])
    State_list <- out[,2]
    if (!outcome %in% c("heart attack","heart failure","pneumonia")) stop("invalid outcome")
    if (!state %in% State_list) stop("invalid state")   
    names(out) <- c("names","states","heart attack","heart failure","pneumonia")
    filtered<- out[out$states==state,]
    one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
    one[1,1]
	}
