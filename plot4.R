#Reading the data for 2007-02-01 and 2007-02-02
fileName <- file("household_power_consumption.txt") 
data <- read.table(fileName,skip=1,sep=";", header = TRUE)
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
twoDaysData <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

# convert the date and time column from charactor class to date and POSIXlt class
twoDaysData$Date <- as.Date(twoDaysData$Date, format="%d/%m/%Y")
twoDaysData$Time <- strptime(twoDaysData$Time, format="%H:%M:%S")
twoDaysData[1:1440,"Time"] <- format(twoDaysData[1:1440,"Time"],"2007-02-01 %H:%M:%S")
twoDaysData[1441:2880,"Time"] <- format(twoDaysData[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# open png device 
png("plot4.png", width=480, height=480)
# globel setting for mutiple plots (2x2) in a single device
par(mfrow=c(2,2))
#plot the figures by base plot function from left to right and top to bottom
plot(twoDaysData$Time, as.numeric(twoDaysData$Global_active_power), type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(twoDaysData$Time, as.numeric(twoDaysData$Voltage), type="l", xlab="twoDaysData$Time", ylab="Voltage")
plot(twoDaysData$Time, as.numeric(twoDaysData$Sub_metering_1), type="l", ylab="Energy Submetering", xlab="")
lines(twoDaysData$Time, as.numeric(twoDaysData$Sub_metering_2), type="l", col="red")
lines(twoDaysData$Time, as.numeric(twoDaysData$Sub_metering_3), type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
plot(twoDaysData$Time, as.numeric(twoDaysData$Global_reactive_power), type="l", xlab="twoDaysData$Time", ylab="Global_reactive_power")

dev.off()