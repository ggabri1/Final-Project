##### Course Project  -  run_analysis.R
## The following 4lines of codes were used initialy, but were removed for making things faster
## setwd("./courseproject")
## dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download.file(dataset_url, "samsung.zip")
## unzip("samsung.zip")

## Getting the list of the files 
files <- list.files(file.path("UCI HAR Dataset"), recursive = TRUE)
files

## features.txt - List of all features
## X_test.txt and Y_text.txt test and labels
## X_train.txt and Y_train.txt training set and labels
## subject_test.txt and subject_train.txt -  Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30

## Reading the files
MainTest  <- read.table(file.path("UCI HAR Dataset", "test" , "X_test.txt" ),header = FALSE)
MainTrain  <- read.table(file.path("UCI HAR Dataset", "train" , "X_train.txt" ),header = FALSE)
ActivityTest  <- read.table(file.path("UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain  <- read.table(file.path("UCI HAR Dataset", "train" , "Y_train.txt" ),header = FALSE)
SubjectTest <- read.table(file.path("UCI HAR Dataset", "test" , "subject_test.txt" ),header = FALSE)
SubjectTrain <- read.table(file.path("UCI HAR Dataset", "train" , "subject_train.txt" ),header = FALSE)

## Checking the dimentions of new dataframes
dim(MainTest); dim(MainTrain); dim(ActivityTest); dim(ActivityTrain); dim(SubjectTest); dim(SubjectTrain)

## 1. Merge the training and the test sets to create one data set. - By coresponding datasets
MainData <- rbind(MainTrain, MainTest)
ActivityData <- rbind(ActivityTrain, ActivityTest)
SubjectData <- rbind(SubjectTrain, SubjectTest)

## Naming two main variables
names(SubjectData)<-c("subject")
names(ActivityData)<- c("activity")
## Naming all other variables(features)
featureNames <- read.table(file.path("UCI HAR Dataset", "features.txt"),head=FALSE)
names(MainData)<- featureNames$V2


## Merging all data together by columns 
TotalData <- cbind(SubjectData, ActivityData, MainData)
str(TotalData)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## Identifying only variables that show mean and standard deviation measurements 
subfeatures<-featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]
NewNames<-c("subject", "activity", as.character(subfeatures))
TotalData<-subset(TotalData, select=NewNames)
str(TotalData)
head(TotalData[1:5])

## 3. Use descriptive activity names to name the activities in the data set
## Adding activity names for Activites variable and updating the main dataframe
activities <- read.table(file.path("UCI HAR Dataset", 'activity_labels.txt'))
TotalData[, 2] <- activities[TotalData[,2], 2]
head(TotalData$activity,3)

## 4. Appropriately label the data set with descriptive variable names.
## renaming prefixes "t" and "f" to time and frequency respectively,
## Acc - Accelerometer, Gyro - Gyroscope, Mag - Magnitude, BodyBody - body

names(TotalData)<-gsub("^t", "time", names(TotalData))
names(TotalData)<-gsub("^f", "frequency", names(TotalData))
names(TotalData)<-gsub("Acc", "Accelerometer", names(TotalData))
names(TotalData)<-gsub("Gyro", "Gyroscope", names(TotalData))
names(TotalData)<-gsub("Mag", "Magnitude", names(TotalData))
names(TotalData)<-gsub("BodyBody", "Body", names(TotalData))

##removing the paranthesis after variable names
names(TotalData)<-gsub('\\-|\\(|\\)', '', names(TotalData))
names(TotalData)

## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.           
library(reshape2)
## Making a long dataset for each subject and activity as one observation
TotalDataLong <- melt(TotalData, id = c('subject', 'activity'))

##Getting the mean values for each activity-subject combination
DataNewMean <- dcast(TotalDataLong, subject + activity ~ variable, mean)                        

## Extract the new data set
write.table(DataNewMean, file=file.path("tidydataset.txt"), row.name = FALSE)




