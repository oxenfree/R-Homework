totalBetween <- function(vector, low, high) {
  result <- vector[vector > low & vector < high]
  return(length(result))
}

rnorm(1000, 80)
lab3 <- rnorm(1000, 80)
lab3.1 <- rnorm(1000, 80)
lab3.2 <- rnorm(1000, 80)
totalBetween(lab3, 79, 81)
totalBetween(lab3.1, 79, 81)
totalBetween(lab3.2, 79, 81)