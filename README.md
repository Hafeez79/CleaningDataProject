# This file describes how the R scripts works. This was prepared for the final project assignment in Getting and Cleaning Data course on Coursera.

The script downloads mobile phone data from the following URL...

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This contains several files of movement data recorded by cellphones for several volunteer subjects. Data on measurements, subject IDs, and activity types are contained in diefferent files.

The script puts together the relevant data into a single dataset, and then calculates mean values for all mesurements that indicate a mean or an standard deviation. Details about the data are in the code book. Details about the working of the script follow.

Required packages: dplyr

Make sure that you set the target folder as the working directory. The script can then be launched.

The script checks if the zipped file "getdata_projectfiles_UCI HAR Dataset" already exists in the working directory. If not, the file is downloaded from the above URL.

The script then checks if a folder named "UCI_HAR_Dataset" exists in the working directory. If not, the zipped file is unzipped and this folder is created. The folder contains files and sub-folders. The sub-sub folders names 'Inertial Signals' contain raw data which has already been processed and transformed into data files saved directly in test and train folders. Hence, the raw data will not be used by this script.

The code then reads each relevant file into data sets. These data sets contain measurement data, IDs of volunteer subjects, and activity types. The data are merged into a single dataset with appropriate column names.

A subset of the data is created which contain subject IDs, activity type and all those measurements which are either std or mean of some measurement.

Finally, a summary dataset is created which contains average of each measurement for each subject ID and by activity type.
