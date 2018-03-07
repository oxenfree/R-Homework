#1. Load the attitude dataset.
data("attitude")
#2. What is this data set?
?attitude
## From a survey of the clerical employees of a large financial organization, 
##the data are aggregated from the questionnaires of the approximately 
##35 employees for each of 30 (randomly selected) departments. 
##The numbers give the percent proportion of favourable responses 
##to seven questions in each department.
#3. Display the 1st and 3rd column.
attitude[, c(1,3)]
#4. Summary of column 1.
summary(attitude[,1])
#5. How many rows are there?
length(attitude[,1])
# -- 30
#6. Display all rows that the average of that rows column 1 and column 2  > 60?
subset(attitude, mean(attitude[,1]) > 60 & mean(attitude[,2]) > 60)
## not as good below
variableT <- ((attitude$rating + attitude$complaints) / 2) > 60
#7. What row number/s has/have learning value < 50?
rownames(attitude[which(attitude$learning < 50),])
#8. How many row number/s has/have entry privileges ==53?
length(which(attitude$privileges == 53))
#9. Create a new dataframe with all examples where privileges > 70.
over_70 <- attitude[which(attitude$privileges > 70),]
#10.Create a new dataframe with all examples where privileges <70 and raise<70.
over_70_2 <- attitude[which(attitude$privileges > 70 & attitude$raises < 70),]

#11 Which department is the happiest?
attitude[which(attitude$complaints == min(attitude$complaints)),]
#12 Which department is most confused?
attitude[which(attitude$learning == min(attitude$learning)),]
#13 Which department would you join?

#14 Sample 1000 times with replacement from the mean row score to generate a histogram.
hist(sample(rowMeans(attitude), 1000, replace = TRUE))

#15 What variable is the most correlated with column 1.
corr <- lm(formula = attitude[,1] ~., data = attitude)

#16 Which department seems like they were drawn from the most different distribution?
diff <- lm(formula = attitude[,1] ~., data = attitude)

#17 Make a function that takes a number and returns the number plus five.
add_five <- function(x) {
  return(x + 5)
}

#18 Make a function that takes a vector and a number and returns the vector + 5.
add_five_vector <- function(vector_a, int_a) {
  return(vector_a * int_a)
}

#19 Plot a histogram of each column on one plot from the attitude dataset.


#20 Suppose a new department was created, what might we expect for ratings?
mean(attitude$rating)
# 64.633

# subset, which, rowMeans