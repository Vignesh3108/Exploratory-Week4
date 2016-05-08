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