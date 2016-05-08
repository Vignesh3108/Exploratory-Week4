# The variables are removed and the directory is set
rm(list=ls())
setwd("C:/Users/JigsawAM003/Documents/Explo/exdata_data_NEI_data")
library(ggplot2)
library(plyr)

# The files are read and the dataframes are combined
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
FinalData <- merge(NEI, SCC, by="SCC", all=F)

# Plot 2
class(FinalData$fips)
Plot2Data <- subset(FinalData, fips == "24510")
Plot2Data2 <- with(Plot2Data, tapply(Emissions, year, sum, na.rm=T))
png("Plot2.png")
barplot(Plot2Data2)
title(main = "Total PM2.5 Emission in Baltimore", xlab="Years", ylab= "Emission in tons" )
dev.off()
