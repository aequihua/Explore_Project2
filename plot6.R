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

# Obtain percentage change values
pchLA = vector(mode="numeric", length=0)
pchBA = vector(mode="numeric", length=0)
for (i in 2:nrow(sumed[sumed$County=="06037",])) {
  pchLA[i] = ((sumed[sumed$County=="06037",]$TotalEmissions[i] - 
                 sumed[sumed$County=="06037",]$TotalEmissions[i-1]) /
                sumed[sumed$County=="06037",]$TotalEmissions[i-1]) * 100
}

for (i in 2:nrow(sumed[sumed$County=="24510",])) {
  pchBA[i] = ((sumed[sumed$County=="24510",]$TotalEmissions[i] - 
                 sumed[sumed$County=="24510",]$TotalEmissions[i-1]) /
                sumed[sumed$County=="24510",]$TotalEmissions[i-1]) * 100
}
# Replace the fips number with a more readable label
sumed$County[sumed$County=="06037"] = "Los Angeles"
sumed$County[sumed$County=="24510"] = "Baltimore"

png('./plot6.PNG')
qplot(Year,TotalEmissions,data=sumed, 
      ylab="Total Emissions (tons)") + geom_point(size=3, colour="blue") +
  ggtitle("Motor Vehicle Emissions - Baltimore vs Los Angeles") + theme_bw() +
  geom_smooth(method="lm")+facet_wrap(~County, scales="free_y")
dev.off()
