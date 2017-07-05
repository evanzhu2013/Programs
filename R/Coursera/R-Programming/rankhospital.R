rankhospital <- function(state, outcome, num = "best") {
    out <- read.csv("outcome-of-care-measures.csv",stringsAsFactors=FALSE)
    out <- out[,c(2,7,11,17,23)]
    out[,3] <- as.numeric(out[,3])
    out[,4] <- as.numeric(out[,4])
    out[,5] <- as.numeric(out[,5])
    State_list <- out[,2]
    if (!outcome %in% c("heart attack","heart failure","pneumonia")) stop("invalid outcome")
    if (!state %in% State_list) stop("invalid state")  
    names(out) <- c("names","states","heart attack","heart failure","pneumonia")
    filtered <- out[out$states==state,]
    filtered <- na.omit(filtered)
# choose
	if (num=="best") {
    	one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
    	return(one[1,1])
	} 
	if (num=="worst") {
	one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
    	return(one[nrow(filtered),1])
	
	if (num > nrow(filtered)) {
		return(NA)
	}
    else {
	one <- filtered[order(filtered[,outcome],filtered[,1],na.last = NA),]
    one[num,1]
	}

	}