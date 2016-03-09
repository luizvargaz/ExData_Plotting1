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
str(data)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plot 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hist(data$Global_active_power, ylab = 'Frecuency', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'red')
dev.copy(png, file = 'Plot 1.png', width=480, height=480)
dev.off()
