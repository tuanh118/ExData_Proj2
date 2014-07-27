# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Load data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subsetting data from Baltimore City
baltimore.NEI <- subset(NEI, fips == "24510")

# Summing over the years
baltimore.emissions <- aggregate(baltimore.NEI$Emissions, by=list(Year = baltimore.NEI$year), FUN = sum)

# Plot
plot(baltimore.emissions, xaxp = c(1999, 2008, 3), type = "l", col = "navy", pch = 19, main = expression("Total " * PM[2.5] * " Emissions in Baltimore"), ylab = expression(PM[2.5] * " Emissions (in tons)"))

# Save plot to file
dev.copy(png, file="plot2.png")
dev.off()
