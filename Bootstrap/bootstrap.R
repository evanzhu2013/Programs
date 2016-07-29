
library(boot)

datsam <- read.csv('/Users/Evan/Desktop/Academic/Datasets/datsam.csv')

head(datsam)

datsam$outcome <- datsam$outcome -1

# Set up the non-parametric bootstrap

logit.bootstrap <- function(data, indices) {

  d <- data[indices, ]
  fit <- glm(outcome ~ A * B, data = d, family = "binomial")
  reri <- exp(fit$coef[2]+fit$coef[3]+fit$coef[4]) - exp(fit$coef[2]) - exp(fit$coef[3]) + 1
  return(reri)
}

set.seed(12345) # seed for the RNG to ensure that you get exactly the same results as here

logit.boot <- boot(data=datsam, statistic=logit.bootstrap, R=100) # 10'000 samples

logit.boot
