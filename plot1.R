#Read the data for 2007-02-01 and 2007-02-02
fileName <- file("household_power_consumption.txt") 
data <- read.table(fileName,skip=1,sep=";", header = TRUE)
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
twoDaysData <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

# open png device and plot the figure
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(twoDaysData$Global_active_power), 
     xlab = "Global Active Power (kilowatts)", 
     ylab="Frequency",
     col = "red", 
     main = "Global Active Power")
dev.off()
