## set working directory
setwd("C:/Users/zubeir/Desktop/DataScience/assignment6")

## Add library ggplot2 to plot ggplot2 later
library(ggplot2)

## Read in data from summarySCC_PM25.rds file, if object NEI does not exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

## Perform subset of data where Baltimore City, Maryland (fips == "24510")
subsetNEI  <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

## Aggregate total emission by year
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

## Plot data
png("plot5.png", width=840, height=480)
gg_plot <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
gg_plot <- gg_plot + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(gg_plot)
dev.off()