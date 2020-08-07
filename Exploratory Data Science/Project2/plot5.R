df <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
df1 <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
vehiclesSCC <- df[grepl("vehicle", df$df.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- df1[df1[, df] %in% vehiclesSCC,]
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]
png("plot5.png")
ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
dev.off()
