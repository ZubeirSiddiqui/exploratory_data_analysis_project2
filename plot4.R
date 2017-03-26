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

## Added coal filter here to reduce data size
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

## Merge both datasets 
NEISCC <- merge(NEI, subsetSCC, by="SCC")

## Aggregate data for each year
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEISCC, sum)

## Plot data and add bar
png("plot4.png", width=640, height=480)
gg_plot <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
gg_plot <- gg_plot + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(gg_plot)
dev.off()
