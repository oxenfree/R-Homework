library(data.table)
readStates <- function() {
  # Following code (to the return statement) found in 
  # An Introduction to Data Science, Saltz, Stanton 2017
  csvUrl <- "http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"
  result <- read.csv(csvUrl)
  # Cleanup the dataframe
  result <- result[-1:-8,]
  result <- result[, 1:5]
  result <- result[-52:-58,]
  result$stateName <- result[,1]
  # Get rid of the dot in the state names
  result$stateName <- gsub("\\.", "", result$stateName)
  result <- result[, -1]
  # Get rid of the comma in population data
  result$april10Census <-gsub(",", "", result$X)
  result$april10Base <-gsub(",", "", result$X.1)
  result$july10Pop <-gsub(",", "", result$X.2)
  result$july11Pop <-gsub(",", "", result$X.3)
  # Get rid of any spaces and also change the column to a numerical
  result$april10Base <- as.numeric(gsub(" ", "", result$april10Base))
  result$april10Census <- as.numeric(gsub(" ", "", result$april10Census))
  result$july10Pop <- as.numeric(gsub(" ", "", result$july10Pop))
  result$july11Pop <- as.numeric(gsub(" ", "", result$july11Pop))
  # Remove X.* column names
  result <- result[, -1:-4]
  # Reset row numbers
  rownames(result) <- NULL
  return(result)
}

dfStates <- readStates()
mean(dfStates$april10Census)
attach(dfStates)
# Row with max population based on April 2010 census data
max(april10Census)
# State name from row with max population -- results: California
dfStates[dfStates$april10Census >= max(april10Census), 1]
# Ordered dataframe descending sort based on 2010 census data
orderedStates <- dfStates[order(april10Census), ]

# First attempt at percentag below a certain value
# a bit more robust than the second way.
# Includes a bit of error checking and returns false
percentageBelowValue <- function(haystack, needle) {
  result <- which(haystack < needle)
  # Error check and return false
  if (length(result) < 1) return(F)
  
  # Otherwise return
  return(length(result) / length(haystack))
}

# Attempt 2.
# Maybe a little less robust. Just relying on error-checking
# in the native R functions
percentBelowValue2 <- function(haystack, needle) {
  return(sum(haystack < needle) / length(haystack))
}

percentageBelowValue(april10Census, mean(april10Census))
percentBelowValue2(april10Census, mean(april10Census))
detach(dfStates)
