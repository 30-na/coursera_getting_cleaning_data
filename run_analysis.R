
# change directory
setwd("C:/Users/sin/Documents/R/Coursera/getting and cleaning data/")
# download and uzip the files
filename="data.zip"
destfile = paste("C:/Users/sin/Documents/R/Coursera/getting and cleaning data/", filename, sep="")
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)){
  download.file(url=url, destfile=destfile)
}
if (!file.exists("UCI HAR Dataset")) { 
  unzip(destfile) 
}

# load data
activitylabels = read.table("UCI HAR Dataset/activity_labels.txt")
features = read.table("UCI HAR Dataset/features.txt")

test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")
test_x = read.table("UCI HAR Dataset/test/X_test.txt")
test_y = read.table("UCI HAR Dataset/test/y_test.txt")

train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")
train_x = read.table("UCI HAR Dataset/train/X_train.txt")
train_y = read.table("UCI HAR Dataset/train/y_train.txt")

#01 Merges the training and the test sets to create one data set
dataset = rbind(test_x, train_x)
activity = rbind(test_y, train_y)
subject = rbind(test_subject, train_subject) 


#02 Extracts only the measurements on the mean and standard deviation for each measurement
extract_measurements_index = grep("-(mean|std)", features[,2])
dataset = dataset[extract_measurements_index]
dataset= data.frame(dataset, activity, subject)

#03 Uses descriptive activity names to name the activities in the data set
extract_measurements_names = grep("-(mean|std)", features[,2], value=TRUE)
extract_measurements_names = gsub("[()]", "", extract_measurements_names)
extract_measurements_names = gsub("-mean", "Mean", extract_measurements_names)
extract_measurements_names = gsub("-std", "Std", extract_measurements_names)
extract_measurements_names = gsub("-", "", extract_measurements_names)
colnames(dataset) = c(extract_measurements_names, "activity", "subject")


#04 Appropriately labels the data set with descriptive variable names. 
dataset$activity = factor(dataset$activity, levels=activitylabels[,1],
                          labels = activitylabels[,2])
dataset$subject <- as.factor(dataset$subject)


#05 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(tidyr)
library(dplyr)
tidy = dataset %>% 
  gather(variable, value, 1:79) %>%
  group_by(activity, subject, variable) %>%
  summarise(mean(value))
write.table(tidy, "./tidy_data.txt", row.name=FALSE)



