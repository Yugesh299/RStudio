Source_Classification_Code <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
df <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
df[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
df1 <- df[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
barplot(df1[, Emissions], names = totalNEI[, year], xlab = "Years", ylab = "Emissions", main = "Emissions over the Years")
