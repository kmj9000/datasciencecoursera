setwd("~/datasciencecoursera/Getting and Cleaning Data")

## Q1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destf = "./getdata-data-ss06hid.csv"
download.file(url, destfile = destf)
data <- read.table(destf, sep = ",", header = TRUE)
sum(data$VAL==24, na.rm=TRUE)

## Q2
## Each tidy data table contains information about only one type of observation.

## Q3
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_40')
library(xlsx)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
destf = "./getdata-data-DATA.gov_NGAP.xlsx"
download.file(url, destfile = destf, mode = "wb")
rows <- 18:23
cols <- 7:15
dat <- read.xlsx(destf, 1, colIndex = cols, rowIndex = rows)
sum(dat$Zip*dat$Ext,na.rm=T) 

##Q4
library(XML)
library(RCurl)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
destf = "./getdata-data-restaurants.xml"
download.file(url, destfile = destf, mode = "wb")
doc <- xmlTreeParse(destf, useInternal=TRUE)
rootNode <- xmlRoot(doc)
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
table(zipcode == 21231)

##Q5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destf = "./getdata-data-ss06pid.csv"
download.file(url, destfile = destf, mode = "wb")
DT <- fread(destf, sep=",")

system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))

system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2])

system.time(mean(DT$pwgtp15,by=DT$SEX))

system.time(DT[,mean(pwgtp15),by=SEX])

system.time(mean(DT[DT$SEX==1,]$pwgtp15)); system.time(mean(DT[DT$SEX==2,]$pwgtp15))

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
