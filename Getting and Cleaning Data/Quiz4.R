setwd("~/datasciencecoursera/Getting and Cleaning Data")

## Q1
## library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destf = "./getdata-data-ss06hid.csv"
download.file(url, destfile = destf)
data <- data.table(read.csv(destf))

varNames <- names(data)
varNamesSplit <- strsplit(varNames, "wgtp")
varNamesSplit[[123]]


## Q2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destf = "./getdata-data-GDP.csv"
download.file(url, destfile = destf)
dataGDP <- data.table(read.csv(destf, skip = 4, nrows = 215, stringsAsFactors = FALSE))

dataGDP <- dataGDP[X != ""]
dataGDP <- dataGDP[, list(X, X.1, X.3, X.4)]
setnames(dataGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dataGDP$gdp))
mean(gdp, na.rm = TRUE)

## Q3
isUnited <- grepl("^United", dataGDP$Long.Name)
summary(isUnited)

## Q4
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
destf = "./getdata-data-EDSTATS_Country.csv"
download.file(url, destfile = destf)
dataEd <- data.table(read.csv(destf))

data <- merge(dataGDP, dataEd, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(data$Special.Notes))
isJune <- grepl("june", tolower(data$Special.Notes))
table(isFiscalYearEnd, isJune)

## Q5
## install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn) 
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))