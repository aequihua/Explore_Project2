-----------------------------
  #  Exploratory Data Analysis - Course Project 2
  #  PLOT 4
  #  Author: Arturo Equihua
  #  Date : March 18th 2015
  #---------------------------------

# Load the files onto memory
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Produce the plot

# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?
library(plyr)

SCCCoal=SCC[grep("Coal",SCC$EI.Sector,fixed=TRUE),]  # Subset the Coal classifications
NEICoal=subset(NEI, NEI$SCC %in% SCCCoal$SCC ) # Get the NEI subset that corresponds to coal

sumed=ddply(NEICoal,c("year"),function(x) sum(x$Emissions))
colnames(sumed) = c("Year","TotalEmissions")

png('./plot4.PNG')
par(bg="darkgreen",col="yellow",lwd=1)
plot(TotalEmissions~Year,sumed,xlab="Year",ylab="Total Emissions (mn ton)",type="b", 
     main="Total PM2.5 Emissions in the US - Coal-related sources")
grid(col="white")
dev.off()

