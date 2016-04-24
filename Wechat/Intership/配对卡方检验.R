配对卡方检验

mcnemar_test <- function (x, y = NULL, correct = TRUE) 
{
    if (is.matrix(x)) {
        r <- nrow(x)
        if ((r < 2) || (ncol(x) != r)) 
            stop("'x' must be square with at least two rows and columns")
        if (any(x < 0) || anyNA(x)) 
            stop("all entries of 'x' must be nonnegative and finite")
        DNAME <- deparse(substitute(x))
    }
    else {
        if (is.null(y)) 
            stop("if 'x' is not a matrix, 'y' must be given")
        if (length(x) != length(y)) 
            stop("'x' and 'y' must have the same length")
        DNAME <- paste(deparse(substitute(x)), "and", deparse(substitute(y)))
        OK <- complete.cases(x, y)
        x <- as.factor(x[OK])
        y <- as.factor(y[OK])
        r <- nlevels(x)
        if ((r < 2) || (nlevels(y) != r)) 
            stop("'x' and 'y' must have the same number of levels (minimum 2)")
        x <- table(x, y)
    }
    PARAMETER <- r * (r - 1)/2
    METHOD <- "McNemar's Chi-squared test"
    if (correct && (r == 2) && any(x - t(x) != 0)) {
        y <- (abs(x - t(x)) - 1)
        METHOD <- paste(METHOD, "with continuity correction")
    }
    else y <- x - t(x)
    x <- x + t(x)
    STATISTIC <- sum(y[upper.tri(x)]^2/x[upper.tri(x)])
    PVAL <- pchisq(STATISTIC, PARAMETER, lower.tail = FALSE)
    names(STATISTIC) <- "McNemar's chi-squared"
    names(PARAMETER) <- "df"
    RVAL <- list(statistic = STATISTIC, parameter = PARAMETER, 
        p.value = PVAL, method = METHOD, data.name = DNAME)
    class(RVAL) <- "htest"
    return(RVAL)
}

# 请输入
# 两种方法均为阳性的结果 a
# 两种方法均为阴性的结果 d
# 第一种方法阳性但第二种方法阴性的结果 b
# 第一种方法阴性但第二种方法阳性的结果 c


chisq <- mcnemar_test(matrix(c(a,b,c,d),nrow=2))[[1]]
chisq # 卡方数值
pval<- mcnemar_test(matrix(c(a,b,c,d),nrow=2))[[3]]
pval # p值











