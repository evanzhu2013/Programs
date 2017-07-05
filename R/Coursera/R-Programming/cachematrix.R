
# The makeCacheMatrix is a container.
makeCacheMatrix<- function(x){
	m <- NULL           #create a new variable in the envieronemnt of make_matrix
	set <- function(y){ 
	x <<- y   #assign the value of y to x in make_matrix environment
	m <<-NULL
	}
	get <- function() x    # Returns original matrix
	setinverse <- function(inverse){
		m <<- inverse
	}
	getinverse <- function(){ # Returns matrix inverse
		m
	}
	list(set=set,get=get,setinverse=setinverse,getinverse=getinverse) ## Allows you to access these elements outside of makeVector environment

}

# Get or compute cached matrix inverse
cacheSolve <- function(x, ...){
	m <- x$getinverse()
	if(!is.null(m)){       # Returns cached matrix inverse using previously computed matrix inverse
		message("getting cached data")
		return(m)
	}
	data <- x$get()  # Computes, caches, and returns new matrix inverse
	m <- solve(data, ...)
	x$setinverse(m)
	m
}
