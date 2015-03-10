setwd("~/datasciencecoursera/Getting and Cleaning Data")

## Q1
library(httr)
require(httpuv)
require(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("Week2Quiz", "2bef336b7acd4abfc7bb", secret = "296ec110c2046c5183c48b55886b93f0a5b7ad9c")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
url <- "https://api.github.com/users/jtleek/repos"
gtoken <- config(token = github_token)
req <- GET(url, gtoken)
stop_for_status(req)
output <- content(req)
list(output[[1]]$name, output[[1]]$created_at)
#BROWSE(url,authenticate("Access Token","x-oauth-basic","basic"))
output[output$created_at]


## Q2
library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destf = "./getdata-data-ss06pid.csv"
download.file(url, destfile = destf)
acs <- read.csv(destf, header=T, sep=",")
sqldf("select pwgtp1 from acs where AGEP < 50")



## Q3
sqldf("select distinct AGEP from acs")


## Q4
url <- "http://biostat.jhsph.edu/~jleek/contact.html" 
conn <- url(url)
htmlCode <- readLines(conn)
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)


## Q5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
destf = "./getdata-wksst8110.for"
download.file(url, destfile = destf)
data <- read.csv(destf, header = TRUE)
df <- read.fwf(file=destf,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(df[, 4])
