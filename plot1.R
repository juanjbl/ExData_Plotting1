
setClass("myDate")
setClass("myTime")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
setAs("character","myTime", function(from) strptime(from, format="%T") )


data <- read.csv2.sql("../household_power_consumption.txt",
                      sql="select * from file 
                      where Date in ('1/2/2007','2/2/2007') ",
                      colClasses=c("myDate","myTime",rep("numeric",7)))
hist(data$Global_active_power, main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")