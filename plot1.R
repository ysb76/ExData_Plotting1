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

#PLOT 1
png("plot1.png", width=480, height=480, units="px")  #default is 480x480px so could use png("plot1.png")
with(final, hist(Global_active_power, xlab="Global Active Power (kilowatts)",
                 ylab="Frequency", col="red", main="Global Active Power"))
dev.off()