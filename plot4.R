#use grep to find the start and end dates of the data I want to read
start <- grep("1/2/2007", readLines("household_power_consumption.txt"))
end <- grep("3/2/2007", readLines("household_power_consumption.txt"))

#extract the header
header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep = ";", stringsAsFactors = FALSE)

#read only the relevant data
data <- read.table("household_power_consumption.txt", skip = start - 1, nrow = (end - start), sep = ";", na.strings = "?", header = FALSE, colClasses = c("character", "character", "numeric", "numeric","numeric", "numeric", "numeric", "numeric","numeric"))

#reattach the header
colnames(data) <- unlist(header)

#make a datetime column by pasting date with time and formatting so that they are POSIXlt type
data$datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#setup for 4 plots on white background
par(bg = "white",mfrow = c(2,2), mar = c(4,4,1,1))

#1st plot
plot(data$datetime,data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = " ")

#2nd plot with adjusted tic labels 
plot(data$datetime,data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime",yaxt = "n") 
axis(2, at = c(234,236,238,240,242,244,246),labels = c("234"," ","238"," ","242"," ","246"))

#3rd plot with legend 
plot(data$datetime,data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " " )
lines(data$datetime,data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime,data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = 'n', lty = c(1,1,1), col = c("black","red","blue"), xjust = 0)

#4th plot
plot(data$datetime,data$Global_reactive_power, type = "l", ylab = "Global_reactive_power",xlab = "datetime")

#copy to png device and close
dev.copy(png, file = "plot4.png")
dev.off()
