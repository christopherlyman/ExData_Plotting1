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

# Generate Plot 1
hist(dataSub$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", col="Red")

# Copy Plot 1 to png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()