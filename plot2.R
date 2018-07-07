# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
#Answer: emissions had a decreasing trend from 1999 to 2002, then however to 2005 increased again, and from 2005 to 2008 emissions decreased.

library(data.table)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))



# Total Emissions by year: Baltimore City, Maryland
total_emissions_Baltimore <- NEI[fips == "24510", .(emissions.total = sum(Emissions)), by = year]


#Create and save Plot2.png
plot.new() 
png("Plot2.png", res = 144, width = 800, height = 800) 
par(mai = c(0.52, 0.99, 0.62, 0.22)) 

shares_Baltimore <- round(48 * (1 - total_emissions_Baltimore$emissions.total / max(total_emissions_Baltimore$emissions.total)) + 1)
colors_Baltimore <- grey.colors(32)[shares_Baltimore]

with(total_emissions_Baltimore, barplot(emissions.total, names.arg = year, axes = FALSE,
                  col = colors_Baltimore, cex.lab = .8)) 

mtext(side = 2, text = "PM2.5 emission in Tons", line = 4, cex = .85) 
title(main = "Baltimore City, Maryland: PM2.5 emission", cex.main = 1.4)
ylabels <- pretty(c(0, max(ttl$emissions.total)))
yticks  <- pretty(c(0, max(ttl$emissions.total))) 
axis(2, las = 2, labels = ylabels, at = yticks, lwd = 2, cex.axis = 1) 

dev.off() 