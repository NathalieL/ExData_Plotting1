#Unzip the file.
unzip("exdata-data-household_power_consumption.zip")

#Download Dataset
power_cons <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)

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

#Make column class numeric. 
power_cons_subset$Global_active_power <- as.numeric(as.character(power_cons_subset$Global_active_power))

#Create histogram as png file 480px by 480px.
png(file="plot1.png",width=480, height=480)
hist(power_cons_subset$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off() #close png device
