myCars <- mtcars
# Attach myCars just to short-hand the variables
attach(myCars)
max(hp)
myCars[hp == max(hp), ]
max(mpg)
myCars[mpg == max(mpg), ]
# Using the negative sign (-) to sort by descending
# found on https://www.statmethods.net/management/sorting.html
mpgSorted <- myCars[order(-mpg), ]
mpgSorted
# Making a new dataframe of cars with
# higher than average (mean) efficiency
highMPGCars <- myCars[mpg >= mean(mpg), ]
# Ordering by mpg
highMPGSorted <- highMPGCars[order(-highMPGCars$mpg), ]
# Finding the highest hp in the sorted high efficiency dataframe
highMPGHighHP <- highMPGSorted[highMPGSorted$hp == max(highMPGSorted$hp), ]
highMPGHighHP

# Since we need to loop through the dataframe
# starting with the mean hp and mean mpg and
# increment through high hp cars and high mpg cars
# and do a boolean logic check to see if any cars match
# let's put it in a simple function.
findMpgToHpBalanced <- function() {
  
  for(i in seq(from=0, to=length(mpg), by=.5)) {
    highHPCars <- myCars[hp >= mean(hp) - i, ]
    highMPGCars <- myCars[mpg >= mean(mpg) - i, ]
    # The 'inner_join' function found in library 'dplyr'
    # found on StackOverflow, here: 
    # https://stackoverflow.com/questions/32917934/how-to-find-common-rows-between-two-dataframe-in-r/43334229#43334229
    mpgToHpBalanced <- inner_join(highHPCars, highMPGCars)
    if (length(mpgToHpBalanced[,1]) > 0) {
      return(myCars[hp == mpgToHpBalanced$hp & mpg == mpgToHpBalanced$mpg, ])
    }
  }
}
# This will be the car with a balance between efficiency and power.
mToHBalance <- findMpgToHpBalanced()
mToHBalance
detach(myCars)
