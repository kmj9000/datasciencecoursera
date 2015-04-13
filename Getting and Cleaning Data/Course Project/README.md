# Getting and Cleaning Data Course - Course Project
---


## Introduction

Herein contains course project work for Coursera course "Getting and Cleaning Data".


## About the raw data
Data for the project is [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The features (561 of them) are unlabelled and can be found in the x_test.txt.  The activity labels are in the y_test.txt file.  The test subjects are in the subject_test.txt file.  Similarly for the training set.


## About the script and the tidy dataset
"run_analysis.R" performs the following:
1.  Merges the test and training data sets together
2.  Extracts mean and standard deviation for each measurement
3.  Create independent tidy data set with the average of each variable for each activity and each subject
4.  Labels the resultant data set
5.  Output resultant data set to file "tidy_data_set_with_the_averages.txt"


## About the Code Book
The CodeBook.md file explains the transformations performed and the resulting data and variables.
