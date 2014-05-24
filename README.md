# run_analysis.R
========================================================
## Overview
An R script for processing the *"Human Activity Recognition Using Smartphones"* data set found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

This script satisfies the requirements of the "Getting and Cleaning Data" project offered by Johns Hopkins University through Coursera.

## Description
run_analysis.R performs the following:

1. Downloads the dataset and unips it to ./data

2. Reads the dataset into R

3. Merges the training and the test sets to create one data set.

4. Extracts only the measurements on the mean (`mean`) and standard deviation (`std`) for each measurement.

  i. Variables measuring `meanfreq()` were omitted as it was determined these variables     fell outside the scope of the project requirements.

5. Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names. 

  i. Activity names were translated from their numerical value to their categorical values as per activity_labels.txt found in the dataset
  
6. Alters variable names for clarity and in accordance with [Google's R Style Guide](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml)
  
  i. Brackets were removed and elements of each variable were separated with dots for clarity.  A complete breakdown of variable names can be found in features_info.txt

7. Creates a second, independent tidy dataset with the average of each variable for each activity and each subject. 

8. Writes the dataset to file "./data/samsung_data_tidy.csv"
