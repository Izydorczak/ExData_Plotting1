
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

#plot sub_metering 1
par(bg = "white" )
plot(data$datetime,data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " " )

#add sub_metering 2 and 3 to same plot
lines(data$datetime,data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime,data$Sub_metering_3, type = "l", col = "blue")

#add legend to plot
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"), xjust = 0)

#copy to png device and close
dev.copy(png, file = "plot3.png")
dev.off()
