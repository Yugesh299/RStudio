house <- data.table::fread(input = "household_power_consumption.txt",na.strings="?")
house[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
house[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
house <- house[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
png("plot1.png", width=480, height=480)
hist(house[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()