#Unzip the file.
unzip("exdata-data-household_power_consumption.zip")

#Download Dataset
power_cons <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)

#Load dplyr package.
library(dplyr)

#Check dimensions and structure of dataset.
dim(power_cons)
str(power_cons)

#Change date class from Factor to Date.
power_cons$Date <- as.Date(power_cons$Date, "%d/%m/%Y")
str(power_cons) #check class

#Subset dates: 2007-02-01 and 2007-02-02.
power_cons_subset <- power_cons[power_cons$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

#Change date and time columns with paste(). Change class to POSIXlt.
power_cons_subset$DateTime <- strptime(paste(power_cons_subset$Date, power_cons_subset$Time), format="%Y-%m-%d %H:%M:%S")
str(power_cons_subset)

#Load lubridate package.
library(lubridate)

#Make column with weekday information.
power_cons_subset$Day <- wday(power_cons_subset$DateTime, label=TRUE)

#Make column classes numeric. 
power_cons_subset$Sub_metering_1 <- as.numeric(as.character(power_cons_subset$Sub_metering_1))
power_cons_subset$Sub_metering_2 <- as.numeric(as.character(power_cons_subset$Sub_metering_2))
power_cons_subset$Sub_metering_3 <- as.numeric(as.character(power_cons_subset$Sub_metering_3))

#Create line plot as png file 480px by 480px.
png(file="plot3.png",width=480, height=480)

with(power_cons_subset, {
     plot(DateTime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
     points(DateTime, Sub_metering_1, pch=".")
     lines(DateTime, Sub_metering_1, col="black")
     points(DateTime, Sub_metering_2, pch=".")
     lines(DateTime, Sub_metering_2, col="red")
     points(DateTime, Sub_metering_3, pch=".")
     lines(DateTime, Sub_metering_3, col="blue")
     legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.off() #close png device
