library(ggplot2)

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data[, "Date"] <- as.Date(data[, "Date"], "%d/%m/%Y")

data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

data$Global_active_power <- as.numeric(paste(data$Global_active_power))

data[, "Day"] <- weekdays(data[, "Date"])
data$Day <- as.factor(data$Day)
data[, "combined"] <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

pl <- ggplot(data, aes(x = combined, y = Global_active_power)) + geom_line()
pl <- pl + labs(x = "", y = "Global Active Power (kilowatts)") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) + scale_x_datetime(date_labels = "%a")

png(file = "plot2.png")
print(pl)
dev.off()
