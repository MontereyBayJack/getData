# Project for Peer Assessment (getdata-013)
# by MontereyBayJack

# read the data files

yTest <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                         "UCI HAR Dataset/test/y_test.txt"))
# data collected from training and test subjects.
xTrain <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                          "UCI HAR Dataset/train/X_train.txt"))
xTest <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                         "UCI HAR Dataset/test/X_test.txt"))
# subject number for training and test data
subjectTrain <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                                "UCI HAR Dataset/train/subject_train.txt"))
subjectTest <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                                "UCI HAR Dataset/test/subject_test.txt"))
# feature names for the training and test data
featureNames <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                               "UCI HAR Dataset/features.txt"))
# activity type for training and test data.
yTrain <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                          "UCI HAR Dataset/train/y_train.txt"))
# list of activity types
activity <- read.table(unz("./getdata-projectfiles-UCI HAR Dataset.zip",
                           "UCI HAR Dataset/activity_labels.txt"))

# 1. Merge the trainng and test sets into one data set.

trainD <- cbind(subjectTrain, yTrain, xTrain)
testD <- cbind(subjectTest, yTest, xTest)
d <- rbind(trainD,testD)

# first colunn is now the subject number 
# second column is now the activty number
# remianing columns are the data 
# first rows are training data and last rows are test data

# 2. Extracting only measurements on the mean (mean) and 
#    standard deviation (std) for each measurement.

# columns 1 & 2 are the id and activity.
# columns 3 through the last have 'mean(' or 'std(' in the name
#   so exclude 'meanfreq(', etc.
cols <- 2+grep(".*mean\\(|std\\(.*",featureNames$V2)
cols <- c(1,2,cols) # id, activity, and target data columns
d <- d[,cols]

# 3. Use descriptive activity names to name the activities

# make activities factors and set factor names
d[,2] <- as.factor(d[,2])
levels(d[,2]) <- activity$V2

# 4. Appropriately label the data set with descriptive 
#    variable names. 

# make feature names lower case and remove '()'
# replace std with stdev, f with freq- & t with time-
cnames <- grep(".*mean\\(|std\\(.*",featureNames$V2,value=TRUE)
cnames <- c("id","activity", gsub("[()]","",tolower(cnames)))
cnames <- sub("-std","-stdev",cnames)
cnames <- sub("^(f)","freq-",cnames)
cnames <- sub("^(t)","time-",cnames)
library(data.table)
setnames(d,cnames)

# use to write the transformed data to a file if needed
# write.csv(d, "experiment-measured-data.csv",row.names=FALSE)

# 5. From the data set in step 4, creates a second, independent 
#    tidy data set with the average of each variable for each 
#    activity and each subject.

# melt the data table to make a tidy dataset
library(reshape2)
tidyD <- melt(d, id=1:2, measure=3:ncol(d), 
            variable.name="measure")

# write the tidy data to a file       
write.table(tidyD, "tidy-data.txt",row.names=FALSE)
