#######################First get table, extract relevant dates, merge Date and Time as POSIXct, and save as data frame "pwr" #######
#data "household_power_consumption.txt" downloaded from: http://archive.ics.uci.edu/ml/machine-learning-databases/00235/

pwruse <-read.table("household_power_consumption.txt", header = T , sep = ";")
pwruse <-data.frame(data.frame(lapply(pwruse[1:2], as.character), stringsAsFactors = FALSE), pwruse[3:9])
pwruse <-data.frame( DateTime = paste(pwruse$Date, pwruse$Time, sep = " "), pwruse[3:9] )
pwruse<-data.frame(lapply(pwruse[1], function(x) {strptime(x, format = '%d/%m/%Y %H:%M:%S')}), pwruse[2:8])  
#Note: time NAs induced by coercion

begin_date0 <- "02/01/2007"
end_date0 <- "02/03/2007"
begin_date <-strptime(begin_date0, format = '%m/%d/%Y')
end_date <-strptime(end_date0, format = '%m/%d/%Y')

relevant_dates <- (pwruse[ , "DateTime" ] >= begin_date) & (pwruse[ , "DateTime" ] <= end_date)
pwruse <- pwruse[relevant_dates, ]

pwr <- data.frame(pwruse[1], data.frame(lapply(pwruse[2:8],as.character), stringsAsFactors = FALSE))
pwr <- data.frame(pwr[1], data.frame(lapply(pwr[2:8],as.numeric), stringsAsFactors = FALSE))  #NAs induced by coercsion
# Use pwr for all four plots.





###################### Plot 4 ##########################

png(file = "plot4.png")


par(mfrow = c(2,2) )

plot(pwr$DateTime, pwr$Global_active, ylab = "Global Active Power",
     pch = "." , xlab = "")
lines(pwr$DateTime, pwr$Global_active)


plot(pwr$DateTime, pwr$Voltage,
     pch = "." , xlab ="datetime", ylab="Voltage")
lines(pwr$DateTime, pwr$Volt)


plot(pwr$DateTime, pwr$Sub_metering_1 ,
     pch= "." , ylab = "Energy Sub metering",
     xlab = "")
lines(pwr$DateTime, pwr$Sub_metering_1, col = "black")
lines(pwr$DateTime, pwr$Sub_metering_2, col = "red")
lines(pwr$DateTime, pwr$Sub_metering_3, col = "blue")
legend("topright", lty="solid", bty = "n", col=c("black", "blue", "red")
       , legend = c("Sub_metering_1", "Sub_metering_2", 
                    "Sub_metering_3") )


plot(pwr$DateTime , pwr$Global_react , 
     pch=".", xlab = "datetime", 
     ylab = "Global_reactive_power") 
lines(pwr$DateTime, pwr$Global_reactive_power)


title(main ="Plot 4", side = 3 , adj = 0 , outer = TRUE, 
      line=-1)


dev.off()

