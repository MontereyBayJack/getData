---
output: html_document

---

The R script run_analysis.R does the following:

1. Opens the zipped file named "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. Loads the relevant training, test and data and other files.
3. Merges the data files into a single data table.
4. Extracts only the measurements on the mean and standard deviation for each measurement. 
5. uses descriptive activity names from the activity file to name the activities in the data set.
6. Labels the measurements in the data set with descriptive variable names.
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
8. Writes the tidy data set to the file named "tidy_data.txt".

In order to run this R script, the zip file must be installed in the current directory.

