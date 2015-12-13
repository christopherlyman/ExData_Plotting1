# Load data
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# Subset by date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dataSub <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

# Convert date as POSIXct
dateTime <- paste(as.Date(dataSub$Date), dataSub$Time)
dataSub$DateTime <- as.POSIXct(dateTime)

# Generate Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataSub, {
      plot(Global_active_power~DateTime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      plot(Voltage~DateTime, type="l", 
           ylab="Voltage (volt)", xlab="datetime")
      plot(Sub_metering_1~DateTime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~DateTime,col='Red')
      lines(Sub_metering_3~DateTime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power~DateTime, type="l", 
           ylab="Global Rective Power (kilowatts)",xlab="datetime")
})

# Copy Plot 4 to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()