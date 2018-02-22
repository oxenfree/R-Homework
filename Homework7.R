zip_income <- read.csv("homework/zip_income.csv", stringsAsFactors = FALSE)
zip_income <- zip_income[-1, c(2,4)]
colnames(zip_income) <- c("zip", "median_income")
row.names(zip_income) <- 1:nrow(zip_income)
data("zipcode")

zip_income <- left_join(zip_income, zipcode, by=c("zip" = "zip"))
zip_income <- zip_income[which((zip_income$state != "PR") & (zip_income$state != "AK") & (zip_income$state != "HI")),]
zip_income$state <- state.name[match(zip_income$state, state.abb)]
zip_income$state <- tolower(zip_income$state)
dfStates <- readStates()
dfStates$state <- tolower(dfStates$stateName)
zip_income <- left_join(zip_income, dfStates, by=c("state" = "state"))
zip_income <- zip_income[, c(1, 2, 4:6, 11)]
colnames(zip_income) <- c("zip", "median_income", "state", "latitude", "logitude", "population")
simple_dt <- data.table(zip_income)
simple_dt$median_income <- as.numeric(simple_dt$median_income)
simple_dt <- simple_dt[, lapply(.SD, mean), by=list(state)]
simple_dt <- simple_dt[complete.cases(simple_dt), ]
simple_dt$state_abbr <- state.abb[match(simple_dt$state, tolower(state.name))]
us <- map_data("state")
attach(simple_dt)
map.incColor <- ggplot(simple_dt, aes(map_id = state)) +
  geom_map(map = us, aes(fill = median_income)) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("State Median Income")
map.incColor
map.popColor <- ggplot(simple_dt, aes(map_id = state)) +
  geom_map(map = us, aes(fill = population)) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("State Population")
map.popColor
map.zipIncome <- ggplot(simple_dt, aes()) +
  geom_polygon(data=us, aes(x=simple_dt$longitude, y=simple_dt$latitude, group=group), color='gray', fill=NA, alpha=.35)+
  geom_point(aes(color = median_income),size=.15,alpha=.25) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("State Population")
map.zipIncome

