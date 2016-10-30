#Getting the Data
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("Dataset.zip")){
  download.file(file_url,method = "curl",destfile = "Dataset.zip")
  downloadDate<- date()
}

#unzipping data into data set folder
unzip(zipfile = "Dataset.zip",exdir = "./dataset")

#listing all the files in the dataset
print(list.files("./dataset/",recursive = TRUE))

#loading Training Tables
x_train <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")

#loading Testing Tables
x_train <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")

#Reading Testing Tables
x_test <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")

#loading Features txt file
features <- read.table("./dataset/UCI HAR Dataset/features.txt")

#loading Activity text file
activity_labels <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels)  = c('activity_id','activity_type');

#question 4
#Appropriately labels the data set with descriptive variable names.
#Assigning column names to training Variables
colnames(subject_train) <- "subject_id"
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity_id"

#Binding all the columns for train dataset
f_train <- cbind(y_train,subject_train,x_train)

#question 4
#Appropriately labels the data set with descriptive variable names.
#Assigning column names to testing Variables
colnames(subject_test) <- "subject_id"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activity_id"

#Binding all the columns for test dataset
f_test <- cbind(y_test,subject_test,x_test)

#question 1
#Merging Test and Train set for final Data
f_data <- rbind(f_train,f_test)
str(f_data)

#Getting column names from the f_data
col_name <- colnames(f_data)
 
#question 3
 
#Extracts only the measurements on the mean and standard deviation for each measurement
f_cols <- (grepl("activity_id" , col_name) | grepl("subject_id" , col_name) |  grepl("mean.." , col_name) | grepl("std.." , col_name))
f_data <- f_data[,f_cols == TRUE]

str(f_data)

# Question 4

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#creating a new tidy dataset
f_data <- aggregate(. ~subject_id + activity_id, f_data, mean)

# Question 3

#Uses descriptive activity names to name the activities in the data set
f_data <- merge(f_data,activity_labels,by='activity_id',all.x=TRUE)

#Writing Tidy Data
write.table(f_data, './tidy_data.txt',row.names=TRUE,sep='\t')


