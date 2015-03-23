This is the codebook for the the course project (Getting and Cleaning data). Contained in this repository is information about the data we have worked with.

The file run_analysis.R contains the code (with comments) we used to clean up the data. This code folows the steps below:

Reads in several data files after downloading from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output file is tidy_data, which has the data and its columns all named.

A short description of the tidy data:
An experiement was conducted with 30 subjects to collect data about each activity between walking, walking up stairs, walking down stairs, sitting, standing and laying flat.
Since we have 30 subjects, each has a unique id number in the range 1:30, and the corresponding data listed in the subsequent columns.
