## downloading and reading data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
  download.file(fileUrl, destfile = "EPC_data.zip")
  unzip("EPC_data.zip", exdir = getwd())
}
filename <- "household_power_consumption.txt"
EPC_data <- read.table(filename, skip = 66630, nrows = 3000, col.names = colnames(read.table(filename, nrow = 1, header = TRUE, sep = ";")), na.strings = "?", sep =";")
EPC_data$datetime <- paste(EPC_data$Date, EPC_data$Time)
EPC_data$datetime <- strptime(EPC_data$datetime, "%d/%m/%Y %H:%M:%S")
EPC_data <- subset(EPC_data, EPC_data$Date == c("1/2/2007", "2/2/2007"))

## creating plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(EPC_data$datetime, EPC_data$Sub_metering_1, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(EPC_data$datetime, EPC_data$Sub_metering_2, col = "red")
lines(EPC_data$datetime, EPC_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()
