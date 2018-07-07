# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# Answer: Yes, it has decreased.

library(data.table)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))

# Total Emissions by year
total_emissions <- NEI[, .(emissions.total = sum(Emissions)), by = year]
shares <- round(48 * (1 - total_emissions$emissions.total / max(total_emissions$emissions.total)) + 1)
colors <- grey.colors(32)[shares]


#Create and save Plot1.png
plot.new() 
png("plot1.png", res = 144, width = 800, height = 800) 
par(mai = c(0.52, 0.99, 0.62, 0.22)) 

with(total_emissions, barplot(emissions.total, names.arg = year, axes = FALSE, col = colors, cex.lab = .8)) 
mtext(side = 2, text = "PM2.5 emission Tons", line = 4, cex = .85) 
title(main = "United States total PM2.5 emission", cex.main = 1.4) 
ylabels <- c(0, paste(1:7, "Mln")) 
yticks  <- seq(0, 7000000, by = 1000000) 
axis(2, las = 2, labels = ylabels, at = yticks, lwd = 2, cex.axis = 1) 

dev.off() 