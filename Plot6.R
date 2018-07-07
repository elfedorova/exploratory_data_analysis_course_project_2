# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#Answer:

library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

# Motor vehicle's SCC:
vehicle <- SCC[grep("vehicle", EI.Sector, ignore.case = T), unique(SCC)]

# Emissions from motor vehicle-related sources for Baltimore City and Los-Angeles County by year 
emissions_motor_2 <- NEI[SCC %in% vehicle & fips %in% c("24510", "06037"),
           .(emissions.total = sum(Emissions)),
           by = .(fips = as.factor(fips), year)]

#Create and save Plot6.png
plot.new() 
png("Plot6.png", res = 144, width = 800, height = 800)


ggplot(emissions_motor_2, aes(x = as.character(year), y = emissions.total, group = fips)) +
  facet_grid(fips ~ ., scales = "free",
             labeller = as_labeller(c("24510" = "Baltimore City",
                                      "06037" = "Los Angeles County"))) +
  theme_light() +
  labs(x = NULL, y = expression("PM"[2.5]*" in Tons"),
       title = "Motor vehicle emissions",
       subtitle = "Baltimore City vs. Los Angeles County") +
  geom_line(lwd = 1, show.legend = FALSE, col = "blue") +
  geom_point(lwd = 2, col = "black")

dev.off()