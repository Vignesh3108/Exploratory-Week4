# The variables are removed and the directory is set
rm(list=ls())
setwd("C:/Users/JigsawAM003/Documents/Explo/exdata_data_NEI_data")
library(ggplot2)
library(plyr)

# The files are read and the dataframes are combined
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
FinalData <- merge(NEI, SCC, by="SCC", all=F)


# Plot 1
Plot1Data <- with(FinalData, tapply(Emissions, year, sum, na.rm=T))
png("Plot1.png")
barplot(Plot1Data)
title(main = "Total PM2.5 Emission", xlab="Years", ylab= "Emission in tons" )
dev.off()

# Plot 2
class(FinalData$fips)
Plot2Data <- subset(FinalData, fips == "24510")
Plot2Data2 <- with(Plot2Data, tapply(Emissions, year, sum, na.rm=T))
png("Plot2.png")
barplot(Plot2Data2)
title(main = "Total PM2.5 Emission in Baltimore", xlab="Years", ylab= "Emission in tons" )
dev.off()

# Plot 3
Plot2Data <- subset(FinalData, fips == "24510")
Plot3Data <- ddply(Plot2Data, .(type, year), summarise, Emissions=sum(Emissions, na.rm=T))
png("Plot3.png")
ggplot(Plot3Data, aes(year, Emissions, fill = type)) + stat_summary(fun.y = "sum", geom = "bar", position = "dodge") + 
  ggtitle("Barplot by type for each Year in Baltimore city")
dev.off()

# Plot 4
Plot4Data <- FinalData[grep("[Cc]oal", FinalData$EI.Sector, ignore.case = T),]
Plot4Data$year <- as.factor(Plot4Data$year)
png("Plot4.png")
ggplot(Plot4Data, aes(year, Emissions, fill = type)) + stat_summary(fun.y = "sum", geom = "bar", position = "dodge")+ ggtitle("Coal Emissions across USA") 
dev.off()

# Plot 5
Plot2Data <- subset(FinalData, fips == "24510")
Plot5Data <- Plot2Data[grep("[Vv]ehicle", Plot2Data$EI.Sector, ignore.case = T),]
Plot5Data$year <- as.factor(Plot5Data$year)
png("Plot5.png")
ggplot(Plot5Data, aes(year, Emissions)) + stat_summary(fun.y = "sum", geom = "bar", fill = "#FFFF00")+ ggtitle("Vehicular Emission across Baltimore") 
dev.off()

# Plot 6
Plot6Data <- subset(FinalData, fips %in% c("24510", "06037"))
Plot6Data2 <- Plot6Data[grep("[Vv]ehicle", Plot6Data$EI.Sector, ignore.case = T),]
Plot6Data2$year <- as.factor(Plot6Data2$year)
png("Plot6.png")
ggplot(Plot6Data2, aes(year, Emissions, fill= fips)) + stat_summary(fun.y = "sum", geom = "bar", position= "dodge")+ ggtitle("Vehicular Emission comparision of Los Angeles and Baltimore") 
dev.off()