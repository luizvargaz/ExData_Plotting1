#~~~~~~~~~~~~~~~~~~~~~~~~~~ Loading the data ~~~~~~~~~~~~~~~~~~~~~~~~
setwd('C:/Users/LVARGAS/Documents/MEGA/Coursera/Análisis exploratorio de los datos/Week 1/assigment')

# Calculate a rough estimate of how much memory the dataset will require in memory before reading into R
library(pryr)
object_size(read.table('household_power_consumption.txt'))
mem_used()

# Read the data from just those dates rather 
subData <- read.table('household_power_consumption.txt', sep = ';', nrows = 10, header = TRUE, na.strings = '?')
classes <- sapply(subData, class)
data <- read.table(text = grep("^[1,2]/2/2007", readLines('household_power_consumption.txt'), value = TRUE), col.names = names(classes) , sep = ";", header = TRUE, na.strings = '?', colClasses = classes)
data$dateTime <- as.POSIXct(paste(as.Date(data$Date,"%d/%m/%Y"), data$Time))
str(data)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plot 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(mfrow = c(2,2))

plot(data$Global_active_power ~ data$dateTime, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')

plot(data$Voltage ~ data$dateTime, type = 'l', ylab = 'Voltage', xlab = 'datetime')

with(data,{
        plot(data$Sub_metering_1 ~ data$dateTime, type = 'l', ylab = 'Energy sub metering', xlab = '')
        points(data$Sub_metering_2 ~ data$dateTime, type = 'l', col = 'red')
        points(data$Sub_metering_3 ~ data$dateTime, type = 'l', col = 'blue')
})
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),cex = 0.4, lwd = 2, bty="n", lty = 1)

plot(data$Global_reactive_power ~ data$dateTime, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime')

dev.copy(png, file = 'Plot 4.png', width=480, height=480)
dev.off()
