#retreive data
theData = read.csv("./data/household_power_consumption.txt", sep = ";")

#get data for just 2 days
febData2 = theData[theData$Date %in% c("2/2/2007", "1/2/2007"), ]


#make plot area 2 x 2
windows(8,8)
par(mfcol = c(2,2))


###########################
# 1st plot
##########################

#concatenate time and date
febData2$DateTime = strptime(paste(febData2$Date, febData2$Time), "%d/%m/%Y %H:%M:%S")

#convert the factor into proper number
febData2$Global_active_power=as.numeric(type.convert(as.character(febData2$Global_active_power), dec = "."))

#plot with empty x-axis
with(febData2, plot(DateTime, Global_active_power, type = "l", xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))

#get a date range for x-axis
r <- as.POSIXct(round(range(febData2$DateTime), "days"))

#draw x-axis by days with specified format
axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")

###########################
# 2nd plot
##########################


#convert sub metering to numeric
febData2$Sub_metering_1=as.numeric(type.convert(as.character(febData2$Sub_metering_1), dec = "."))
febData2$Sub_metering_2=as.numeric(type.convert(as.character(febData2$Sub_metering_2), dec = "."))
febData2$Sub_metering_3=as.numeric(type.convert(as.character(febData2$Sub_metering_3), dec = "."))

with(febData2, plot(DateTime, Sub_metering_1, type = "n", xaxt = "n", ylab = "Energy sub metering" , xlab = ""))
with(febData2, points(DateTime, Sub_metering_1, type = "l", col = "black"))
with(febData2, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(febData2, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
#draw legend
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , col = c("black", "red", "blue"), lty = 1)


r <- as.POSIXct(round(range(febData2$DateTime), "days"))

axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")


###########################
# 3rd plot
##########################

#convert the factor into proper number
febData2$Voltage=as.numeric(type.convert(as.character(febData2$Voltage), dec = "."))

#plot with empty x-axis
with(febData2, plot(DateTime, Voltage, type = "l", ylab = "Voltage"))

#get a date range for x-axis
r <- as.POSIXct(round(range(febData2$DateTime), "days"))

#draw x-axis by days with specified format
axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")



###########################
# 4th plot
##########################

#convert the factor into proper number
febData2$Global_reactive_power=as.numeric(type.convert(as.character(febData2$Global_reactive_power), dec = "."))

#plot with empty x-axis
with(febData2, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power"))

#get a date range for x-axis
r <- as.POSIXct(round(range(febData2$DateTime), "days"))

#draw x-axis by days with specified format
axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")

#dev.copy(png, file="plot4.png")
#dev.off()