# The variables are removed and the directory is set
rm(list=ls())
setwd("C:/Users/JigsawAM003/Documents/Explo/exdata_data_NEI_data")
library(ggplot2)
library(plyr)

# The files are read and the dataframes are combined
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
FinalData <- merge(NEI, SCC, by="SCC", all=F)

# Plot 6
Plot6Data <- subset(FinalData, fips %in% c("24510", "06037"))
Plot6Data2 <- Plot6Data[grep("[Vv]ehicle", Plot6Data$EI.Sector, ignore.case = T),]
Plot6Data2$year <- as.factor(Plot6Data2$year)
png("Plot6.png")
ggplot(Plot6Data2, aes(year, Emissions, fill= fips)) + stat_summary(fun.y = "sum", geom = "bar", position= "dodge")+ ggtitle("Vehicular Emission comparision of Los Angeles and Baltimore") 
dev.off()