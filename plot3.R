## set working directory
setwd("C:/Users/zubeir/Desktop/DataScience/assignment6")

## Add library ggplot2 to plot ggplot2 later
library(ggplot2)

## Read in data from summarySCC_PM25.rds file, if object NEI does not exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

## Read in data from Source_Classification_Code.rds file, if object SCC does not exist
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Perform subset of data where Baltimore City, Maryland (fips == "24510")
subsetNEI  <- NEI[NEI$fips=="24510", ]

## Aggregate data by year and type
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)

## Plot data
png("plot3.png", width=640, height=480)
gg_plot <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
gg_plot <- gg_plot + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(gg_plot)
dev.off()