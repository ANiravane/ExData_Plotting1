data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data[, "Date"] <- as.Date(data[, "Date"], "%d/%m/%Y")

data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

data$Global_active_power <- as.numeric(paste(data$Global_active_power))

png(file = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()