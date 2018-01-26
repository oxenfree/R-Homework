install.packages("jsonlite")
install.packages("curl")
install.packages("plyr")
install.packages("sqldf")

library("jsonlite")
library("plyr")
library('sqldf')

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
sqldf("select count(CASE_NUMBER) from jsonDf where jsonDf.DAY_OF_WEEK = 'SUNDAY'")
sqldf("select count(CASE_NUMBER) from jsonDf where INJURY = 'YES'")
sqldf("select count(DAY_")