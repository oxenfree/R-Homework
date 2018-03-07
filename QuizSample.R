#Self quiz core skill.
#20 Questions in 20 min!
  #1. Load the cars dataset.
  data(cars)
#2. What is this data set?
?cars
#3. Display the 1st column.
cars[1] 
cars[,1]
#4. What are the column names.
colnames(cars)
#5. How many rows are there?
length(cars$speed)
str(cars)
nrow(cars)
#6. Display the second row.
cars[2,]
#7. What row number/s has/have entry speed == 16?
which(car$speed==16)
#8. How many row number/s has/have entry speed == 16?
length(which(cars$speed==16))
sum(cars$speed == 16)
subset(cars,cars$speed==16)
#9. Create a new dataframe composed of all rows where where Speed > 15.
cars[cars$speed > 15,]
subset(cars,cars$speed>15)
data.frame(which(cars$speed >15))

clean_cars <- cars[cars$speed != NA,]

#10.Create a new dataframe with all examples where Speed <23 and dist>25.
cars[cars$speed < 23 & cars$dist > 25,]
#11. What is the average speed?
mean(cars$speed)
#12. What is the average speed of cars where speed >15.
mean(cars(cars$speed>15,)$speed)
mean(cars[which(cars$speed>15),]$speed)
#13. What is the standard deviation of column one. 
sd(cars$speed)
#14. What is the minimal value in column 1.
min(cars[,1])
#15. Plot a histogram of Column 1.
hist(cars$speed)
#16. Plot histogram Column 2.  
hist(cars[,2])
#17. Explain difference between "which(c(1,2,3)>2)" and "c(1,2,3)>2"?
#locations versus masking
#18. Sort c(5,2,3).
c(5,2,3)[order(c(5,2,3))]
#19. Get 5 random values from the first 100 numbers.
sample(1:100, 5)
#20. With one line of code do that 3 times.
replicate(3, sample(1:100,5))