#Project - Week 1

#data from UC Irvine Machine Learning Repository
#https://d396qusza40orc.cloudfront.net /exdata%2Fdata%2Fhousehold_power_consumption.zip

#download data and unzip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
              ", destfile=temp, method="curl")
unz.file = unz(temp, "household_power_consumption.txt")
power = read.table(unz.file, header=TRUE, sep=";", na.strings="?")
power$Date = as.Date(power$Date, "%d/%m/%Y")
unlink(temp)

#convert Date and Time variables
power$cDT = strptime( paste(power$Date, power$Time), "%Y-%m-%d %T") 

#reduce data frame to include only dates 2007-02-01 and 2007-02-02
final = power[power$Date==as.Date("2007-02-01") | power$Date==as.Date("2007-02-02"),]

#PLOT 3
png("plot3.png", width=480, height=480, units="px")
matplot(as.POSIXct(final$cDT), final[,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")],type="l",
        lty=1, col=c("black", "red", "blue"), xlab="", ylab="Energy sub metering", xaxt="n")
axis.POSIXct(1, at = seq(min(final$cDT), max(final$cDT) + 24*60*60, by="day"), format="%a")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"))

dev.off()





