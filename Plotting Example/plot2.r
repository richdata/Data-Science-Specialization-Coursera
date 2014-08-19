#retrieve data
theData = read.csv("./data/household_power_consumption.txt", sep = ";")

#Make separate variable for plot 2
febData2 = theData[theData$Date %in% c("2/2/2007", "1/2/2007"), ]

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

#copy to file
#dev.copy(png, file="plot2.png")
#dev.off()