##course project notes

## SETTING WORKING DIRECTORY
setwd("C:/Users/HerrinFamilyPC/Desktop/Coursera/Getting and Cleaning Data")

#data citation
#Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#A Public Domain Dataset for Human Activity Recognition 
#Using Smartphones. 
#21th European Symposium on Artificial Neural Networks, 
#Computational Intelligence and Machine Learning, ESANN 2013.
#Bruges, Belgium 24-26 April 2013.


##get the files by downloading and extracting into wd
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip", exdir = "UCI_HAR_Dataset")

dirs <- list.dirs("UCI_HAR_Dataset")
files <- list.files(dirs)

##step 1 Merge training and test sets to create one data set

##pull the train data and labels
x_train <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt")
dim(x_train)

##pull the test data and labels
x_test <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt")
dim(x_test)
y_test <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt")

##use rbind() to combine the rows of train and test
one <- rbind(x_train, x_test)
dim(one)
#[1] 10299   561

## Step 2: Extracts only the measurements on 
## the mean and standard deviation for each measurement.
## in other words
## selects those columns which represent mean() and std() for
## each feature

##first pull in labels and features
labels <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/features.txt")


##use grep1() to look for column names with "mean()" as part of text of column name; store as meanvector
lookformean <- c("mean()")
meanvector <- features$V1[grepl(lookformean, features$V2) == TRUE]


##use grep1() to identify std() columns; store as stdvector
lookforstd <- c("std()")
stdvector <- features$V1[grepl(lookforstd, features$V2) == TRUE]

## subsets one dataframe along identified mean() columns
onemean <- one[meanvector]
## subsets one dataframe along identified std() columns
onestd <- one[stdvector]

## use cbind() to connect columns of onemean and onestd vectors
two <- cbind(onemean, onestd)
head(two, n=3)


## Step 3 Uses descriptive activity names to 
## name the activities in the data set

## perhaps can use plyr here instead of qdap, however qdap was used before figuring out how to use plyr

##crealte vector of labels
onelabel <- rbind(y_train, y_test)

install.packages("qdap")
library(qdap)

##create new column in onelabel called V2
##which is created by looking up activity descriptions for each label
##like "VLOOKUP" in excel
onelabel$V2 <- lookup(onelabel$V1, labels)
tail(onelabel)

##two$activitydesc <- onelabel$V2 ## redundant; pushed to step 4
#head(two)

## Step 4 Appropriately labels the data set with 
## descriptive variable names. 
## In other words, name the columns of two

## connects the column placements for meanvector and stdvector into one vector called twonames
twonames <-c(meanvector, stdvector)

## create new data frame of twonames and desc called four
four <- data.frame(twonames)
four$desc <- lookup(four$twonames, features)
head(four)
names(four)


#renames columns of data frame "two" using names from "four"
names(two) <- four$desc
#names(two)

two$activitydesc <- onelabel$V2 ## brought over from step 3
tail(two, n=3)

## Step 5 From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable 
## for each activity and each subject.


## First need to attach subjects to data frame "two"
subject_train <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt")

subjects <- rbind(subject_train, subject_test)
nrow(subjects)

two$subject <- subjects$V1
head(two, n=3)
## here we have data frame "two" with subjects attached

##load dpylr
library(dplyr)

five <- group_by(two, activitydesc, subject)

## "six" creates independent tidy data set
six <- summarise_each(five, funs(mean))
#dim(six)
#[1] 180  81

## exports "six" to text file called "tidy" for submission
write.table(six, "C:/Users/HerrinFamilyPC/Desktop/Coursera/Getting and Cleaning Data/tidy.txt", row.name=FALSE)

##done
