# Coursera - Exploratory Data Analysis, Week 1, Course Project 1

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 1")
HPCdata <- read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec=".")


# Install the lubridate package to simplify working with dates
install.packages("lubridate")
library(lubridate)

# Extract the subset of data of interest - Feb 1 and 2, 2007
Feb2days <- HPCdata[HPCdata$Date %in% c("1/2/2007","2/2/2007") ,]

# Convert the Date column from character to readable date
Feb2days$Date <- dmy(Feb2days$Date)

# Add a column that merges Date and Time for each row
Feb2days$Datetime <- as.POSIXct(paste(Feb2days$Date, Feb2days$Time), format="%Y-%m-%d %H:%M:%S")

# Convert the number data of interest from character to numeric
Feb2days$Global_active_power <- as.numeric(Feb2days$Global_active_power)
Feb2days$Global_reactive_power <- as.numeric(Feb2days$Global_reactive_power)
Feb2days$Voltage <- as.numeric(Feb2days$Voltage)
Feb2days$Global_intensity <- as.numeric(Feb2days$Global_intensity)
Feb2days$Sub_metering_1 <- as.numeric(Feb2days$Sub_metering_1)
Feb2days$Sub_metering_2 <- as.numeric(Feb2days$Sub_metering_2)
Feb2days$Sub_metering_3 <- as.numeric(Feb2days$Sub_metering_3)

# Plot a line graph of the Submetering (1, 2, and 3) vs Datetime using png device

png(file = "plot3.png")
with(Feb2days, plot(Datetime, Sub_metering_1, type="n", xlab=paste(""), ylab=paste("Energy sub metering")))
lines(Feb2days$Datetime, Feb2days$Sub_metering_1, col = "black")
lines(Feb2days$Datetime, Feb2days$Sub_metering_2, col = "red")
lines(Feb2days$Datetime, Feb2days$Sub_metering_3, col = "blue")
legend("topright", lty = 1, pch = NA_integer_, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()

