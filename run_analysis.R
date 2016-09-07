
create_tidy_ds <- function(){
    
    #Ensure required libraries are loaded
    library(data.table)
    library(dplyr)
    library(dtplyr)
    library(plyr)
    
    #Check if folder exists to download the data, else create folder
    if(!file.exists("./data")) {dir.create("./data")}
    
    #Download the file required for the project 
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "./data/UCI_HAR_Dataset.zip")
    
    #Unzip the files
    unzip(zipfile="./data/UCI_HAR_Dataset.zip",exdir="./data")
    
    #Display the file names unzipped
    unzip(zipfile="./data/UCI_HAR_Dataset.zip", list=TRUE)

    
    #### Read the files into datasets ####
    
    #Read the variable names from file
    features <- read.table("./data/UCI HAR Dataset/features.txt")
    
    #Read the activity descriptions data
    act_lbl <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

    #Read the train datasets
    train_ds <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
    acttrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
    subtrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
    
    #Read the test datasets
    test_ds <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
    acttest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
    subtest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
    

# 1. Merges the training and the test sets to create one data set.
    
    #Merge the 3 datasets of train and test
    datamerged <- rbind(train_ds,test_ds)
    actmerged <- rbind(acttrain, acttest)
    submerged <- rbind(subtrain,subtest)
    
    #Rename the varible names
    colnames(datamerged) <- features$V2
    names(actmerged)[1] <- "Activity"
    names(submerged)[1] <- "Subject"
    
    #Merge into a single dataset
    ds_single <- cbind(actmerged, submerged, datamerged)

    
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    
    ms_extract <- ds_single[,grep("Activity|Subject|mean()|std()", names(ds_single), value = TRUE)]
    ms_extract <- ms_extract[,grep("meanFreq", names(ms_extract), value = TRUE, invert = TRUE)]

    
# 3. Uses descriptive activity names to name the activities in the data set
    
    #Rename the varible names
    names(act_lbl)[1] <- "Activity"
    names(act_lbl)[2] <- "ActivityName"
    
    #Add the activity name to the data set
    act_named <- right_join(act_lbl, ms_extract, by="Activity")

    
# 4. Appropriately labels the data set with descriptive variable names.
    
    names(act_named) <- gsub("[(]|[)]","",names(act_named))
    names(act_named) <- gsub("^f","Frequency",names(act_named))
    names(act_named) <- gsub("^t","Time",names(act_named))
    names(act_named) <- gsub("mean","Mean",names(act_named))
    names(act_named) <- gsub("std","StandardDeviation",names(act_named))
    names(act_named) <- gsub("Acc","Accelerometer",names(act_named))
    names(act_named) <- gsub("Gyro","Gyroscope",names(act_named))
    names(act_named) <- gsub("Mag","Magnitude",names(act_named))
    names(act_named) <- gsub("BodyBody","Body",names(act_named))
    names(act_named) <- gsub("-","_",names(act_named))

# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

    tidy_ds <<- ddply(act_named, .(Activity, ActivityName, Subject), numcolwise(mean,na.rm = TRUE))
    write.table(tidy_ds, "./tidy_data.txt", row.name=FALSE)
    return(tidy_ds)
    
}

