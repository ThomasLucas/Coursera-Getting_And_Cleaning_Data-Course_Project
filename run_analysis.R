##########################################################################################################

##                        Coursera Getting and Cleaning Data Course Project                             ##
##                                          Thomas LUCAS                                                ##
##                                           25/01/2015                                                 ##

##########################################################################################################

#### FUNCTIONS ####

# Gets data from .txt files using read.table
getData <- function(type){
  if(type != "test" & type != "train"){
    print("ERROR in getData function! Data type can only be 'test' or 'train'")
    return
  }
  
  # Reads the different .txt files
  subjectSet <- read.table(paste("./", type, "/subject_", type,".txt", sep = "")) # imports subject_{train|test}.txt
  xSet <- read.table(paste("./", type, "/x_", type, ".txt", sep = "")) # imports x_{train|test}.txt
  ySet <- read.table(paste("./", type, "/y_", type, ".txt", sep = ""))  # imports y_{train|test}.txt
  
  # Creates the final data set by merging subjectSet, ySet, and xSet
  dataSet <- cbind(subjectSet, ySet, xSet)
  return(dataSet)
}

# Sets explicit column names for the different datasets
setExplicitColumnNames <- function(features, dataSet){
  explicitColNames <- c("subjectId", "activityId", as.character(features[,2]))
  colnames(dataSet) <- explicitColNames
  return(dataSet)
}

# Extracts mean and standard deviation measurements from the original dataset
extractMeanAndStdMeasurements <- function(dataSet){
  # Original column names
  originalColNames <- colnames(dataSet)
  
  # Creation of a vector of boolean to check if the different columns are mean or standard deviation columns.
  # To do this I will look at each column name using a regular expression and the 'grepl' function.
  # We also want to keep 'subjectId' and 'activityId' columns.
  subsettingVector <- c(grepl("subjectId", originalColNames) | grepl("activityId", originalColNames) | grepl("mean+", originalColNames) | grepl("std+", originalColNames))
  
  # Returns the filtered dataset
  return(dataSet[subsettingVector])
}

# Uses of descriptive activity names to name the activities in the data set and reorganizes the dataframe in the following order: 'activityId' | 'activityType' | 'subjectId' | ...
setDescriptiveActivityNames <- function(dataSet, activityTypeTable){
  # Merge the data set with the activityType table to include descriptive activity names
  dataSet <- merge(dataSet, activityType, by='activityId', all.x = TRUE)
  
  # Reorganize the dataframe to improve readability
  dataSet <- dataSet[, c("activityId", "activityType", setdiff(names(dataSet), c("activityId", "activityType")))]
  
  return(dataSet)
}

# Appropriately labels the data set with descriptive variable names
setAppropriateLabels <- function(dataSet){
  names <- names(dataSet)
  names <- gsub("-mean", "Mean", names) # Replace "-mean" by "Mean"
  names <- gsub("-std", "StdDev", names) # Replace "-std" by "Std"
  names <- gsub("\\()", "", names) # Remove the parenthesis
  names <- gsub("BodyBody", "Body", names) # Replace "BodyBody" by "Body"
  names <- gsub("^(f)", "freq", names) # Replace "^(f)" by "freq"
  names <- gsub("^(t)", "time", names) # Replace "^(t)" by "time"
  names <- gsub("Mag", "Magnitude", names) # Replace "Mag" by "Magnitude"
  names(dataSet) <- names
  
  return(dataSet)
}

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
createTidyDataSet <- function(finalDataSet){
  # Loading of plyr package to easily aggregate data
  library(plyr)
  
  # The activity type column is removed
  tidySet <- finalDataSet[, -2]
  
  # Data aggregation
  tidySet <- aggregate(. ~subjectId + activityId, tidySet, mean)
  
  return(tidySet) 
}

#### MAIN ####

# Sets working directory 
# You need to edit this line if you want to be able to run the script
workingDirectory <- "/Users/Thomas/Desktop/Data_Science-Machine_Learning/Coursera/Getting_and_Cleaning_Data/Week3/Course_Project/UCI HAR Dataset"
setwd(workingDirectory)

# Global variables
features <- read.table("./features.txt"); # imports features.txt
activityType <- read.table("./activity_labels.txt"); # imports activity_labels.txt
colnames(activityType)  <- c('activityId','activityType'); # sets explicit column names for activity type data frame

# 1. Merges the training and the test sets to create one data set

# Reads the different .txt files
trainingSet <- getData("train") 
testSet <- getData("test") 
# Use explicit column names
trainingSet <- setExplicitColumnNames(features, trainingSet)
testSet <- setExplicitColumnNames(features, testSet)
# Merges the training and the test sets
finalDataSet = rbind(trainingSet, testSet)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
finalDataSet <- extractMeanAndStdMeasurements(finalDataSet)

# 3. Uses descriptive activity names to name the activities in the data set
finalDataSet <- setDescriptiveActivityNames(finalDataSet, activityType)

# 4. Appropriately labels the data set with descriptive variable names
finalDataSet <- setAppropriateLabels(finalDataSet)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidySet <- createTidyDataSet(finalDataSet)
tidySet <- setDescriptiveActivityNames(tidySet, activityTypeTable)
# Export the tidyData set 
write.table(tidySet, './tidyDataSet.txt', row.names=FALSE, sep='\t');