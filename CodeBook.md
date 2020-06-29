CodeBook
================

## The Codebook Definition

This is a final course project for the Getting and Cleaning Data Course
in Coursera.

This file describes the variables, the data, and any transformations or
work that you performed to clean up the data.

The current file consists of three sections:  
1\. Defining the dataset and its source,  
3\. Defining the final tidy data set and the its variables.

## The original data and it definitions

The main data comes from experiments that have been carried out with a
group of 30 volunteers within an age bracket of 19-48 years. Each person
performed six activities (WALKING, WALKING\_UPSTAIRS,
WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone
(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and
gyroscope, we captured 3-axial linear acceleration and 3-axial angular
velocity at a constant rate of 50Hz. The experiments have been
video-recorded to label the data manually. The obtained dataset has been
randomly partitioned into two sets, where 70% of the volunteers was
selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration
and gravity. The gravitational force is assumed to have only low
frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain. See
‘features\_info.txt’ for more details.

#### For each record it is provided:

  - Triaxial acceleration from the accelerometer (total acceleration)
    and the estimated body acceleration.
  - Triaxial Angular velocity from the gyroscope.
  - A 561-feature vector with time and frequency domain variables.
  - Its activity label.
  - An identifier of the subject who carried out the experiment.

#### The dataset includes the following files that have been used in this analysis

  - ‘README.txt’: Ingratiation about the data files in the dataset  
  - ‘features\_info.txt’: Shows information about the variables used on
    the feature vector.  
  - ‘features.txt’: List of all features. (561x2)  
  - ‘activity\_labels.txt’: Links the class labels with their activity
    name.(6x2)  
  - ‘train/X\_train.txt’: Training set. (7352x561)
  - ‘train/y\_train.txt’: Training labels. (7352x1)
  - ‘test/X\_test.txt’: Test set. (2974x561)
  - ‘test/y\_test.txt’: Test labels. (2947x1)
  - ‘train/subject\_train.txt’: Each row identifies the subject who
    performed the activity for each window sample. Its range is from 1
    to 30. (7352x1)
  - ‘test/subject\_test.txt’" Identifying the subject who performed the
    activity (2947x1)  
    –note – (YxZ) dimensions – Y rows and Z columns

#### The data contains other files that have not been used in current analysis

  - ‘train/Inertial Signals/total\_acc\_x\_train.txt’
  - ‘train/Inertial Signals/body\_acc\_x\_train.txt’
  - ‘train/Inertial Signals/body\_gyro\_x\_train.txt’

## The Main Analysis and Its Requirements

The run-analysis.R script does the following.

  - Downloading and transforming the data for the analysis
  - Merges the training and the test sets to create one data set.
  - Extracts only the measurements on the mean and standard deviation
    for each measurement.
  - Uses descriptive activity names to name the activities in the data
    set.
  - Appropriately labels the data set with descriptive variable names.
  - From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

– We will go over each of these steps including the data download,
import and cleaning.

#### Downloading and transforming the data for the analysis

1.1. The data was downloaded from the following source  
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

1.2. Importing Creating UCI HAR Dataset folder with respective datafiles
1.3. Creating dataframes with corresponding files  
\- MainTest - ‘test/X\_test.txt’  
\- MainTrain - ‘train/X\_train.txt’  
\- ActivityTest - ‘test/y\_test.txt’  
\- ActivityTrain - ‘train/y\_train.txt’  
\- SubjectTest - ‘test/subject\_test.txt’  
\- SubjectTrain - ‘train/subject\_train.txt’

#### Merging the training and the test datasets to create one data set

**rbind** function is used to merge corresponding datasets together

Code –  
MainData \<- rbind(MainTrain, MainTest)  
ActivityData \<- rbind(ActivityTrain, ActivityTest)  
SubjectData \<- rbind(SubjectTrain, SubjectTest)

Then , all these files are merged using **cbind** function  
Code – TotalData \<- cbind(SubjectData, ActivityData, MainData)

Here is a snapshot of the Total Data

``` r
head(TotalData[1:5])
```

    ##   subject activity timeBodyAccelerometermeanX timeBodyAccelerometermeanY
    ## 1       1 STANDING                  0.2885845                -0.02029417
    ## 2       1 STANDING                  0.2784188                -0.01641057
    ## 3       1 STANDING                  0.2796531                -0.01946716
    ## 4       1 STANDING                  0.2791739                -0.02620065
    ## 5       1 STANDING                  0.2766288                -0.01656965
    ## 6       1 STANDING                  0.2771988                -0.01009785
    ##   timeBodyAccelerometermeanZ
    ## 1                 -0.1329051
    ## 2                 -0.1235202
    ## 3                 -0.1134617
    ## 4                 -0.1232826
    ## 5                 -0.1153619
    ## 6                 -0.1051373

  - I also used **names** function to add descriptive names to the
    columns.
  - ‘features.txt’ included the names for all the feature which was
    added to the MainData
  - activity and subject columns were named activity and subject
    respectively,

<!-- end list -->

``` r
names(TotalData[1:5])
```

    ## [1] "subject"                    "activity"                  
    ## [3] "timeBodyAccelerometermeanX" "timeBodyAccelerometermeanY"
    ## [5] "timeBodyAccelerometermeanZ"

#### Extracting only the measurements on the mean and standard deviation for each measurement

**grep** function was used to identify the columns that variables that
show mean and standard deviation measurements  
\- only 66 variables were left after the selection

Here are examples of the first and last rows of the new Total Data

``` r
head(TotalData[1:5])
```

    ##   subject activity timeBodyAccelerometermeanX timeBodyAccelerometermeanY
    ## 1       1 STANDING                  0.2885845                -0.02029417
    ## 2       1 STANDING                  0.2784188                -0.01641057
    ## 3       1 STANDING                  0.2796531                -0.01946716
    ## 4       1 STANDING                  0.2791739                -0.02620065
    ## 5       1 STANDING                  0.2766288                -0.01656965
    ## 6       1 STANDING                  0.2771988                -0.01009785
    ##   timeBodyAccelerometermeanZ
    ## 1                 -0.1329051
    ## 2                 -0.1235202
    ## 3                 -0.1134617
    ## 4                 -0.1232826
    ## 5                 -0.1153619
    ## 6                 -0.1051373

``` r
tail(TotalData[1:5])
```

    ##       subject         activity timeBodyAccelerometermeanX
    ## 10294      24 WALKING_UPSTAIRS                  0.1922746
    ## 10295      24 WALKING_UPSTAIRS                  0.3101546
    ## 10296      24 WALKING_UPSTAIRS                  0.3633846
    ## 10297      24 WALKING_UPSTAIRS                  0.3499661
    ## 10298      24 WALKING_UPSTAIRS                  0.2375938
    ## 10299      24 WALKING_UPSTAIRS                  0.1536272
    ##       timeBodyAccelerometermeanY timeBodyAccelerometermeanZ
    ## 10294                -0.03364257                -0.10594911
    ## 10295                -0.05339125                -0.09910872
    ## 10296                -0.03921402                -0.10591509
    ## 10297                 0.03007744                -0.11578796
    ## 10298                 0.01846687                -0.09649893
    ## 10299                -0.01843651                -0.13701846

#### Using descriptive activity names to name the activities in the data set

  - Used the definition in the ‘activity\_labels.txt’ to add activity
    names to the categorical variable

<!-- end list -->

``` r
head(TotalData$activity,3)
```

    ## [1] "STANDING" "STANDING" "STANDING"

#### Appropriately labeling the data set with descriptive variable names

  - There were a few abbreviations that were not clear by just looking
    at them.
  - Used the function **gsub** for these activities  
  - Made the following changes to the names in the file

*Renaming* - prefixes “t” to time  
\- prefix “f” to frequency  
\- ACC to Accelerometer  
\- Gyro to Gyroscope  
\- Mag to Magnitude  
\- BodyBody to body  
*Removed* parenthesis

–Code names(TotalData)\<-gsub(‘\\-|\\(|\\)’, ’’, names(TotalData))

``` r
names(TotalData[1:10])
```

    ##  [1] "subject"                       "activity"                     
    ##  [3] "timeBodyAccelerometermeanX"    "timeBodyAccelerometermeanY"   
    ##  [5] "timeBodyAccelerometermeanZ"    "timeBodyAccelerometerstdX"    
    ##  [7] "timeBodyAccelerometerstdY"     "timeBodyAccelerometerstdZ"    
    ##  [9] "timeGravityAccelerometermeanX" "timeGravityAccelerometermeanY"

#### Creating a second, independent tidy data set with the average of each variable for each activity and each subject

  - Used the library **reshape**
  - Created *TotalDataLong* a long data file to create rows for each
    pair of subjects and activities - Used **melt** function for
    reshaping the data
  - Got the mean values for each activity-subject combination - Used
    **dcast** function for this procedure
  - Exported the newly created data as ‘tidydataset.txt’ - Used
    **write.table** function

The tidy dataset has 180 rows and 68 columns The column names are
printed below

``` r
str(DataNewMean)
```

    ## 'data.frame':    180 obs. of  68 variables:
    ##  $ subject                                    : int  1 1 1 1 1 1 2 2 2 2 ...
    ##  $ activity                                   : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
    ##  $ timeBodyAccelerometermeanX                 : num  0.222 0.261 0.279 0.277 0.289 ...
    ##  $ timeBodyAccelerometermeanY                 : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
    ##  $ timeBodyAccelerometermeanZ                 : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
    ##  $ timeBodyAccelerometerstdX                  : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
    ##  $ timeBodyAccelerometerstdY                  : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
    ##  $ timeBodyAccelerometerstdZ                  : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
    ##  $ timeGravityAccelerometermeanX              : num  -0.249 0.832 0.943 0.935 0.932 ...
    ##  $ timeGravityAccelerometermeanY              : num  0.706 0.204 -0.273 -0.282 -0.267 ...
    ##  $ timeGravityAccelerometermeanZ              : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
    ##  $ timeGravityAccelerometerstdX               : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
    ##  $ timeGravityAccelerometerstdY               : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
    ##  $ timeGravityAccelerometerstdZ               : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
    ##  $ timeBodyAccelerometerJerkmeanX             : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
    ##  $ timeBodyAccelerometerJerkmeanY             : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
    ##  $ timeBodyAccelerometerJerkmeanZ             : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
    ##  $ timeBodyAccelerometerJerkstdX              : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
    ##  $ timeBodyAccelerometerJerkstdY              : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
    ##  $ timeBodyAccelerometerJerkstdZ              : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
    ##  $ timeBodyGyroscopemeanX                     : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
    ##  $ timeBodyGyroscopemeanY                     : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
    ##  $ timeBodyGyroscopemeanZ                     : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
    ##  $ timeBodyGyroscopestdX                      : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
    ##  $ timeBodyGyroscopestdY                      : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
    ##  $ timeBodyGyroscopestdZ                      : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
    ##  $ timeBodyGyroscopeJerkmeanX                 : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
    ##  $ timeBodyGyroscopeJerkmeanY                 : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
    ##  $ timeBodyGyroscopeJerkmeanZ                 : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
    ##  $ timeBodyGyroscopeJerkstdX                  : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
    ##  $ timeBodyGyroscopeJerkstdY                  : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
    ##  $ timeBodyGyroscopeJerkstdZ                  : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
    ##  $ timeBodyAccelerometerMagnitudemean         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
    ##  $ timeBodyAccelerometerMagnitudestd          : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
    ##  $ timeGravityAccelerometerMagnitudemean      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
    ##  $ timeGravityAccelerometerMagnitudestd       : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
    ##  $ timeBodyAccelerometerJerkMagnitudemean     : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
    ##  $ timeBodyAccelerometerJerkMagnitudestd      : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
    ##  $ timeBodyGyroscopeMagnitudemean             : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
    ##  $ timeBodyGyroscopeMagnitudestd              : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
    ##  $ timeBodyGyroscopeJerkMagnitudemean         : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
    ##  $ timeBodyGyroscopeJerkMagnitudestd          : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
    ##  $ frequencyBodyAccelerometermeanX            : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
    ##  $ frequencyBodyAccelerometermeanY            : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
    ##  $ frequencyBodyAccelerometermeanZ            : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
    ##  $ frequencyBodyAccelerometerstdX             : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
    ##  $ frequencyBodyAccelerometerstdY             : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
    ##  $ frequencyBodyAccelerometerstdZ             : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
    ##  $ frequencyBodyAccelerometerJerkmeanX        : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
    ##  $ frequencyBodyAccelerometerJerkmeanY        : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
    ##  $ frequencyBodyAccelerometerJerkmeanZ        : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
    ##  $ frequencyBodyAccelerometerJerkstdX         : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
    ##  $ frequencyBodyAccelerometerJerkstdY         : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
    ##  $ frequencyBodyAccelerometerJerkstdZ         : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
    ##  $ frequencyBodyGyroscopemeanX                : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
    ##  $ frequencyBodyGyroscopemeanY                : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
    ##  $ frequencyBodyGyroscopemeanZ                : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
    ##  $ frequencyBodyGyroscopestdX                 : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
    ##  $ frequencyBodyGyroscopestdY                 : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
    ##  $ frequencyBodyGyroscopestdZ                 : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
    ##  $ frequencyBodyAccelerometerMagnitudemean    : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
    ##  $ frequencyBodyAccelerometerMagnitudestd     : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
    ##  $ frequencyBodyAccelerometerJerkMagnitudemean: num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
    ##  $ frequencyBodyAccelerometerJerkMagnitudestd : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
    ##  $ frequencyBodyGyroscopeMagnitudemean        : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
    ##  $ frequencyBodyGyroscopeMagnitudestd         : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
    ##  $ frequencyBodyGyroscopeJerkMagnitudemean    : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
    ##  $ frequencyBodyGyroscopeJerkMagnitudestd     : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
