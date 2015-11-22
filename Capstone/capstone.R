## Set working directory and ready the packages

setwd("~/datasciencecoursera/Capstone")
install.packages("jsonlite")
install.packages("dplyr")
install.packages("maps")
install.packages("ggplot2")
library("R.utils")
library("jsonlite")
library("data.table")
library("dplyr")
library("ggplot2")
library("maps")


## Download and unzip dataset

dataDir <- "./DataSet"
#zipFile <- paste(dataDir, "yelp_dataset_challenge_academic_dataset.zip", sep = "/")
#download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/yelp_dataset_challenge_academic_dataset.zip", zipFile)
#unzip(zipFile)


## Load pseudo-JSON data files
## Credit to solution provided in course forum https://class.coursera.org/dsscapstone-005/forum/thread?thread_id=24

bizDataFilePath <- paste(dataDir, "yelp_academic_dataset_business.json", sep="/")
chkDataFilePath <- paste(dataDir, "yelp_academic_dataset_checkin.json", sep="/")
revDataFilePath <- paste(dataDir, "yelp_academic_dataset_review.json", sep="/")
tipDataFilePath <- paste(dataDir, "yelp_academic_dataset_tip.json", sep="/")
usrDataFilePath <- paste(dataDir, "yelp_academic_dataset_user.json", sep="/")

#bizData <- fromJSON(sprintf("[%s]", paste(readLines(bizDataFilePath), collapse = ",")), flatten = TRUE)
#chkData <- fromJSON(sprintf("[%s]", paste(readLines(chkDataFilePath), collapse = ",")), flatten = TRUE)
#revData <- fromJSON(sprintf("[%s]", paste(readLines(revDataFilePath), collapse = ",")), flatten = TRUE)
#tipData <- fromJSON(sprintf("[%s]", paste(readLines(tipDataFilePath), collapse = ",")), flatten = TRUE)
#usrData <- fromJSON(sprintf("[%s]", paste(readLines(usrDataFilePath), collapse = ",")), flatten = TRUE)


## Save objects in binary for ease of subsequent reloading
#saveRDS(bizData, paste(dataDir, "bizData.rds", sep="/"))
#saveRDS(chkData, paste(dataDir, "chkData.rds", sep="/"))
#saveRDS(revData, paste(dataDir, "revData.rds", sep="/"))
#saveRDS(tipData, paste(dataDir, "tipData.rds", sep="/"))
#saveRDS(usrData, paste(dataDir, "usrData.rds", sep="/"))

bizData <- readRDS(paste(dataDir, "bizData.rds", sep="/"))
chkData <- readRDS(paste(dataDir, "chkData.rds", sep="/"))
revData <- readRDS(paste(dataDir, "revData.rds", sep="/"))
tipData <- readRDS(paste(dataDir, "tipData.rds", sep="/"))
usrData <- readRDS(paste(dataDir, "usrData.rds", sep="/"))


##
bizChk <- merge(bizData, chkData, by = "business_id")


## Load US map data
all_states <- map_data("state")
## Restrict businesses to only those residing in US
bizData2 <- subset(bizData, open=='TRUE' & match(bizData$state, state.abb))
bizData2states <- unique(bizData2$state)
#plot all states with ggplot
p <- ggplot()
p <- p + geom_polygon( data=all_states, aes(x=long, y=lat, group = group),colour="white", fill="grey80" )
p <- p + geom_point( data=bizData2, aes(x=longitude, y=latitude), color="blue") # + scale_size(name="Total enrollment")
p <- p + geom_text( data=bizData2[!duplicated(bizData2$state)], hjust=0.5, vjust=-0.5, aes(x=longitude, y=latitude, label=state), colour="red", size=4 )
p