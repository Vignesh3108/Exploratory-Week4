# The variables are removed and the directory is set
rm(list=ls())
setwd("C:/Users/JigsawAM003/Documents/Explo/exdata_data_NEI_data")
library(ggplot2)
library(plyr)

# The files are read and the dataframes are combined
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
FinalData <- merge(NEI, SCC, by="SCC", all=F)

# Plot 5
Plot2Data <- subset(FinalData, fips == "24510")
Plot5Data <- Plot2Data[grep("[Vv]ehicle", Plot2Data$EI.Sector, ignore.case = T),]
Plot5Data$year <- as.factor(Plot5Data$year)
png("Plot5.png")
ggplot(Plot5Data, aes(year, Emissions)) + stat_summary(fun.y = "sum", geom = "bar", fill = "#FFFF00")+ ggtitle("Vehicular Emission across Baltimore") 
dev.off()
