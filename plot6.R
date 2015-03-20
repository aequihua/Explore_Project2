-----------------------------
  #  Exploratory Data Analysis - Course Project 2
  #  PLOT 6
  #  Author: Arturo Equihua
  #  Date : March 18th 2015
  #---------------------------------

# Load the files onto memory
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Produce the plot

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

library(plyr)
library(ggplot2)

SCCMotor=SCC[grep("Mobile",SCC$EI.Sector,fixed=TRUE),]  # Subset the Vehicle-related classifications
NEIMotor=subset(NEI, NEI$fips %in% c("24510","06037") & NEI$SCC %in% SCCMotor$SCC ) # Get the NEI subset that corresponds to vehicles, Baltimore

sumed=ddply(NEIMotor,c("fips","year"),function(x) sum(x$Emissions))
colnames(sumed) = c("County","Year","TotalEmissions")

# Replace the fips number with a readable label
sumed$County[sumed$County=="06037"] = "Los Angeles"
sumed$County[sumed$County=="24510"] = "Baltimore"

png('./plot6.PNG')
qplot(Year,TotalEmissions,data=sumed, col=County,
      ylab="Total Emissions (tons)") + geom_line() +
  ggtitle("Motor Vehicle Emissions - Baltimore vs Los Angeles") + theme_bw()
dev.off()
