
#use grep to find the start and end dates of the data I want to read
start <- grep("1/2/2007", readLines("household_power_consumption.txt"))
end <- grep("3/2/2007", readLines("household_power_consumption.txt"))

#extract the header
header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep = ";", stringsAsFactors = FALSE)

#read only the relevant data
data <- read.table("household_power_consumption.txt", skip = start - 1, nrow = (end - start), sep = ";", na.strings = "?", header = FALSE, colClasses = c("character", "character", "numeric", "numeric","numeric", "numeric", "numeric", "numeric","numeric"))

#reattach the header
colnames(data) <- unlist(header)

#plot histogram
par(bg = "white")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)") 

#copy to png device and close
dev.copy(png, file = "plot1.png")
dev.off()
