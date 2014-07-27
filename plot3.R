# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#   which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system 
#   to make a plot answer this question.

# Load data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subsetting data from Baltimore City
baltimore.NEI <- subset(NEI, fips == "24510")

# Summing over the types and years
typical.emissions <- aggregate(baltimore.NEI$Emissions, by = list(Type = baltimore.NEI$type, Year = baltimore.NEI$year), FUN = sum)
typical.emissions

# Plot (layer by layer)
library(ggplot2)

g <- ggplot(typical.emissions, aes(Year, x)) # Basic plot
g <- g + geom_line(aes(color = typical.emissions$Type)) # Line coloring break down by source type
g <- g + scale_x_continuous(breaks = seq(1999, 2008, 3)) # Modify labels along the x-axis
g <- g + labs(title = expression("Total " * PM[2.5] * " Emissions over Source types in Baltimore"), x = "Year", y = expression(PM[2.5] * " Emissions (in tons)")) # Modifying lab titles and main title
g <- g + scale_colour_discrete(name = "Source Type") # Modifying legend title
g

# Save plot to file
dev.copy(png, file="plot3.png")
dev.off()