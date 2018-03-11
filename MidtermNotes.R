gpa <- c(3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 4.7)

age <- c(21, 22, 23, 24, 25, 26, 27)

wt <- c(151, 142, 133, 164, 165, 166, 167)

df <- data.frame(gpa, age, wt)
df[2,]
df1 <- df[,c(-2, -3)]
df$weightPerAge <- df$wt / df$age
vec <- c(1,2,3)
vec <- vec -4
mean(vec)
mean(c(-100, 5, 10, 149))
smallData <- c(1,2,3,4,5)
sample(smallData, size = 6, replace = TRUE)
mean(replicate(1000,mean(sample(smallData,size=5,replace=FALSE))))
testData <- c(1:10)
hist(sample(testData, size = 50, replace = T))

myFamilyNames <- c("Dad","Mom","Sis","Bro","Dog")

myFamilyAges <- c(43, 42, 12, 8, 5)

myFamilyGenders <- c("Male","Female","Female","Male","Female")

myFamilyWeights <- c(188,136,83,61,44)

myFamily <- data.frame(myFamilyNames, +
                         
                         myFamilyAges, myFamilyGenders, myFamilyWeights)

myFamily$myFamilyNames <-c(myFamilyNames, "Cat")

myFamilyNames <-c(myFamilyNames, "Mouse")
myFamily$myFamilyNames

myFirstF <- function(vec) {
  return(mean(vec))
}

ages <- myFirstF(myFamilyAges)
ages

Temp <- c (10, 5, 15, 20, 10, 15, 20, 20, 22, 5) #ave temperature (for a given day)

Wind <- c(0, 10, 10, 5, 10, 5, 10, 10, 15, 0) #ave wind speed (for a given day)

Heat <- c(50, 30, 10, 15, 20, 15, 20, 20, 5, 40) #cost to heat a home (for a given day)
df_t <- data.frame(Heat, Wind, Temp)
lm_t <- lm(Heat ~ ., data = df_t, )
summary(lm_t)

ny <- geocode("Syracuse, NY")
de <- geocode("Newark, DE")
Rating <- c( 0.8, 0,3)
simple_dt <- data.frame(c(ny, de), Rating)

map.color <- ggplot(simple_dt, aes(map_id = state)) +
  geom_map(map = us, aes(fill = Rating)) +
  expand_limits(x = us$long, y = us$lat) +
  coord_map() + ggtitle("City Ratings")
map.color
