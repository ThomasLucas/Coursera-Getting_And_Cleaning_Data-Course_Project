# Coursera - Getting And Cleaning Data - Course Project - README
Thomas LUCAS

Repo for the Coursera Getting and Cleaning Data Course Project

# Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
A full description of the data used in this project can be found at: [https://class.coursera.org/getdata-010/human_grading](https://class.coursera.org/getdata-010/human_grading)

# Getting Started
The first step to be able to work on this project is to download the sources. It can be done here: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Once you have obtained and unzipped the source files, to be able to run *run_analysis.R*, you will have to specify your working directory (the location of the source files on your machine) in this file on line **92**.

# Run the program
Once the first part is done, to run the code, you just need to open R or RStudio and write "source('run_analysis.R')" (without the ") in the console. The program takes around 1 - 2 minutes to run. The code will transform the raw data following these different steps:
* 1. Merges the training and the test sets to create one data set. 
* 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3. Uses descriptive activity names to name the activities in the data set 
* 4. Appropriately labels the data set with descriptive activity names. 
* 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

At the end a new text file called "tidyDataSet.txt" will be produced in your working directory.

**NB** for the last step, the external package *plyr* is necessary. You will have to install it using *install.packages* if the step *library(plyr)* fails on line 77.

# Additional Information

You can find additional information about the variables, data and transformations in the CodeBook.MD file.

