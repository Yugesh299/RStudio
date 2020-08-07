df <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
df1 <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
condition <- grepl("vehicle", df[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- df[condition, df]
vehiclesNEI <- df1[df1[, df] %in% vehiclesSCC,]
vehiclesBaltimoreNEI <- vehiclesNEI[fips == "24510",]
vehiclesBaltimoreNEI[, city := c("Baltimore City")]
vehiclesLANEI <- vehiclesNEI[fips == "06037",]
vehiclesLANEI[, city := c("Los Angeles")]
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)
png("plot6.png")
ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +geom_bar(aes(fill=year),stat="identity") +facet_grid(scales="free", space="free", .~city) +labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
dev.off()
