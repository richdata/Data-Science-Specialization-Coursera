#retrieve data
theData = read.csv("./data/household_power_consumption.txt", sep = ";")

#Make separate variable for plot 2
febData2 = theData[theData$Date %in% c("2/2/2007", "1/2/2007"), ]

#concatenate time and date
febData2$DateTime = strptime(paste(febData2$Date, febData2$Time), "%d/%m/%Y %H:%M:%S")

#convert sub metering to numeric
febData2$Sub_metering_1=as.numeric(type.convert(as.character(febData2$Sub_metering_1), dec = "."))
febData2$Sub_metering_2=as.numeric(type.convert(as.character(febData2$Sub_metering_2), dec = "."))
febData2$Sub_metering_3=as.numeric(type.convert(as.character(febData2$Sub_metering_3), dec = "."))

with(febData2, plot(DateTime, Sub_metering_1, type = "n", xaxt = "n", ylab = "Energy sub metering" , xlab = ""))
with(febData2, points(DateTime, Sub_metering_1, type = "l", col = "black"))
with(febData2, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(febData2, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
r <- as.POSIXct(round(range(febData2$DateTime), "days"))

axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , col = c("black", "red", "blue"), lty = 1)

#dev.copy(png, file="plot3.png")
#dev.off()