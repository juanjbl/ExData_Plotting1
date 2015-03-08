
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
png("plot2.png")
#Create new column of date frame containing the full date and time
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %T")
#Plot the graphic
plot(data$DateTime,data$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)",xlab="")
#Close the device
dev.off()


