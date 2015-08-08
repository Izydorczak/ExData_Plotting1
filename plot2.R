
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

#plot time seriew graph using type l for line and removing x label
par(bg = "white")
plot(data$datetime,data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ") 

#copy to png device and close
dev.copy(png, file = "plot2.png")
dev.off()
