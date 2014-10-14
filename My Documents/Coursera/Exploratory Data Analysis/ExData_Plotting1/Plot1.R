## Downloading data
data1 <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      comment.char="")
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")

## Subsetting for Feb 1 and Feb 2, 2007
ourdata <- subset(data1, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Converting dates
datetime <- paste(as.Date(ourdata$Date), ourdata$Time)
ourdata$Datetime <- as.POSIXct(datetime)

## Plot 1
hist(ourdata$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()