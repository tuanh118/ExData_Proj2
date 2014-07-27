# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Load data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Merge the 2 datasets
all <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")

# Subset the coal related sources in short names
coal.NEI <- NEI[grepl("coal", all$Short.Name, ignore.case = T), ]

# Summing over the years
coal.emissions <- aggregate(coal.NEI$Emissions, by=list(Year = coal.NEI$year), FUN = sum)

# Plot
plot(coal.emissions, xaxp = c(1999, 2008, 3), type = "l", col = "navy", pch = 19, main = expression(PM[2.5] * " Emissions from Coal"), ylab = expression(PM[2.5] * " Emissions (in tons)"))

# Save to file
dev.copy(png, file="plot4.png")
dev.off()