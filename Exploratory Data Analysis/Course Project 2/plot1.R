setwd("~/datasciencecoursera/Exploratory Data Analysis/Course Project 2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

tot_PM25_by_year <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
plot(names(tot_PM25_by_year), tot_PM25_by_year, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()