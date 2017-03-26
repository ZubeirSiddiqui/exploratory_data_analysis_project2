## set working directory
setwd("C:/Users/zubeir/Desktop/DataScience/assignment6")

## Add library ggplot2 to plot ggplot2 later
library(ggplot2)

## Read in data from summarySCC_PM25.rds file, if object NEI does not exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

## Perform subset of data where Baltimore City, Maryland (fips == "24510") and Los Angeles County, California (fips == "06037")
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
gg_plot <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
gg_plot <- gg_plot + facet_grid(. ~ fips)
gg_plot <- gg_plot + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(gg_plot)
dev.off()