## Getting and Cleaning Data Course Project.

### Overview
This repo contains the script, code book and tidy date set for week 4 project of the Getting and Cleaning Data Course.

### Data Source and Recognition
Human Activity Recognition Using Smartphones Dataset (Version 1.0)</br>
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.</br>
Smartlab - Non Linear Complex Systems Laboratory</br>
DITEN - Università degli Studi di Genova.</br>
Via Opera Pia 11A, I-16145, Genoa, Italy.</br>
activityrecognition@smartlab.ws</br>
www.smartlab.ws</br>

### Input files used
- 'X_train.txt':  Training set.
- 'y_train.txt':  Training labels.
- 'X_test.txt' :  Test set.
- 'y_test.txt' :  Test labels.
- 'features.txt': List of all features.
- 'subject_train.txt': Subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'subject_test.txt': Subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'activity_labels.txt': Links the class labels with their activity name.

### Output files produced
- 'tidy_data.txt': Dataset with all the functions applied

### Script file
- 'run_analysis.R': Contains the full package of all the steps outlined below

### Steps executed
For this project there is a single script file containing the following functions.</br></br>
1. Download and unzip the data files</br>
    Check if folder exists to download the data, else create folder "./data"</br>
	Download the zip file</br>
	Unzip the files in the "./data" directory</br></br>
2. Merge the training and the test sets to create one data set.</br>
    Read training data sets</br>
	Read test data sets</br>
	Merge the train and test data sets</br></br>
3. Extracts only the measurements on the mean and standard deviation for each measurement.</br>
    Create a new dataset with a subset of variables containing mean and standard deviation data</br></br>
4. Uses descriptive activity names to name the activities in the data set</br>
    Read the activity descriptions data from file "activity_labels.txt"</br>
	Add the activity name to each measurement</br></br>
5. Appropriately labels the data set with descriptive variable names.</br>
    Perform a number of name clean-ups in preparetion of the final tidy dataset</br></br>
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</br>
    Calculate the measurement means based on the group by of activity and subject</br>
	Saved the tidy data set to an output file "./tidy_data.txt"</br>

### Function to call to run the script
These function steps are called by the single command to present the tidy dataset.</br>
*create_tidy_ds()*

### R package requirements
The following R packages need to be installed in order to use the script:</br>
*install.packages("data.table")*</br>
*install.packages("dplyr")*</br>
*install.packages("plyr")*</br>
