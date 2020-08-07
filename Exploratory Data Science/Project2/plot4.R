df <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
df1 <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
combustionRelated <- grepl("comb", df1[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", df1[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- df1[combustionRelated & coalRelated, SCC]
combustionNEI <- df[NEI[,SCC] %in% combustionSCC]
png("plot4.png")
ggplot(combustionNEI,aes(x = factor(year),y = Emissions/10^5)) +geom_bar(stat="identity", fill ="#FF9999", width=0.75) +labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
dev.off()
