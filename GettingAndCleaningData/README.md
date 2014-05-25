Getting and Cleaning Data: Assignment: 
----------------------------------------------

This projects is to test the abilities of the students to load available data and prepare the clean/tidy data using the skills acquired during the course. The tidy-data can be used for further analysis 

The data is collected from the accelerometers from the Samsung Galaxy S smartphone. The dataset used in the project is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of the data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


What is included in the repository:
----------------------------------------------

* README.md - This is the file you are viewing currently

* CodeBook.md - This is the codebook to describe various variables included in the tidy_data.txt and other files used. 

* run_analysis.R - This is the script developed to address the problems/tasks mentioned in the assignment.

* tidy_data.txt - This is the output generated from the script. Though its not necessary to include it in the github, it has been stored nevertheless for the ease of access if required. 



Pre-requisites:
----------------------------------------------
 It is assumed that the data is available in the current working directory. It should be extracted from the zipfile provided for assignment. Structure should be similiar to as below:
   .
   run_analysis.R
   CodeBook.md
   README.md
   UCI HAR Dataset
      test
      train
      ....


The Task and Approach:
----------------------------------------------

The provided scripts (run_analysis.R) includes the following sub tasks: 
* Merges the training and the test sets to create one data set.
  

* Extracts only the measurements on the mean and standard deviation for each measurement. 

* Uses descriptive activity names to name the activities in the data set

* Appropriately labels the data set with descriptive activity names. 

* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


