# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Answer: decreased

library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

# Coal's SCC IDs:
coals_ids <- SCC[grep("coal", EI.Sector, ignore.case = T), unique(SCC)]

# Emissions from coal combustion-related sources by year
emissisions_coal <- NEI[SCC %in% coals_ids, .SD, by = year]

#Create and save Plot4.png
plot.new()
png("Plot4.png", res = 144, width = 800, height = 900)

ggplot(emissisions_coal, aes(x = as.factor(year), y = Emissions)) +
geom_bar(stat = "identity") + 
xlab("year") +
ylab(expression('Total PM'[2.5]*" Emissions")) +
ggtitle('Total Emissions from coal sources from 1999 to 2008')

dev.off()
