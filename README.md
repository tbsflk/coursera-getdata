Course Project - Getting and Cleaning Data
================

The script run_analysis.R loads the dataset in folder "UCI HAR Dataset" and transforms it as described in the course project instructions of the "Getting and cleaning data" course on Coursera (https://class.coursera.org/getdata-007).

### Step 1
Data for X, y and subject is loaded from folders test and train and combined into one data frame.

### Step 2
Names of the variables are loaded from features.txt and filtered to a list of variables with names containing "mean" or "std". Names for the y and subject columns are added to the list and the data frame is reduced to the columns in that list.

### Step 3 (4 in the instructions)
Columns of the data frame are named according to the list constructed in step 2.

### Step 4 (3 in the instructions)
Labels for activities are loaded and the values in the respective column are replaced by the activity label.

The data frame created in the last steps can be found in object data.

### Step 5
Using libraries dplyr and tidyr, the data is transformed into a new data frame with one line per value, categorized by activity, subject and variable name. This data frame is then grouped by activity and subject and the value's mean for each group is calculated. The result is stored in a txt-file.

After running the script, the final data frame is available in object data2.