setwd("C:/Users/Koleary/Documents/Github/Exploratory-Data-Analysis") ##set working directory

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ##assign file url to handle
download.file(fileUrl, destfile = "./exdata-data-household_power_consumption.zip") ##download file and designate destination

unzip("./exdata-data-household_power_consumption.zip") ##unzip file in working directory

mydata = read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings = "?") ## read txt file with header, separate data by semicolon, nas are identified as "?" symbolsemicolon, nas are "?" 

subdata <- subset(mydata, mydata$Date == "1/2/2007"| mydata$Date == "2/2/2007") ##subset data by first date OR second date

library(graphics) ##plotting functions for the "base" graphing systems, including plot, hist, boxplot and many others.
library(grDevices) ##contains all the code implementing the various graphics devices, including X11, PDF, PostScript, PNG, etc.


################################################Plot 1######################################

png(file="plot1.png", bg="transparent") ##open png file

hist(subdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red") ##populate png file with histogram, rename title and labels, color red

dev.off() ##close png

################################################Plot 2######################################

png(file="plot2.png", bg="transparent") ##open png file

dates <- subdata$Date ##assign date column to dates
times <- subdata$Time ##assign time column to times
x <- paste(dates, times) ## assign x to combined dates and times vectors
y <- strptime(x, "%d/%m/%Y %H:%M:%S") ##format x and assign to y
subdata$Time = y ##change time column to y
with(subdata, plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type="l")) ##plot Time on x-axis (not named), Global Active Power on y-axis (named), and in line style

dev.off() ##close png

################################################Plot 3######################################

png(file="plot3.png", bg="transparent") ##open png file

dates <- subdata$Date ##assign date column to dates
times <- subdata$Time ##assign time column to times
x <- paste(dates, times) ## assign x to combined dates and times vectors
y <- strptime(x, "%d/%m/%Y %H:%M:%S") ##format x and assign to y
subdata$Time = y ##change time column to y
with(subdata, plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type="l")) ##plot Time on x-axis (not named), Energy sub metering 1 on y-axis (named), and in line style
with(subdata, points(Time, Sub_metering_2, ylab = "Energy sub metering", xlab = "", type="l", col = "red")) ##plot Time on x-axis (not named), Energy sub metering 2 on y-axis (named), and in line style, color red
with(subdata, points(Time, Sub_metering_3, ylab = "Energy sub metering", xlab = "", type="l", col = "blue")) ##plot Time on x-axis (not named), Energy sub metering 3 on y-axis (named), and in line style, color blue
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) ##create legend in top right, line style, color and text

dev.off() ##close png

################################################Plot 4######################################

png(file="plot4.png", bg="transparent") ##open png file

dates <- subdata$Date ##assign date column to dates
times <- subdata$Time ##assign time column to times
x <- paste(dates, times) ## assign x to combined dates and times vectors
y <- strptime(x, "%d/%m/%Y %H:%M:%S") ##format x and assign to y
subdata$Time = y ##change time column to y

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) ## arrange multiple plots in a 2 x 2 square, set the margin and outer margin

with(subdata, {
  plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type="l")
  plot(Time, Voltage, ylab = "Voltage", xlab = "datetime", type="l")
  plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type="l")
  points(Time, Sub_metering_2, ylab = "Energy sub metering", xlab = "", type="l", col = "red")
  points(Time, Sub_metering_3, ylab = "Energy sub metering", xlab = "", type="l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Time, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type="l")
})

dev.off() ##close png