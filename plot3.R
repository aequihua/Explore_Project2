#-----------------------------
#  Exploratory Data Analysis - Course Project 2
#  PLOT 3
#  Author: Arturo Equihua
#  Date : March 18th 2015
#---------------------------------

# Load the files onto memory
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Produce the plot

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.
library(plyr)
library(ggplot2)

sumed=ddply(subset(NEI,NEI$fips=="24510"),c("type","year"),function(x) sum(x$Emissions))
colnames(sumed) = c("Type","Year","TotalEmissions")

png('./plot3.PNG')
p = ggplot(data=sumed, aes(x=Year,y=TotalEmissions),ylab="Total Emissions (tons)" ) +
    geom_line(colour="blue") + ggtitle("Emissions in Baltimore, MD - Split by Source") + 
    theme_bw() + facet_wrap(~Type, scales="free_y") + geom_point(colour="red", size=2.5) +
    geom_smooth(method='lm')
print(p)
  
dev.off()