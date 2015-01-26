# Coursera - Getting and Cleaning Data - Course Project - CodeBook

Thomas LUCAS

### File Description

This file describes the variables, the data, and any transformations or work that is performed in the script *run_analysis.R* to clean up the data.

### Source Data

A full description of the data used in this project can be found on [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Important details explaining what data are used in our dataset and also how they are depicted can be found in the different text files in from the sources and especially in **features_info.txt** and **README.txt**.

### Attribute Information

Just as a reminder, for each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

### Code Details

The code of the file *run_analysis.R* is organized in two parts:

- The first one corresponding to the different functions use to perform the analysis
- The second one which is the MAIN function and calls all the previous functions

The MAIN starts by setting the working directory to be able to access the different source files, and by load some "global variables" that will be use several times after:
- *features*: which is a table imported from features.txt
- *activityType*: which is a table imported from activity_labels.txt

Explicit column names for activity type data frame are also setted.

Then, the MAIN follows the order of the different questions in the project:

- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##### Step One:

In this step, we read the different .txt files, create the associated dataframes using the *getData* function. Then, we specified explicit column names for the produced dataframes using the *setExplicitColumnNames* function and finally we merge the training and the test sets using the *rbind* command.

##### Step Two:

In this step we extract only the measurements on the mean and standard deviation for each measurement using the *extractMeanAndStdMeasurements*.

This function creates of a vector of boolean to check if the different columns are mean or standard deviation columns. To do this the function looks at each column name using a regular expression and the *grepl* function. We also want to keep 'subjectId' and 'activityId' columns.

##### Step Three:

In this step, we call the *setDescriptiveActivityNames* to use descriptive activity names to name the activities in the data set and also to reorganize the dataframe in the following order: 'activityId' | 'activityType' | 'subjectId' | ... to improve readability. To summarize, the function merges the dataset and the activityType table.

##### Step Four:

This step is used to set appropriate labels to the data set with descriptive variable names. The following choices have been made: 

- Replace "-mean" by "Mean"
- Replace "-std" by "Std"
- Remove the parenthesis
- Replace "BodyBody" by "Body"
- Replace "^(f)" by "freq"
- Replace "^(t)" by "time"
- Replace "Mag" by "Magnitude"

Everything is done in the *setAppropriateLabels* function.

##### Step Five:

Using the tidy dataset of the previous step, a new, independent tidy data set with the average of each variable for each activity and each subject is created. To do this, the function *createTidyDataSet* is called. This function starts by loading the *plyr* package to be able to easily aggregate data. Before performing the aggregation, the activity type column is removed (this column cannot be aggreagated in our case).

After this aggregation, we use the function setDescriptiveActivityNames (cf. step three) to add good names and put the activity type column back in the final tidy dataset.

The last line of code in the file, enables to export the tidy dataset as a text file in the working directory using the function *write.table*.

### Additional Information

You can find more comments and details about functions and code logic in the file *run_analysis.R* itself.
