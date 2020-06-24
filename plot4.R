library(ggplot2)
require(gridExtra)

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
data[, "Voltage"] <- as.numeric(paste(data[, "Voltage"]))
data[, "Global_reactive_power"] <- as.numeric(paste(data[, "Global_reactive_power"]))

pl1 <- ggplot(data, aes(x = combined, y = Global_active_power)) + geom_line()
pl1 <- pl1 + labs(x = "", y = "Global Active Power") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(colour = "black", size = 1, fill = NA), axis.line = element_line(colour = "black")) + scale_x_datetime(date_labels = "%a")

pl2 <- ggplot(data, aes(x = combined, y = Voltage)) + geom_line()
pl2 <- pl2 +xlab("datetime") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(colour = "black", size = 1, fill = NA), axis.line = element_line(colour = "black")) + scale_x_datetime(date_labels = "%a")

pl3 <- ggplot(data, aes(combined)) + geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1"), colour = "black") +geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2"), colour = "red") + geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3"), colour = "blue1") + scale_colour_manual("", breaks = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", values = c("black", "red", "blue1")))
pl3 <- pl3 + xlab("") + ylab("Energy sub metering") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(colour = "black", size = 1, fill = NA), axis.line = element_line(colour = "black")) + scale_x_datetime(date_labels = "%a")

pl4 <- ggplot(data, aes(x = combined, y = Global_reactive_power)) + geom_line()
pl4 <- pl4 + xlab("datetime") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(colour = "black", size = 1, fill = NA), axis.line = element_line(colour = "black")) + scale_x_datetime(date_labels = "%a")

g <- arrangeGrob(pl1,pl2,pl3,pl4,nrow = 2, ncol = 2)
ggsave(file="plot4.png", g, height = 1.6, width = 1.6)
