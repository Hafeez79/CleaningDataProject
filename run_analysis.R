# License:
#     ========
#     Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
# 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity 
# Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
# Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# 
# This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors 
# or their institutions for its use or misuse. Any commercial use is prohibited.
# 
# Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


# Load necessary libraries

library(dplyr)



# Download the file if it is not already downloaded

myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

zippedfile <- "getdata_projectfiles_UCI HAR Dataset"

if (!file.exists(zippedfile)){
    download.file(myurl, destfile = zippedfile, mode='wb')
}


# Unzip the file if it is not already unzipped

if (!file.exists("./UCI_HAR_Dataset")){
    unzip(zippedfile)
}

setwd("./UCI HAR Dataset")


# Read the relevant files into data frames

Activity_Labels <- read.table("./activity_labels.txt", header = FALSE)

Features_Names <- read.table("./features.txt", header = FALSE)

Activity_Test <- read.table("./test/y_test.txt", header = FALSE)
Features_Test <- read.table("./test/X_test.txt", header = FALSE)
Subject_Test <- read.table("./test/subject_test.txt", header = FALSE)

Activity_Train <- read.table("./train/y_train.txt", header = FALSE)
Features_Train <- read.table("./train/X_train.txt", header = FALSE)
Subject_Train <- read.table("./train/subject_train.txt", header = FALSE)

# Merg test and train dataframes
AllFeatures <- rbind(Features_Test, Features_Train)
AllSubjects <- rbind(Subject_Test, Subject_Train)
AllActivity <- rbind(Activity_Test, Activity_Train)

# name the features, subject and activity columns

names(AllFeatures) <- Features_Names$V2

colnames(Activity_Labels) <- c("V1", "Activity")
AllActivity <- left_join(AllActivity, Activity_Labels, by="V1")[,2]

colnames(AllSubjects) <- "Subject"

# Merge into a single dataset

fulldata <- cbind(AllSubjects, AllActivity, AllFeatures)

# list of variables that contain mean or std

stdMean <- as.character(Features_Names$V2[grep("mean\\(\\)|std\\(\\)",Features_Names$V2)]) 
subcolnames <- c("Subject", "AllActivity", stdMean)                                                                          


# Subset to get only those columns that contain mean and std data

SubData <- subset(fulldata, select=subcolnames)

# Make the column names more descriptive of what they represent


names(SubData)<-gsub("^f", "Frequency", names(SubData))
names(SubData)<-gsub("^t", "Time", names(SubData))
names(SubData)<-gsub("Acc", "Acceleration", names(SubData))
names(SubData)<-gsub("Mag", "Magnitude", names(SubData))


# Create a second dataset containing averages for each subject and activity combination

SummaryData <-aggregate(. ~Subject + AllActivity, SubData, mean)

write.table(SummaryData, './SummaryData.txt',row.names=FALSE,sep='\t')

