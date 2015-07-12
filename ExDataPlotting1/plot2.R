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
pwr <- data.frame(pwr[1], data.frame(lapply(pwr[2:8],as.numeric), stringsAsFactors = FALSE))  
#NAs induced by coercsion
# Used pwr for all four plots.




####################  Plot 2 ##################################################################
png(file = "plot2.png")

plot(pwr$DateTime, pwr$Global_active , ylab = "Global Active Power (kilowatts)", 
     pch = ".", xaxt = 'n' , xlab = "")

lines(pwr$DateTime, pwr$Global_active )

title(main = "Plot 2" , adj = 0, outer = TRUE, line =-1)

tick1 <-as.POSIXct(strptime("2007/2/1 00:00:00" , format = '%Y/%m/%d %H:%M:%S' , tz = "EST"))
tick2 <-as.POSIXct(strptime("2007/2/2 00:00:00" , format = '%Y/%m/%d %H:%M:%S' , tz = "EST"))
tick3 <-as.POSIXct(strptime("2007/2/3 00:00:00" , format = '%Y/%m/%d %H:%M:%S' , tz = "EST"))
tick_vec <-c(tick1 , tick2, tick3)

axis(side =1 ,  at = tick_vec , labels = c("Thu", "Fri", "Sat") )   ##Error message.  

dev.off()
