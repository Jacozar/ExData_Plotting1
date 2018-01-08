# Script plot1.R
# Author: JOSE ANTONIO COZAR RIOS
# Make an histogram of the Global Active Power in the period between 2007-02-01
# and 2007-02-02 and save it in a PNG file plot1.png

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

# Create the file plot1.png
png(file='plot1.png')
# Generate the histogram and send to a file device
hist(MyData$Global_active_power, col = 'red',
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
# Close the file device
dev.off()