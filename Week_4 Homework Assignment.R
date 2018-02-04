printVecInfo <- function(input) {
  # The paste string concatenation method found here:
  # https://www.math.ucla.edu/~anderson/rw1001/library/base/html/paste.html
  print(paste("Mean:", mean(input)))
  print(paste("Median:", median(input)))
  print(paste("Min:", min(input)))
  print(paste("Max:", max(input)))
  print(paste("SD:", sd(input)))
  print("Quantiles .05 - .95:")
  print(quantile(input, probs = c(0.05, 0.95)))
  print(paste("Skewness:", skewness(input)))
  
}

testVector <- c(1,2,3,4,5,6,7,8,9,10,50)

printVecInfo(testVector)

# I went with a matrix of 1's (which will evaluate as TRUE)
# Matrix code found here:
# http://www.r-tutor.com/r-introduction/matrix
jar <- matrix(c("Red", "Blue"), byrow = TRUE, ncol = 2, nrow = 50)

# Test should put out 50
sum(jar == "Red")

# Sampling and counting
handful = sample(jar, 10, replace = TRUE)
totalRed = sum(handful == "Red")
totalRed

# This gives output as percent not decimal
percentRed = totalRed / length(handful) * 100
percentRed

# Repeat 20 times with the mean of how many came up "Red"
replSampling = replicate(20, mean(sample(jar, 10, replace = T) == "Red"))
#Repeat 100 times
repl100 = replicate(100, mean(sample(jar, 10, replace = T) == "Red"))
# Print info and histogram of the 20 sample
printVecInfo(replSampling)
hist(replSampling)
#Print info and histogram of the 100 sample
printVecInfo(repl100)
hist(repl100)