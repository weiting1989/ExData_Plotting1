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
png(filename = "./plot2.png",width = 480,height = 480,units = "px")
#make graph
plot(dataInRange$Global_active_power~dataInRange$DateTime,type = "l"
     ,ylab= "Global Active Power(killowatts)",xlab="")
#close the device
dev.off()

