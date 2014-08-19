#retreive data
theData = read.csv("./data/household_power_consumption.txt", sep = ";")

#get data for just 2 days
febData = theData[theData$Date %in% c("2/2/2007", "1/2/2007"), ]

#format the date
febData$Date=as.Date(strptime(febData$Date, format = "%d/%m/%Y"))

#give proper row names (not useful for this exercise)
rownames(febData) = 1:dim(febData)[1]

#draw historgram
hist(as.numeric(febData$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts", col = "red")

#copy to file
#dev.copy(png, file="plot1.png")
#dev.off()
