setwd("~/datasciencecoursera/Getting and Cleaning Data")

## Q1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destf = "./getdata-data-ss06hid.csv"
download.file(url, destfile = destf)
data <- read.table(destf, sep = ",", header = TRUE)

agricultureLogical <- data$ACR == 3 & data$AGS == 6
which(agricultureLogical)[1:3]

## Q2
## install.packages('jpeg')
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
destf = "./getdata-jeff.jpg"
download.file(url, destfile = destf, mode = "wb")

img <- readJPEG(destf, native = TRUE)
quantile(img, probs = c(0.3, 0.8))

## Q3
## library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdpfile <- "./getdata-data-GDP.csv"
download.file(url, destfile = gdpfile)
gdpdata <- data.table(read.csv(gdpfile, skip = 4, nrows = 215))
gdpdata <- gdpdata[X != ""]
gdpdata <- gdpdata[, list(X, X.1, X.3, X.4)]
setnames(gdpdata, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
edfile <- "./getdata-data-EDSTATS_Country.csv"
download.file(url, destfile = edfile)
eddata <- data.table(read.csv(edfile))

data <- merge(gdpdata, eddata, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(data$rankingGDP)))
data[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]

## Q4
data[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]

## Q5
breaks <- quantile(data$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
data$quantileGDP <- cut(data$rankingGDP, breaks = breaks)
data[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]

