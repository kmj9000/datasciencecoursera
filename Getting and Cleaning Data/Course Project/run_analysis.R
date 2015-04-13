setwd("~/datasciencecoursera/Getting and Cleaning Data/Course Project")

## Load both sets of training and test data
tmp1 <- read.table("./UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("./UCI HAR Dataset/test/X_test.txt")
X <- rbind(tmp1, tmp2)

tmp1 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
tmp2 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("./UCI HAR Dataset/train/y_train.txt")
tmp2 <- read.table("./UCI HAR Dataset/test/y_test.txt")
Y <- rbind(tmp1, tmp2)


## Extract only mean and standard deviation for each measurement
features <- read.table("./UCI HAR Dataset/features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices_of_good_features]
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))


## Use descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"


## Label the data set with descriptive activity names
names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_clean_data.txt")


## Create a 2nd independent tidy data set with the average of each variable for each activity and each subject
unique_subj = unique(S)[,1]
num_subj = length(unique(S)[,1])
num_actv = length(activities[,1])
num_cols = dim(cleaned)[2]
result = cleaned[1:(num_subj*num_actv), ]

row = 1
for (s in 1:num_subj) {
  for (a in 1:num_actv) {
    result[row, 1] = unique_subj[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:num_cols] <- colMeans(tmp[, 3:num_cols])
    row = row+1
  }
}
write.table(result, "tidy_data_set_with_the_averages.txt")