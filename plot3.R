library(ggplot2)

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data[, "Date"] <- as.Date(data[, "Date"], "%d/%m/%Y")

data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

data$Global_active_power <- as.numeric(paste(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(paste(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(paste(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(paste(data$Sub_metering_3))

data[, "Day"] <- weekdays(data[, "Date"])
data$Day <- as.factor(data$Day)
data[, "combined"] <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

pl <- ggplot(data, aes(combined)) + geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1"), colour = "black") +geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2"), colour = "red") + geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3"), colour = "blue1") + scale_colour_manual("", breaks = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", values = c("black", "red", "blue1")))
pl <- pl + xlab("") + ylab("Energy sub metering") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) + theme(legend.position = c(.90, .95)) + scale_x_datetime(date_labels = "%a")

png(file = "plot3.png")
print(pl)
dev.off()
