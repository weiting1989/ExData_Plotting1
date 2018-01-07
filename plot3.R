#dowload the data and unzip the file
dataurl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("dataset.zip")) download.file(dataurl,"dataset.zip")
if(!file.exists("household_power_consumption.txt")) unzip("dataset.zip")

#load the data and subset the data from 2007-02-01 to 2007-02-02 that will be used
dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?",
                      colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# retrive the data that the project need
dataInRange<-subset(dataset,as.Date(as.character(Date),format="%d/%m/%Y")==as.Date("2007-02-01")
                    |as.Date(as.character(Date),format="%d/%m/%Y")==as.Date("2007-02-02"))

#assgin DateTime as combine Date and Time
DateTime <- paste(dataInRange$Date,dataInRange$Time)
DateTime <- strptime(DateTime,format="%d/%m/%Y %H:%M:%S")

#names the datetiem and combine it with the original data
DateTime <-setNames(DateTime,"DateTime")
dataInRange<-cbind(DateTime,dataInRange)

#remove the date and time column
dataInRange$Date <- NULL
dataInRange$Time <- NULL

#open png graphic device 
png(filename = "./plot3.png",width = 480,height = 480,units = "px")
#make graph
with(dataInRange,{
        plot(Sub_metering_1~DateTime,type="l",ylab="Energy sub metering",xlab="")
        lines(Sub_metering_2~DateTime, col="red")
        lines(Sub_metering_3~DateTime, col="blue")
})
#add legend
legend("topright",col = c("black","red","blue"),
       lwd=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#close the device
dev.off()

