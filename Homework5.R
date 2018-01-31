
readJson <- function() {
  jsonURL <- "http://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD"
  rawJson <- fromJSON(jsonURL, simplifyDataFrame = TRUE)
  return(as.data.frame(rawJson[["data"]]))
}

jsonDf <- readJson()
jsonDf <- jsonDf[, -c(1:8)]
namesOfColumns <-
  c("CASE_NUMBER","BARRACK","ACC_DATE","ACC_TIME","ACC_TIME_CODE","DAY_OF_WEEK","ROAD",
    "INTERSECT_ROAD","DIST_FROM_INTERSECT","DIST_DIRECTION","CITY_NAME","COUNTY_CODE",
    "COUNTY_NAME","VEHICLE_COUNT","PROP_DEST","INJURY","COLLISION_WITH_1","COLLISION_WITH_2")
names(jsonDf) <- namesOfColumns

jsonDf$DAY_OF_WEEK <- gsub(' ', '', jsonDf$DAY_OF_WEEK)
accSundaySQL <- sqldf("select count(CASE_NUMBER) from jsonDf where jsonDf.DAY_OF_WEEK = 'SUNDAY'")
accInjurySQL <- sqldf("select count(CASE_NUMBER) from jsonDf where INJURY = 'YES'")

# Everything above this line was taken from either the book or asynch material
# Everything below this line is a combination of
# https://www.r-bloggers.com/ and A LOT of trial-and-error

injuryByDay <- function() {
  daysInjury <- sqldf("select distinct DAY_OF_WEEK from jsonDf")
  counts <- c()
  for (i in 1:length(daysInjury[,1])) {
    sql <- paste("select count(CASE_NUMBER) as COUNT from jsonDf where DAY_OF_WEEK = '", daysInjury[i,], "'", sep = '')
    number <- sqldf(sql)[,1]
    counts <- c(counts, number)
  }
  daysInjury['COUNTS'] <- counts
  return(daysInjury)
}

daysInjury <- injuryByDay()
accInjurySQL[1,]
accSundaySQL[1,]

# Finding the number of accidents on Sunday the easy way
sum(jsonDf$DAY_OF_WEEK == 'SUNDAY')
# Finding the number of accidents per day
tapply(jsonDf$INJURY == 'YES', jsonDf$DAY_OF_WEEK, sum)