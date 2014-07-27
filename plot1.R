# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
#   from all sources for each of the years 1999, 2002, 2005, and 2008.

# Load data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Summing over the years
total.emissions <- aggregate(NEI$Emissions, by=list(Year = NEI$year), FUN = sum)

# Modify name
names(total.emissions)[2] = "PM2.5 Emissions (tons)"

# Plot
plot(total.emissions, xaxp = c(1999, 2008, 3), type = "l", col = "navy", pch = 19, main = expression("Total " * PM[2.5] * " Emissions in the US"), ylab = expression(PM[2.5] * " Emissions (in tons)"))

# Save plot to file
dev.copy(png, file="plot1.png")
dev.off()