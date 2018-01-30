INSTRUCTIONS

Before proceeding, download the zipped dataset from the link provided in the coursera to a new folder inside your R working directory.
Extract zipped file in the new folder. Do not rename or edit any of the files

1. Use data.table and dplyr libraries. Use read.table() function to read through Train and Test dataset and merge subject,
activity and feature columns to a variable mergedData using rbind(). Also, read through features.txt and activity_labels.txt 
located inside the extracted UCI HAR Dataset folder.

2. Extract from mergedData the columns which contain the mean and standard deviations using grep(). Add the two additional
colums after the last column of mergedData which is 561 and assign that to a variable newDataset.

3. Rename the data in the activity field of the newData based on the six descriptive names mentioned in the activity_labels.txt
using the for loop control structure iterating through the six rows. Also, convert Activity to factor which will later on be
used to insert the activity names in the cleaned data.

4. Inspect the generated data of the newDataset and replace data with meaning names using gsub() function.

5. Generate a file for the cleaned data containing the mean for each activity and subject data. Use aggregate() function to
generate the data table, sort using order() function and save it by creating tidyDataset.txt using write.table() function.


VARIABLES
trainSubject, trainActivity, trainFeature, testSubject, testActivity and testFeature contains data from the txt files in the
Train and Test folders.

subject, activity and feature are merged data the Train and Test datasets.

featureInfo and activityLabels contains descriptive data read from features.txt and activity_labels.txt, respectively.

mergedData is the result of the merging of feature, activity and subjct variables.

colsMeanStd contains data of the "grep"ed or searched datasets with columns containing mean and standard deviations 
while addedColumns is a variable for the addedd columns for mean and STD.

NewDataset is the result of the merging of addedColumns to colsMeanStd in which columns for mean and STD were added to the dataset.

tidyDataset contains the final clean data.
