getdata
=======

Coursera 'Getting and Cleaning Data' project
https://class.coursera.org/getdata-008/human_grading

This repo contains 2 files:
1. run_analysis.R: the script that processes the data files and produces the required tidy output.
2. codebook.txt: describes the variables in the tidy dataset.

As a prerequisite, the dataset should have been downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and unpacked into a subdirectory (named by default 'UCI HAR Dataset').

The project requirements are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps 1, 3 and 4 are performed all at once in the function 'read.data', which reads in the necessary 3 files in
the train or test directory.

Step 2 is then performed using standard subsetting on columns which have 'mean' or 'std' in their names. (Columns which have 'meanFrequency' or similar are excluded.)

Step 5 is performed using melt and cast from the 'reshape2' package.
