# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#Answer: Decreases of non-road, nonpoint, on-road. Point had fluctuations: increased in the period through 1999 to 2005, then decreased.

library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))


# Total Emissions by year and type: Baltimore City, Maryland
total_emissions_Baltimore_t <- NEI[fips == "24510", .(emissions.total = sum(Emissions)), by = .(year, type)]


#Create and save Plot3.png
plot.new() 
png("Plot3.png", res = 144, width = 800, height = 800)

ggplot(total_emissions_Baltimore_t, aes(x = as.character(year), y = emissions.total, group = type, col = type)) +
  theme_light() + labs(x = NULL, y = "PH2.5 in Tons", title = "Baltimore City emissions") +
  geom_line(aes(size = type)) + 
  scale_size_manual(values = c(0.5, 0.5, 0.5, 1.5)) + 
  geom_point(lwd = 3, pch = 10) 

dev.off()
