# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Load data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subsetting data from Baltimore City
baltimore.NEI <- subset(NEI, fips == "24510")

# Subsetting data of type ON-ROAD
baltimore.onroad <- subset(baltimore.NEI, type == "ON-ROAD")

# Summing over the years
baltimore.onroad.emissions <- aggregate(baltimore.onroad$Emissions, by=list(Year = baltimore.onroad$year), FUN = sum)

# Plot
plot(baltimore.onroad.emissions, xaxp = c(1999, 2008, 3), type = "l", col = "navy", pch = 19, main = expression(PM[2.5] * " Emissions from Motor vehicle in Baltimore"), ylab = expression(PM[2.5] * " Emissions (in tons)"))

# Save plot to file
dev.copy(png, file="plot5.png")
dev.off()