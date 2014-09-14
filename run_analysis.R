# 1) merge the training and the test set

# read test data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
data_test <- cbind(X_test,y_test,subj_test)
remove(X_test,y_test,subj_test)

# read training data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
data_train <- cbind(X_train,y_train,subj_train)
remove(X_train,y_train,subj_train)

# build full dataset
data <- rbind(data_test,data_train)
remove(data_test,data_train)

# 2) extract relevant measurements

# load feature names
features <- read.table("UCI HAR Dataset/features.txt",
                       col.names=c("col","name"),stringsAsFactors=FALSE)

# reduce to features with "mean" or "std" in name
cols <- subset(features, grepl("mean",name) | grepl("std",name))

# add the two columns we've added before to the list
y_col <- data.frame(col=562,name="activity",stringsAsFactors=FALSE)
subj_col <- data.frame(col=563,name="subject",stringsAsFactors=FALSE)
cols <- rbind(cols, y_col, subj_col)

# reduce the dataset to the relevant columns
data <- data[,cols$col]

# 4) set column/variable labels
names(data) <- cols$name

# 3) set activity labels

# load labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# replace numeric value with label factors
data$activity <- activity_labels[data$activity,2]

# 5) create second dataset
library("dplyr")
library("tidyr")

# create a dataset with variable per row
tmp <- gather(data,variable,value,-c(activity,subject))
# calculate mean per variable, grouped by activity and subject
data2 <- summarize(group_by(tmp,activity,subject,variable),mean=mean(value))

# store and show output
write.table(data2,"dataset_step5.txt",row.name=FALSE)
head(data2)