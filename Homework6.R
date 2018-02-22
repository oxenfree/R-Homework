airQualityHW6 <- airquality

## There are only NAs in two columns
## Setting NAs to the median of the column
## Found here: https://stackoverflow.com/a/8166616/7745506
airQualityHW6$Ozone[is.na(airQualityHW6$Ozone)] <- median(airQualityHW6$Ozone, na.rm = TRUE)
airQualityHW6$Solar.R[is.na(airQualityHW6$Solar.R)] <- median(airQualityHW6$Solar.R, na.rm = TRUE)

# Convert month from integer to factor
airQualityHW6$Month <- factor(airQualityHW6$Month)

# Attaching
attach(airQualityHW6)

# Some quick histograms of the variables with qplot from ggplot
getHist <- function(vectorX, bin) {
  qplot(vectorX,
        geom="histogram",
        binwidth = bin,
        fill=I("blue"),
        col=I("red"))
}
getHist(Ozone, 5)
getHist(Solar.R, 5)
getHist(Wind, 1)
getHist(Temp, 1)

# Boxplot for Ozone by month. Some help found here:
# http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html
ggplot(airQualityHW6, aes(x = Month, y = Ozone)) + geom_boxplot()
ggplot(airQualityHW6, aes(x = Month, y = Wind)) + geom_boxplot()

# Cool treatment of Month as a face_grid
# found here: https://rpubs.com/stuartcoggins/84231
ggplot(airQualityHW6, aes(x = Day, y = Ozone)) + geom_line(color = "red", size = 1, alpha = 0.5) + facet_grid(. ~ Month)
ggplot(airQualityHW6, aes(x = Day, y = Temp)) + geom_line(color = "blue", size = 1, alpha = 0.5) + facet_grid(. ~ Month)
ggplot(airQualityHW6, aes(x = Day, y = Solar.R)) + geom_line(color = "green", size = 1, alpha = 0.5) + facet_grid(. ~ Month)

# Plotting multiple Y values found here:
# https://www.sixhat.net/how-to-plot-multpile-data-series-with-ggplot.html
# Line charts for all variables
ggplot(airQualityHW6, aes(x = Day, y = value, color = variable)) +
  geom_line(aes(y = Ozone, col = "Ozone")) +
  geom_line(aes(y = Solar.R, col = "Solar.R")) +
  geom_line(aes(y = Wind, col = "Wind")) +
  geom_line(aes(y = Temp, col = "Temp")) +
  facet_grid(. ~ Month)

# Point plot
ggplot(airQualityHW6, aes(x = Day, y = value, color = variable)) +
  geom_point(aes(y = Ozone, col = "Ozone")) +
  geom_point(aes(y = Solar.R, col = "Solar.R")) +
  geom_point(aes(y = Wind, col = "Wind")) +
  geom_point(aes(y = Temp, col = "Temp")) +
  facet_grid(. ~ Month)

airq.s <- melt(airQualityHW6)
airq.s <- ddply(airq.s, .(variable), transform, rescale = scale(value))

# Very cool heatmap functions found here:
# https://learnr.wordpress.com/2010/01/26/ggplot2-quick-heatmap-plotting/
ggplot(airq.s, aes(Day, variable)) +
  geom_tile(aes(fill = rescale), colour = "white") +
  scale_fill_gradient(low = "white", high = "red")