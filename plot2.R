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

# open png device and plot the figure
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(twoDaysData$Time,as.numeric(as.character(twoDaysData$Global_active_power)),
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l") 
dev.off()
