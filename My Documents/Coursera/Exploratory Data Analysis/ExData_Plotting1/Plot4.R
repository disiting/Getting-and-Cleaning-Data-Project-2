## Downloading data
data1 <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                  comment.char="")
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")

## Subsetting for Feb 1 and Feb 2, 2007
ourdata <- subset(data1, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Converting dates
datetime <- paste(as.Date(ourdata$Date), ourdata$Time)
ourdata$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(ourdata, {
     plot(Global_active_power~Datetime, type="l", 
          ylab="Global Active Power", xlab="")
     plot(Voltage~Datetime, type="l", 
          ylab="Voltage", xlab="datetime")
     plot(Sub_metering_1~Datetime, type="l", 
          ylab="Global Active Power", xlab="")
     lines(Sub_metering_2~Datetime,col='Red')
     lines(Sub_metering_3~Datetime,col='Blue')
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power~Datetime, type="l", 
          ylab="Global Rective Power",xlab="datetime")
})

## Saving to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()