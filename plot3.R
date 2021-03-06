library(dplyr)
library(data.table)

plot3 <- function()
{
    # downloading the zip file
    if(!file.exists("./household_power_consumption.zip"))
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./household_power_consumption.zip")
    
    # extracting the zip file    
    if(!file.exists("./household_power_consumption.txt"))
        unzip("./household_power_consumption.zip")
    
    if(file.exists("./household_power_consumption.txt"))
    {
        # reading the txt file in a data table
        data <- fread(file = "./household_power_consumption.txt",sep = ";", header = T, na.strings = "?")
        # subseting the data 
        fdata = subset(data, Date == "1/2/2007" | Date == "2/2/2007")
        # removing the large dataset from memory
        data = NULL
        # converting character type date column into date type
        fdata$Date = as.Date(fdata$Date, "%d/%m/%Y")
        
        fdata$DateTime = paste(fdata$Date, fdata$Time)
        fdata$DateTime = as.POSIXct(fdata$DateTime)
        
        # drawing plot 3
        plot(fdata$Sub_metering_1~fdata$DateTime, type="l", ylab="Energy sub metering", xlab="")
        lines(fdata$Sub_metering_2~fdata$DateTime,col='red')
        lines(fdata$Sub_metering_3~fdata$DateTime,col='blue')

        legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        # copying plot 3 on to a png file
        dev.copy(png,"plot3.png", width=480, height=480)
        
        # closing the device
        dev.off()
        
        print("Plot 3 created successfully: plot3.png")
        print("***  E N D   O F   P R O G R A M  ***")
    }
}