#-----------------------------
#  Exploratory Data Analysis - Course Project 2
#  PLOT 2
#  Author: Arturo Equihua
#  Date : March 18th 2015
#---------------------------------

# Load the files onto memory
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Produce the plot

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
library(plyr)
sumed=ddply(subset(NEI,NEI$fips=="24510"),c("year"),function(x) sum(x$Emissions))
colnames(sumed) = c("Year","TotalEmissions")

png('./plot2.PNG')
par(bg="pink1",col="darkgreen",lwd=1)
plot(TotalEmissions~Year,sumed,xlab="Year",ylab="Total Emissions (ton)",type="b", 
     main="Total PM2.5 Emissions in Baltimore,MD")
grid(col="tomato")
dev.off()
