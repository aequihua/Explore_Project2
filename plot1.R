#-----------------------------
#  Exploratory Data Analysis - Course Project 2
#  PLOT 1
#  Author: Arturo Equihua
#  Date : March 18th 2015
#---------------------------------

# Load the files onto memory
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Produce the plot

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission fromç
# all sources for each of the years 1999, 2002, 2005, and 2008.
library(plyr)
sumed=ddply(NEI,c("year"),function(x) sum(x$Emissions)/1e+6)
colnames(sumed) = c("Year","TotalEmissions")

png('./plot1.PNG')
par(bg="khaki",col="darkgreen",lwd=1)
plot(TotalEmissions~Year,sumed,xlab="Year",ylab="Total Emissions (mn ton)",type="b", 
     main="Total PM2.5 Emissions in the US")
grid(col="tomato")
dev.off()
