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

## aggregate total emision by year
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

## plot data

png('plot1.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()
