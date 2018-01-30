#Ensure data.table and dplyr packages are installed.
#Download UCI HAR Dataset at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#and save in your current working directory
#It is recommended to run this per number at rStudio.

library(data.table)
library(dplyr)

#1. read and merge the training and test datasets
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
trainFeature <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
testFeature <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
subject <- rbind(trainSubject, testSubject)
activity <- rbind(trainActivity, testActivity)
feature <- rbind(trainFeature, testFeature)

featureInfo <- read.table("UCI HAR Dataset/features.txt")
activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

colnames(feature) <- t(featureInfo[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
mergedData <- cbind(feature,activity,subject)


#2 Extract the measurements on the mean and standard deviation for each measurement.

colsMeanStd <- grep(".*Mean.*|.*Std.*", names(mergedData), ignore.case=TRUE)
addedColumns <- c(colsMeanStd, 562, 563)
newDataset <- mergedData[,addedColumns]


#3 Use descriptive activity names for the activities in the data set

newDataset$Activity <- as.character(newDataset$Activity)
for (i in 1:6){
newDataset$Activity[newDataset$Activity == i] <- as.character(activityLabel[i,2])
}
newDataset$Activity <- as.factor(newDataset$Activity)


#4 Appropriately label the data set with descriptive variable names.
names(newDataset)
names(newDataset)<-gsub("Acc", "Accelerometer", names(newDataset))
names(newDataset)<-gsub("Gyro", "Gyroscope", names(newDataset))
names(newDataset)<-gsub("BodyBody", "Body", names(newDataset))
names(newDataset)<-gsub("Mag", "Magnitude", names(newDataset))
names(newDataset)<-gsub("^t", "Time", names(newDataset))
names(newDataset)<-gsub("^f", "Frequency", names(newDataset))
names(newDataset)<-gsub("tBody", "TimeBody", names(newDataset))
names(newDataset)<-gsub("-mean()", "Mean", names(newDataset), ignore.case = TRUE)
names(newDataset)<-gsub("-std()", "STD", names(newDataset), ignore.case = TRUE)
names(newDataset)<-gsub("-freq()", "Frequency", names(newDataset), ignore.case = TRUE)
names(newDataset)<-gsub("angle", "Angle", names(newDataset))
names(newDataset)<-gsub("gravity", "Gravity", names(newDataset))
names(newDataset)


#5 From the data set in step 4, create a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

newDataset$Subject <- as.factor(newDataset$Subject)
newDataset <- data.table(newDataset)
tidyDataset <- aggregate(. ~Subject + Activity, newDataset, mean)
tidyDataset <- tidyDataset[order(tidyDataset$Subject,tidyDataset$Activity),]
write.table(tidyDataset, file = "tidyDataset.txt", row.names = FALSE)
