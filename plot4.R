setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 1")
HPCdata <- read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec=".")
install.packages("lubridate")
library(lubridate)
Feb2days <- HPCdata[HPCdata$Date %in% c("1/2/2007","2/2/2007") ,]
#Feb2days$Date <- as.Date(Feb2days$Date, format="%d/%m/%Y")
#Feb2days$Time <- strptime(Feb2days$Time, "%H:%M:%S") #adds today's date, find a workaround!
Feb2days$Date <- dmy(Feb2days$Date)
#Feb2days$Date <- hms(Feb2days$Time)
Feb2days$Datetime <- as.POSIXct(paste(Feb2days$Date, Feb2days$Time), format="%Y-%m-%d %H:%M:%S")
Feb2days$Global_active_power <- as.numeric(Feb2days$Global_active_power)
Feb2days$Global_reactive_power <- as.numeric(Feb2days$Global_reactive_power)
Feb2days$Voltage <- as.numeric(Feb2days$Voltage)
#Feb2days$Global_intensity <- as.numeric(Feb2days$Global_intensity)
Feb2days$Sub_metering_1 <- as.numeric(Feb2days$Sub_metering_1)
Feb2days$Sub_metering_2 <- as.numeric(Feb2days$Sub_metering_2)
Feb2days$Sub_metering_3 <- as.numeric(Feb2days$Sub_metering_3)

png(file = "plot4.png")

par(mfrow = c(2,2))

#top left panel: Global Active Power
plot(Feb2days$Datetime, Feb2days$Global_active_power, pch = NA_integer_, xlab = paste(""), ylab = paste("Global Active Power (kilowatts"))
lines(Feb2days$Datetime, Feb2days$Global_active_power)

#top right panel: Voltage
plot(Feb2days$Datetime, Feb2days$Voltage, pch = NA_integer_, xlab = paste("datetime"), ylab = paste("Voltage"))
lines(Feb2days$Datetime, Feb2days$Voltage)

#bottom left panel: Energy Sub metering
with(Feb2days, plot(Datetime, Sub_metering_1, type="n", xlab=paste(""), ylab=paste("Energy sub metering")))
lines(Feb2days$Datetime, Feb2days$Sub_metering_1, col = "black")
lines(Feb2days$Datetime, Feb2days$Sub_metering_2, col = "red")
lines(Feb2days$Datetime, Feb2days$Sub_metering_3, col = "blue")
legend("topright", lty = 1, pch = NA_integer_, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#bottom right panel: Global reactive power
plot(Feb2days$Datetime, Feb2days$Global_reactive_power, pch = NA_integer_, xlab = paste("datetime"), ylab = paste("Global_reactive_power"))
lines(Feb2days$Datetime, Feb2days$Global_reactive_power)

dev.off()

