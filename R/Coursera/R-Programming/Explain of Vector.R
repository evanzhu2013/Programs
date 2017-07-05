make_vector <- function(x=numeric()){
    m <- NULL
    ## Creates a new variable in the environment of makeVector
    set <- function(y){
    x <<- y
    m <<-NULL
    }
    #使用set函数将y赋值到x

    get <- function() x
    #取得所输入的值

    setmean <- function(mean) {
        m <<- mean}

    ## This sets m to mean in the parent env (makeVector())

    getmean <- function() {
        m}

    ## R will look for the value of m in getmean()
    ## R won't find one within getmean, so it'll look to the parent environment makeVector for m value

    list(set=set,get=get,
        setmean=setmean,
        getmean=getmean)
}
  ## Allows you to access these functions outside of makeVector environment

##上面的函数就是一个容器


cachemean <- function(x, ...) {
        m <- x$getmean()
     ## x$getmean() is an operator that calling the getmean function from x
     ## which is really a list of functions, the output of which is then assigned to m

        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }

        ## This checks if m has an existing value. If TRUE, then return that value.
        ## If there's no existing value, function will calculate it below
        data <- x$get()
        ## Extracts get() function from the list in x, which won't have an m value
        m <- mean(data, ...)
        ## Computes mean from data
        x$setmean(m)
        ## Extracts setmean function, which updates m in the parent env of the makeVector() function
        ## setmean <- function(mean) m <<- mean
        m
        ## Prints mean 
}















