## Getting and Cleaning Data Course Project

### Introduction
The goal of this project was to prepare tidy data that can be used 
for later analysis. The original dataset comes from 
[UCI - Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Files
* run_analysis.R: R Script that performs the followins activities:

	0. Get the data
	1. Merge the training and the test sets to create one data set
	2. Extract only the measurements on the mean and standard deviation for each measurement
	3. Use descriptive activity names to name the activities in the data set
	4. Appropriately label the data set with descriptive variable names
	5. Create a second, independent tidy set with the average of each variable for each activity and each subject

* codebook.md: Description of the variables and the data of this Data Set

* tidy_data.txt: File containing the output of run_analysis.R
