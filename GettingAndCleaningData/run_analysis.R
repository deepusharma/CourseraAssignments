# -----------------------------------------------------------------------------
#1. Merges the training and the test sets to create one data set.
# -----------------------------------------------------------------------------

# It is assumed that the data is available in the current working directory. 
# It should be extracted from the zipfile provided for assignment. Structure 
# should be similiar to as below:
# .
# run_analysis.R
# CodeBook.md
# README.md
# UCI HAR Dataset
#     test
#     train
#     ....


# Set the working Directory on sandbox
# setwd ("C:\\Users\\deepushru\\Documents\\MEGA\\Study\\Coursera\\Getting and Cleaning Data\\WS_GettingAndCleaningData\\peer_assignment")

# load the test data 
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test = read.table("./UCI HAR Dataset/test/X_test.txt")
y_test = read.table("./UCI HAR Dataset/test/y_test.txt")
combined_test = cbind ( X_test, y_test, subject_test)

# load the training data 
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train = read.table("./UCI HAR Dataset/train/X_train.txt")
y_train = read.table("./UCI HAR Dataset/train/y_train.txt")
combined_train = cbind ( X_train, y_train, subject_train)

# combine the data
combined_data = rbind(combined_test,combined_train)


# get the column names from features.txt
features = read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
header_lables = c( features[,2], "activity", "subject")

# Assign the names to the dataframe:
colnames(combined_data) <- header_lables

#header_lables[grep("mean\\(\\)|std\\(\\)|activity|subject", header_lables)]

# -----------------------------------------------------------------------------
#2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
# -----------------------------------------------------------------------------
combined_data_subset = combined_data [,grep("mean\\(\\)|std\\(\\)|activity|subject", header_lables)]

# -----------------------------------------------------------------------------
#3. Uses descriptive activity names to name the activities in the data set
# -----------------------------------------------------------------------------
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
activityColName = c ("activity","activity_desc")

colnames(activity_labels) <- activityColName

#getActivityDesc <- function (activity) {
#  activity_labels[activity_labels$activity==activity,2]
#}

vector_activity_desc = sapply(combined_data_subset$activity, function (activity) {
  activity_labels[activity_labels$activity==activity,2]
})

combined_data_subset_with_desc = cbind(combined_data_subset, vector_activity_desc)


# -----------------------------------------------------------------------------
#4. Appropriately labels the data set with descriptive activity names. 
# -----------------------------------------------------------------------------
colnames (combined_data_subset_with_desc) <- c(header_lables[grep("mean\\(\\)|std\\(\\)|activity|subject", header_lables)], "activity_desc")


# -----------------------------------------------------------------------------
#5. Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 
# -----------------------------------------------------------------------------
#t<- by(combined_data_subset_with_desc[, 1:66], combined_data_subset_with_desc[,67:68], colMeans)
#temp <- do.call(rbind,t)

require(plyr)
combined_data_with_mean <- ddply(combined_data,.(subject, activity), colMeans)


# Also Add ACtivity Lables: 
activity_desc = sapply(combined_data_with_mean$activity, function (activity) {
  activity_labels[activity_labels$activity==activity,2]
})

combined_data_with_mean_and_desc  = cbind(combined_data_with_mean, vector_activity_desc)


# Cleanup the names of the variables
cleaned_up_names <- names(combined_data_with_mean_and_desc)
cleaned_up_names <- tolower(gsub("_|\\(|\\)|-|,","", cleaned_up_names))
colnames (combined_data_with_mean_and_desc) <- cleaned_up_names

# Now write to file for submission:
write.table(combined_data_with_mean_and_desc, "./UCI HAR Dataset/tidy_data.txt", row.names=FALSE, quote = FALSE, sep="\t")
