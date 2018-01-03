# run_analysis.R
#
# Creates a tidy dataset containing the average of each variable for 
# each activity and each subject. The original dataset comes from 
# UCI - Human Activity Recognition Using Smartphones.
# 
# Additional reference:
# 	Readme.txt
# 	Codebook.md
#

library(dplyr)

### 0. Get the data
my_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(my_url, destfile="Dataset.zip")
unzip(zipfile="Dataset.zip")

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
 
features <- read.table("./UCI HAR Dataset/features.txt")
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

### 1. Merge the training and the test sets to create one data set
merge_train <- cbind(subjecttrain, ytrain, xtrain)
merge_test <- cbind(subjecttest, ytest, xtest)
merge_all <- rbind(merge_train, merge_test)

### 2. Extract only the measurements on the mean and standard deviation for
###    each measurement
# Define a name for the SubjectID and Activity, and merge with features
first2cols <- data.frame(V1=0,V2=c("subjectID","activity"))
allcols <- rbind(first2cols, features)

# Get the columns with subject, activity, mean or std in their name
colswanted <- grepl("subject|activity|mean|std", allcols[,2])

# Subset the data with only the desired columns
ds_meanstd <- merge_all[,colswanted==TRUE]

### 3. Use descriptive activity names to name the activities in the data set
# Update the 2nd column with the names in activitylabels
ds_meanstd[,2] <- activitylabels[ds_meanstd[,2],2]

### 4. Appropriately label the data set with descriptive variable names
# Use the allcols and colswanted data frames to set descriptive names
colnames(ds_meanstd) <- allcols[colswanted==TRUE,2]

### 5. Create a second, independent tidy set with the average of each
###    variable for each activity and each subject
# Use dplyr to group by and summarize the data set
ds_tidy <- ds_meanstd %>%
	group_by(subjectID, activity) %>%
		summarize_all(funs(mean))

# Write the final, tidy data set to a text file
write.table(ds_tidy, "tidy_data.txt", row.names=FALSE, quote=FALSE)
