### coursera 'Getting and Cleaning Data' project
### https://class.coursera.org/getdata-008/human_grading

library(reshape2)

## prerequisite: the dataset has been downloaded from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and unpacked into subdirectory DATADIR.

DATADIR <- 'UCI HAR Dataset'

## read in and sanitise the feature names
features <- read.table(sprintf('%s/features.txt', DATADIR), colClasses='character')
feature.names <- make.names(features[[2]])
feature.names <- gsub('\\.+', '.', feature.names)
feature.names <- gsub('\\.+$', '', feature.names)

## read in the activity names
activities <- read.table(sprintf('%s/activity_labels.txt', DATADIR), colClasses='character')

## this function reads in the specified train/test data files and returns a data.frame
read.data <- function(set)
{
    basepath <- paste(DATADIR, set, sep='/')
    
    ## feature data
    a <- read.table(sprintf('%s/X_%s.txt', basepath, set), sep='', colClasses='numeric')

    ## assign descriptive column names
    names(a) <- feature.names
    
    ## subject column
    a$subject <- factor(readLines(file(sprintf('%s/subject_%s.txt', basepath, set))))

    ## activity column
    a$activity <- factor(readLines(file(sprintf('%s/y_%s.txt', basepath, set))), levels=activities[[1]], labels=activities[[2]])

    a
}


## Step 1. Merge the training and the test sets to create one data set.
## Step 3. Use descriptive activity names to name the activities in the data set.
## Step 4. Appropriately label the data set with descriptive variable names. 

A <- rbind(read.data('train'), read.data('test'))

## Step 2. Extract only the measurements on the mean and standard deviation for each measurement. 

cols <- grep('mean\\.|std', names(A))
B <- A[, c(cols, NCOL(A) + (-1:0))]

## Step 5. From the data set in step 4, create a second, independent tidy data set
## with the average of each variable for each activity and each subject.

C <- melt(B, id.vars=list('subject', 'activity'))
D <- dcast(C, subject + activity ~ ..., fun.aggregate=mean, na.rm=T)

## write out the tidy data set for submission
write.table(D, file='output.txt', row.names=F)
