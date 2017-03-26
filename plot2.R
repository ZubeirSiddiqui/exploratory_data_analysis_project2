## set working directory
setwd("C:/Users/zubeir/Desktop/DataScience/assignment6")

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

## Aggregate data
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

## Plot data
png('plot2.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.off()