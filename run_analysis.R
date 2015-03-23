## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("~/Box Sync/Coursera/Getting and Cleaning Data/Project/")
###Download the project files
if(!file.exists("./getdataproject.zip")){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileUrl, destfile = "getdataproject.zip", method = "curl")
}
###Load the data into r
file_path <- "~/Box Sync/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset"
#Vairiable names stored in the features file
features_names <- read.table(file = paste(file_path, "/features.txt", sep = ""),header=F)
#activity labels stored in the activity_labels file
activity_labels <- read.table(file = paste(file_path, "/activity_labels.txt", sep = ""), header=F)
##Test data
#Test subject who performed each activity
subject_test <- read.table(file = paste(file_path, "/test/subject_test.txt", sep = ""), header=F)
#Set
features_test <- read.table(file = paste(file_path, "/test/X_test.txt", sep = ""), header=F)
#Labels
activity_test <- read.table(file = paste(file_path, "/test/y_test.txt", sep = ""), header=F)
##Training data
subject_train <- read.table(file = paste(file_path, "/train/subject_train.txt", sep = ""), header=F)
#Training set
features_train <- read.table(file = paste(file_path, "/train/X_train.txt", sep = ""), header=F)
#Training labels
activity_train <- read.table(file = paste(file_path, "/train/y_train.txt", sep = ""), header=F)
#Merge the training and the test sets to create one data set.
features_data <- rbind(features_test, features_train)
activity_data <- rbind(activity_test, activity_train)
subject_data <- rbind(subject_test, subject_train)

#Add labels to my data
names(features_data) <- features_names[,2]
names(subject_data) <- "subject"
names(activity_data) <- "activity"
activity_data <- sort(activity_data$activity)
#Merge all data
subjAct <- cbind(subject_data, activity_data)
All_data <- cbind(features_data, subjAct)

###Extract only the measurements on the mean and standard deviation for each measurement.
mean_std <- subset(features_names,  grepl("(mean\\(\\)|std\\(\\))", features_names$V2) )
##Set column names for All_data with Subject, activity_id, activity
colnames(All_data) <- c("Subject","Activity_Id",as.vector(features_names[,2]))
#Extract mean and std deviation from All_data
mean <- grep("mean()", colnames(All_data), fixed=TRUE)
std_dev <- grep("std()", colnames(All_data), fixed=TRUE)
#Combine mean and std_dev into a single vector and sort
mean_std_dev <- c(mean, std_dev)
mean_std_dev <- sort(mean_std_dev)
## extract the columns with std and mean in their column headers
extracted <- All_data[,c(1,2,3,mean_std_dev)]

library(reshape2)
library(dplyr)

#Use descriptive activity names to name the activities in the data set
#Appropriately label the data set with descriptive variable names.
id_labels <- c("Subject", "Activity_Id")
data_labels <- setdiff(colnames(extracted), id_labels)
meltData <- melt(extracted, id.vars=67:68, measure.vars=1:66)

# Apply mean function to dataset using dcast function
tidy_data <- dcast(meltData, Subject + Activity_Id ~ variable, mean)
write.table(tidy_data, file="tidy_data.txt", sep="\t", row.name=FALSE)

##Codebook
library(memisc)
codebook(tidy_data)
