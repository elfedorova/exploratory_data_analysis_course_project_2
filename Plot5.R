# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Answer: decreased

library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

# Motor vehicle's SCC:
vehicle <- SCC[grep("vehicle", EI.Sector, ignore.case = T), unique(SCC)]

# Emissions from motor vehicle-related sources for Baltimore city by year

emissions_motor <- NEI[SCC %in% vehicle & fips == "24510", .(emissions.total = sum(Emissions)), by = year]

#Create and save Plot5.png
plot.new() 
png("Plot5.png", res = 144, width = 800, height = 800)

ggplot(emissions_motor, aes(x = as.character(year), y = emissions.total, group = 1)) +
  theme_light() +
  labs(x = NULL, y = expression("PM"[2.5]*" in Tons"), title = "US, Baltimore City motor vehicle emissions") +
  geom_line() +
  geom_point(size = 3, col = "blue") 

dev.off()