library(dplyr)
library(data.table)

plot1 <- function()
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
        # drawing histogram
        hist(fdata$Global_active_power, main="Global Active Power", xlab="Global Acitve Power (kilowatts)", col="red")
        
        # copying histogram on to a png file
        dev.copy(png,"plot1.png", width=480, height=480)
        # closing the device
        dev.off()
        
        print("Plot 1 created successfully: plot1.png")
        print("***  E N D   O F   P R O G R A M  ***")
    }
}