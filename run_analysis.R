#Step 1 - first of all you should to creat correct directory,
#where you will download ziped data for the project. 
#Before do that, I created special folder called 'Getting and Cleaning Data'.

setwd("C://Users//Aneta//Desktop//R_course//Getting_Cleaning_DATA")

#Step 2 is to get the data. For that, we can before creat new folder in
#our directory, which the name will be 'project'. Later download the zipped data
#from following link:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#and put it in the 'project' folder. Later, unzip the file. All datas will be located
#in the folder called 'UCI HAR Dataset'.

if (!file.exists("project")) {dir.create("project")}

fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./project/Smartphones_Data_Set.zip")
unzip(zipfile="./project/Smartphones_Data_Set.zip", exdir="./project")

##Step 3 - read all needed datas before merging into correct varriables. It will be made in two rounds. 
#The first read datas are from test features and its contain tree types of files: 
#1. 'X_test.txt' - test set 
#2. 'Y_test.txt' - test lables
#3. 'subject_test.txt' - each row identifies the subject who performed the activity 
#for each window sample. Its range is from 1 to 30. 

library(data.table)
data_test_x<- read.table("./project/UCI HAR Dataset/test/X_test.txt", header=FALSE)
data_test_y<- read.table("./project/UCI HAR Dataset/test/y_test.txt", header=FALSE)
data_test_subj<-data.table(read.table("./project/UCI HAR Dataset/test/subject_test.txt", header=FALSE))

##Add identification variable for test set named 'source' and value 1.
library(data.table)
data_test_subj_add<-data_test_subj[,SOURCE:=1]

##Preparing data sets for training in the same way like for test description located above.

data_train_x<- read.table("./project/UCI HAR Dataset/train/X_train.txt", header=FALSE)
data_train_y<- read.table("./project/UCI HAR Dataset/train/y_train.txt", header=FALSE)
data_train_subj<-data.table(read.table("./project/UCI HAR Dataset/train/subject_train.txt", header=FALSE))

##Add identification variable for training set named 'source' and value 2.
data_train_subj_add<-data_train_subj[,SOURCE:=2]


##Step 4 - Merges the training and the test sets to create one data set called data_all.
##First, merge the sets by rows into three partial tables
## contained x sets, y sets and subject sets. Before starting it, upload dplyr package.

library(dplyr)

data_x_all<-bind_rows(data_test_x, data_train_x)
data_y_all<-bind_rows(data_test_y, data_train_y)
data_subj_all<-bind_rows(data_test_subj, data_train_subj)

##Step 5 - add the names of each variables in merging datasets

features_labels<-read.table("./project/UCI HAR Dataset/features.txt", header=FALSE )
colnames(data_x_all)<-features_labels$V2
colnames(data_y_all)<-c("activity")
colnames(data_subj_all)<-c("subject", "source")

## Step 6 -Extracts only the measurements on the mean and 
##standard deviation for each measurement. Do it only for x type data contains the features datas
extract_features <- grepl("mean|std", features_labels$V2)
data_x_selected = data_x_all[,extract_features]

##Step 7 - Merges the training and the test sets to create one data set called 'data_all'.
##To do that, concatenate the data tables by colums
data_all<-bind_cols(data_y_all,data_subj_all,data_x_selected )

##Step 8 - Uses descriptive activity names to name the activities in the data set.
##Also here is named the values of the other created variables called 'source', which identifies
##the set from where data cames in divition to test datas and training datas.
activity_label<-read.table("./project/UCI HAR Dataset/activity_labels.txt", header=FALSE)
data_all$activity<- factor(data_all$activity, levels = activity_label[,1], labels=activity_label[,2])
data_all$source<- factor(data_all$source, levels = 1:2, labels=c("test feature","training feature"))

##Step 9 - Appropriately labels the data set with descriptive variable names
names(data_all) <-(gsub("^t", "Time_", names(data_all) ))           
names(data_all) <-(gsub("^f", "Frequency_", names(data_all) ))   
names(data_all) <-(gsub("Gyro", "Gyroscope_", names(data_all) ))   
names(data_all) <-(gsub("Acc", "Accelerometer_", names(data_all) )) 
names(data_all) <-(gsub("Mag","Magnitude_", names(data_all) )) 
names(data_all) <-(gsub("Body|BodyBody","Body_", names(data_all) )) 
names(data_all) <-(gsub("Jerk","Jerk_", names(data_all) )) 
names(data_all) <-(gsub("Gravity","Gravity_", names(data_all) )) 

##Step 10 - Create a second, independent tidy data set with the average (means) of 
##each variable for each activity and each subject
library(plyr)
data_all_tidy <- ddply(data_all, .(subject, activity), function(x) colMeans(x[, 4:82]))
write.table(data_all_tidy, "./project/tidy_data.txt", row.name=FALSE)

