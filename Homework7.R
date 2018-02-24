## The dataset file wasn't uploaded to the course by the time I started this
## so I made my own from Census Data. The zip_income dataset was from 
## table S1903 from the Census Factfinder at: 
## https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml
zip_income <- read.csv("homework/zip_income.csv", stringsAsFactors = FALSE)

## Clean up and renaming columns, standards stuff
zip_income <- zip_income[-1, c(2,4)]
colnames(zip_income) <- c("zip", "median_income")
row.names(zip_income) <- 1:nrow(zip_income)

## Bringing in zipcode data
data("zipcode")

## Left joining zip_income and zipcode to get the regions, latitude, longitude, etc.
zip_income <- left_join(zip_income, zipcode, by=c("zip" = "zip"))

## Removing Puerto Rico, Alaska, and Hawaii
zip_income <- zip_income[which((zip_income$state != "PR") & (zip_income$state != "AK") & (zip_income$state != "HI")),]

## Get state names from abbreviaions and making those lower case
zip_income$state <- state.name[match(zip_income$state, state.abb)]
zip_income$state <- tolower(zip_income$state)

## readStates is a function from previous homework
## that creates a data frame from population information
dfStates <- readStates()
dfStates$state <- tolower(dfStates$stateName)
zip_income <- left_join(zip_income, dfStates, by=c("state" = "state"))

## We're getting rid of everything except the July 2011 population data
zip_income <- zip_income[, c(1, 2, 4:6, 11)]

## And renaming some columns
colnames(zip_income) <- c("zip", "median_income", "state", "latitude", "longitude", "population")
simple_dt <- data.table(zip_income)
## This just silences some type coercion errors
options(datatable.optimize = 1)

## The next few steps setup simple_dt to have numeric income data
## zip codes, and state information
## which are used in the maps that follow
simple_dt$median_income <- as.numeric(simple_dt$median_income)
simple_dt <- simple_dt[, lapply(.SD, mean), by=list(state, zip)]
simple_dt <- simple_dt[complete.cases(simple_dt), ]
simple_dt$state_abbr <- state.abb[match(simple_dt$state, tolower(state.name))]

## And then we build out maps the same way we've done in previous 
## homework assignments
us <- map_data("state")
attach(simple_dt)

## Map with fill color by Median Income
map.incColor <- ggplot(simple_dt, aes(map_id = state)) +
  geom_map(map = us, aes(fill = median_income)) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("State Median Income")
map.incColor

## Map with fil color by Population
map.popColor <- ggplot(simple_dt, aes(map_id = state)) +
  geom_map(map = us, aes(fill = population)) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("State Population")
map.popColor

## A map with zip code dots colored by median income
income <- simple_dt$median_income
map.zipIncome <- ggplot(simple_dt, aes(map_id = state)) +
  geom_map(map = us) +
  geom_point(aes(longitude, latitude, colour = income), size = .01) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("Income by Zip")
map.zipIncome

## The following "zoom" map around New York
## was essentially exactly like the map made in the 
## asynch material, but with coloring based on income
ny <- geocode("New York, ny")
nyZoom <- 3
centerx <- ny$lon
centery <- ny$lat

## Setting up the map limits
xlimit <- c(centerx - nyZoom, centerx + nyZoom)
ylimit <- c(centery - nyZoom, centery + nyZoom)

## Making a new smaller data set with only information
## of income from around the New York area
ny_zip_inc <- zip_income
ny_zip_inc <- ny_zip_inc[ny_zip_inc$longitude > xlimit[1], ]
ny_zip_inc <- ny_zip_inc[ny_zip_inc$longitude < xlimit[2], ]
ny_zip_inc <- ny_zip_inc[ny_zip_inc$latitude > ylimit[1], ]
ny_zip_inc <- ny_zip_inc[ny_zip_inc$latitude < ylimit[2], ]
longitude <- ny_zip_inc$longitude
latitude <- ny_zip_inc$latitude
income <- as.numeric(ny_zip_inc$median_income)

## And then the map by New York state income levels
map.zipIncomeNY <- ggplot(ny_zip_inc, aes(map_id = state)) +
  geom_map(map = us) +
  geom_point(aes(longitude, latitude, colour = income), size = .05) +
  scale_color_gradient(low="beige", high="blue") +
  expand_limits(x = xlimit, y = ylimit) +
  coord_map() + ggtitle("Income by Zip, NY")
map.zipIncomeNY
detach(simple_dt)
