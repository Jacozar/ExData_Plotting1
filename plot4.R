# Script plot4.R
# Author: JOSE ANTONIO COZAR RIOS
# Make an mutiple graphs in the period between 2007-02-01 and 2007-02-02 and 
# save it in a PNG file plot4.png

# It is assumed that the file household_power_consumption.txt is in the work
# directory

# Save the name of columns in ColNames
ColNames <- names(read.table('household_power_consumption.txt', header=TRUE,
                             nrow=1, sep=';'))
# Save in Rows a vector with the rows numbers that are in the period with the
# help of R function grep and one pattern
Rows <- grep("^[1,2]/2/2007", readLines('household_power_consumption.txt'))

# Save the start row. Here start the read
RowSkip <- Rows[1]-1

# Save the total rows. It is the numbers of rows to read
NRows <- length(Rows)

# Read the right data in the dataframe MyData with the help of RowSkip and NRows
MyData <- read.table('household_power_consumption.txt', na.strings = '?', 
                     sep=';',header = FALSE, col.names = ColNames, 
                     skip=RowSkip , nrows=NRows)

# Convert a Date format the first column
MyData$Date <-as.Date(MyData$Date, '%d/%m/%Y')

#Convert a Time format the second column
MyData$Time<- strptime(paste(MyData$Date, MyData$Time),
                       format='%Y-%m-%d %H:%M:%S')

# Create the file plot3.png
png(file='plot4.png')

# Make the space to four graphs
par(mfrow=c(2,2))

# Generating the graphic of Global_active_power
plot(MyData$Global_active_power, type='l', xlab='',
     ylab='Global Active Power', xaxt='n')
axis(1, las=1, at=c(1,1440,2880), lab=c('Thu','Fri', 'Sat'))

# Generating the graphic of Voltage
plot(MyData$Voltage, type='l', xlab='datetime',
     ylab='Voltage', xaxt='n')
axis(1, las=1, at=c(1,1440,2880), lab=c('Thu','Fri', 'Sat'))

# Generating the graphic of Sub_metering_?
plot(MyData$Sub_metering_1, type='l', xlab='',
     ylab='Energy sub metering', xaxt='n')
lines(MyData$Sub_metering_2, type='l', col='red')
lines(MyData$Sub_metering_3, type='l', col='blue')
axis(1, las=1, at=c(1,1440,2880), lab=c('Thu','Fri', 'Sat'))
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       lty=c(1,1,1), bty='n', col=c('black','red','blue'))

# Generating the graphic of Global_reactive_power
plot(MyData$Global_reactive_power, type='l', xlab='datetime',
     ylab='Global_reactive_power', xaxt='n')
axis(1, las=1, at=c(1,1440,2880), lab=c('Thu','Fri', 'Sat'))

# Close the file device
dev.off()