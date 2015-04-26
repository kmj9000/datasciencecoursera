setwd("~/datasciencecoursera/Exploratory Data Analysis/Course Project 2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510")

tot_PM25_by_year <- tapply(Baltimore$Emissions, Baltimore$year, sum)

png("plot2.png")
plot(names(tot_PM25_by_year), tot_PM25_by_year, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()