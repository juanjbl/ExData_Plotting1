require(tidyr)

setClass("myDate")
setClass("myTime")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
setAs("character","myTime", function(from) strptime(from, format="%T") )

#The datafile is  located in the parent directory of the working path
data <- read.csv2.sql("../household_power_consumption.txt",
                      sql="select * from file 
                      where Date in ('1/2/2007','2/2/2007') ",
                      colClasses=c("myDate","myTime",rep("numeric",7)))
#Create the png file
png("plot4.png")
#Partition plot area in for areas.
par( mfrow = c(2,2) )
#Gather the sub_metering columns in order to plot in the same graphic
data2 <- gather(data, Sub_metering, Value,-(Date:Global_intensity))
#Create new column of date frame containing the full date and time
data2$DateTime <- as.POSIXct(paste(data2$Date, data2$Time), format="%d/%m/%Y %T")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %T")

#Plot the graphic the first cuadrant
plot(data$DateTime,data$Global_active_power,type="l",
     ylab="Global Active Power",xlab="")
#Plot the graphic the second cuadrant
plot(data$DateTime,data$Voltage,type="l",
     ylab="Voltage",xlab="datetime")
#Plot the graphic the third cuadrant
plot(data2$DateTime,data2$Value,type="l",
     ylab="Energy sub metering",xlab="")
#Change the lines color in function of sub metering number
with(subset(data2, Sub_metering == "Sub_metering_1"), 
     lines(DateTime, Value, col = "black"))
with(subset(data2, Sub_metering == "Sub_metering_2"), 
     lines(DateTime, Value, col = "red"))
with(subset(data2, Sub_metering == "Sub_metering_3"), 
     lines(DateTime, Value, col = "blue"))
#Put legend into graphic
legend("topright", col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lty = 1)
#Plot the las cuadrant
plot(data$DateTime,data$Global_reactive_power,type="l",
     ylab="Global_reactive_power",xlab="datetime")
#Close the device
dev.off()