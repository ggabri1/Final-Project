README - Final Project - UCIHAR Dataset
================

## Definition

This is a final course project for the Getting and Cleaning Data Course
in Coursera.

This file contains information on the files in the repo and explains how
all of the scripts work and how they are connected.

## Data Source

The data for the project is available here
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

And a full description is available at the site where the data was
obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## Files in Repo

The following files are available in Repo that help run the analysis;  
run\_analysis.R \#\# The code file that is used to perform the
analysis;  
README.md \#\# The current file describing how the script works and the
code book describing the variables;  
Codebook.md \#\# A code book that describes the variables, the data, and
any transformations or work that you performed to clean up the data

## run.analysis.R

The script is used for the following functions:

1.  Download, unzip, and import the data into R dataframe.
2.  Merges the training and the test sets to create one data set.
3.  Extracts only the measurements on the mean and standard deviation
    for each measurement.
4.  Uses descriptive activity names to name the activities in the data
    set
5.  Appropriately labels the data set with descriptive variable names.
6.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

## The final data

A final tidy data is created according to the project specifications. It
has 180 observations and 68 variables. 2 variables define the subject
IDs and activities. The other 66 variables represent the mean and
standard deviation for each measurement

More details on the variables and the script is provided in the CodeBook
in the same Repo.

## Replicate the Analysis

To rerun the code the current run\_analysis.R should be sourced from
working directory in R - source(run-analysis.R)
