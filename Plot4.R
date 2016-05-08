# The variables are removed and the directory is set
rm(list=ls())
setwd("C:/Users/JigsawAM003/Documents/Explo/exdata_data_NEI_data")
library(ggplot2)
library(plyr)

# The files are read and the dataframes are combined
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
FinalData <- merge(NEI, SCC, by="SCC", all=F)


# Plot 4
Plot4Data <- FinalData[grep("[Cc]oal", FinalData$EI.Sector, ignore.case = T),]
Plot4Data$year <- as.factor(Plot4Data$year)
png("Plot4.png")
ggplot(Plot4Data, aes(year, Emissions, fill = type)) + stat_summary(fun.y = "sum", geom = "bar", position = "dodge")+ ggtitle("Coal Emissions across USA") 
dev.off()
