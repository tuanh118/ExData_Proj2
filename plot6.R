# Compare emissions from motor vehicle sources in Baltimore City with emissions 
#   from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Load data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subsetting data from Los Angeles and Baltimore
la.bal.NEI <- subset(NEI, fips %in% c("24510", "06037"))

# Subsetting data of type ON-ROAD
la.bal.onroad <- subset(la.bal.NEI, type == "ON-ROAD")

# Summing over the years
la.bal.onroad.emissions <- aggregate(la.bal.onroad$Emissions, by=list(fips = la.bal.onroad$fips, Year = la.bal.onroad$year), FUN = sum)

# Plot
library(ggplot2)

g <- ggplot(la.bal.onroad.emissions, aes(Year, x)) # Basic plot
g <- g + geom_line(aes(color = la.bal.onroad.emissions$fips)) # Line coloring break down by county
g <- g + scale_x_continuous(breaks = seq(1999, 2008, 3)) # Modify labels along the x-axis
g <- g + labs(title = expression("Total " * PM[2.5] * " Emissions from Motor vehicle in Los Angeles and Baltimore"), x = "Year", y = expression(PM[2.5] * " Emissions (in tons)")) # Modifying lab titles and main title
g <- g + scale_colour_discrete(name = "County", labels = c("Los Angeles", "Baltimore")) # Modifying legend title
g

# Save plot to file
dev.copy(png, file="plot6.png")
dev.off()
