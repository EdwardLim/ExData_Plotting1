## Read from the file.
## - skip the 66636 rows before 1 Feb 2007.
## - only read 2880 rows for 2 days 1 & 2 Feb 2007 (1440 rows per day corresponding to 1440 minutes in a 24 hour day)

## Read just 1 row and get the column names.
## This is required because skipping rows during the read does NOT preserve the column names even though header is set to TRUE.
colNames = colnames(read.csv("household_power_consumption.txt", nrows =1, sep = ";", header = TRUE))

df <- read.csv("household_power_consumption.txt", skip = 66636, nrows = 2880, header = TRUE, col.names = colNames, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

## Convert the date time strings to Date/Time format.
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

## Can use the following code too
# DateTimeString <- paste(as.Date(df$Date, "%d/%m/%Y"), df$Time)
# df$DateTime <- as.POSIXct(DateTimeString)

## Plot 1
hist(df$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
