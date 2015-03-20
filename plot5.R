-----------------------------
  #  Exploratory Data Analysis - Course Project 2
  #  PLOT 5
  #  Author: Arturo Equihua
  #  Date : March 18th 2015
  #---------------------------------

# Load the files onto memory
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Produce the plot

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(plyr)

SCCMotor=SCC[grep("Mobile",SCC$EI.Sector,fixed=TRUE),]  # Subset the Vehicle-related classifications
NEIMotor=subset(NEI, NEI$fips=="24510" & NEI$SCC %in% SCCMotor$SCC ) # Get the NEI subset that corresponds to vehicles, Baltimore

sumed=ddply(NEIMotor,c("year"),function(x) sum(x$Emissions))
colnames(sumed) = c("Year","TotalEmissions")

png('./plot5.PNG')
par(bg="brown",col="lightgrey",lwd=1)
plot(TotalEmissions~Year,sumed,xlab="Year",ylab="Total Emissions (mn ton)",type="b", 
     main="Total PM2.5 Emissions Baltimore, MD - Motor Vehicle Sources")
grid(col="yellow")
dev.off()