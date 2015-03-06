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


## Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1))

# Change pointsize to 10 (default is 16)
par(ps = 9)

with(df, {
      # Plot Global Active Power.
      plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", col = "black")
      
      # Plot Voltage.
      plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage", col = "black")
      
      # Plot Energy Submetering
      plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
      lines(DateTime, Sub_metering_2, col = "red")
      lines(DateTime, Sub_metering_3, col = "blue")
      # Add legend
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
      # Plot Global Reactive Power
      plot(DateTime, Global_reactive_power, type = "l", col = "black")
})


## Save to file
## Width is set wider for more space to show the legend
dev.copy(png, file="plot4.png", height=480, width=600)
dev.off()
