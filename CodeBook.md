Cleaning and getting data project Code Book
--------------------------------------------

the run_analysis.R scrip contain 5 steps:

step 01:
download the zip file, unzip the file and loud the varibales. 
filename = data.zip
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
activitylable = the alble of activity
futures = features
test_x = test data set
train_x = train data set
test_y = test activity
train_y = train activity
test_subject = test subject
train_subject = train subject

Merges the training and the test sets to create one data set
dataset = merged test and train data set
activity = merged test and train activity
sunject = merged test and train subject

step 02:
Extracts only the measurements on the mean and standard deviation for each measurement
extract_measurements_index = the index of columns of mean and sd

step 03:
Uses descriptive activity names to name the activities in the data set
extract_measurements_names = the name of extracted columns

step 04:
Appropriately labels the data set with descriptive variable names

step 05:
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
change the form of the data to long data and then apply the summarise function.           
                 
