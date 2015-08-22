# Getting and Cleaning Data Course Project in Coursera

##Introduction
This repository contains the project for the Coursera third course  called 'Getting and Cleaning Data' of the Data Science Specialization. In the repository can be found (except `README.md` file): `CODEBOOK.md` (descriprion of the varibales of tidy data set), `run_analysis.R` (script which is the project work), `tidy_data.txt` (tidy data set with the average of each variable for each activity and each subject and the output of R_analysis script).

##Instructions for project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions 
related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any 
transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 

This repo explains how all of the scripts work and how they are connected. One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using +Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called `run_analysis.R` that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive variable names. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Raw data description
The original data called 'Human Activity Recognition Using Smartphones Dataset' represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using +Smartphones 

It was the experiments, which have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (```WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING```) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

#Description of the current script

###SECTION 0
Downloading and preparing data.

####Step 1
First of all you should to creat correct directory, where you will download ziped data for the project. Before do that, I created special folder called `Getting_and_Cleaning_Data`. Also, are needed following packages:
*`data.table`
*`dplyr`
*`plyr`

####Step 2
Get the data. For that, we can before creat new folder in our directory, which the name will be 'project'. Later download the zipped data from following link:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and put it in the 'project' folder. Later, unzip the  file. All datas will be located in the folder called 'UCI HAR Dataset'.

####Step 3
Read all needed datas before merging into correct varriables. It will be made in two rounds. The first read datas are from test measurnment and its contain tree types of files: 
1. `X_test.txt` - test set 
2. `Y_test.txt` - test lables
3. `subject_test.txt` - each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

For have more controle on the data merging proces, add identification variable for test set named 'source' and value 1. Preparing data sets for training in the same way like for test data. The identification variable for training set has 
value 2 in the source column.

###SECTION 1 and 2 
Merges the training and the test sets to create one data set and extracts only the measurements on the mean and standard deviation for each measurement. 

####Step 4 
First, merge the sets by rows into three partial tables contained x sets, y sets and subject sets. Before starting it, upload dplyr package. 

####Step 5 
Add the names of each variables in merging datasets from `features.txt` file. 

####Step 6 
Extracts only the measurements on the mean and standard deviation for each measurement. Do it only for x type data which contains the requested features.

####Step 7 
Merges the training and the test sets  to create one data set called `data_all`. To do that, concatenate the data tables by colums.

###SECTION 3
Uses descriptive activity names to name the activities in the data set.

####Step 8 
Read descriptive activity names from `activity_labels.txt`. Use this file to name the values of the activity variable. Also here is named the values of the other created variables called `source`, which identifies the set from 
where data cames in divition to test datas and training datas.

###SECTION 4 
Appropriately labels the data set with descriptive variable names.

####Step 9
To label the data sets use `gsub()` function. Names of features will labelled using descriptive variable names in following order:
*`t` is replaced by `Time_`
*`f` is replaced by `Frequency_`
*`Gyro` is replaced by `Gyroscope_`
*`Acc` is replaced by `Accelerometer_`
*`Mag` is replaced by `Magnitude_`
*`BodyBody` and `Body` is replaced by `Body_`
*`Jerk` is replaced by `Jerk_`
*`Gravity` is replaced by `Gravity_`

###SECTION 5
Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

####Step 10
For creat a new tidy data set has to be uploaded `plyr` package for use `ddplyr` function. The final data set will be created as txt file with `write.table() using row.name=FALSE`. 

