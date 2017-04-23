### Download data for project
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

### Get list of files
path_rf <- file.path("./data", "UCI HAR Dataset")
files<-list.files(path_rf, recursive = TRUE)
files
### Read Activity Files
Data_Activity_Test <- read.table(file.path(path_rf, "test", "Y_test.txt"), header = FALSE)
Data_Activity_Train <- read.table(file.path(path_rf, "train", "Y_train.txt"), header = FALSE)
## Read Subject Files
Data_Subject_Test <- read.table(file.path(path_rf, "test", "subject_test.txt"), header = FALSE)
Data_Subject_Train <- read.table(file.path(path_rf, "train", "subject_train.txt"), header = FALSE)
### Read Features Files
Data_Features_Test <- read.table(file.path(path_rf, "test", "X_test.txt"), header = FALSE)
Data_Features_Train <- read.table(file.path(path_rf, "train", "X_train.txt"), header = FALSE)
### Rbind the training files and test files
Data_Subject <- rbind(Data_Subject_Train, Data_Subject_Test)
Data_Activity <- rbind(Data_Activity_Train, Data_Activity_Test)
Data_Features <- rbind(Data_Features_Train, Data_Features_Test)
### Assign names to variables in each file combined file
names(Data_Subject) <- c("subject")
names(Data_Activity) <- c("activity")
Data_Features_Names <- read.table(file.path(path_rf, "features.txt"), header=FALSE)
names(Data_Features) <- Data_Features_Names$V2
### Create Data Frame "Data"
Data_Combined <- cbind(Data_Subject, Data_Activity)
Data <- cbind(Data_Features, Data_Combined)
### Subset name of features by mean and standard deviation measurment
subdata_Features_Names<-Data_Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Data_Features_Names$V2)]
### Subset Data by selected names "subject" and "activity"
selected_Names<-c(as.character(subdata_Features_Names), "subject", "activity" )
Data<-subset(Data,select=selected_Names)
### Read activity names from activity_labels.txt file
activity_Labels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
### Assign descriptive variable names 
names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
##
## Create tidy data set and output
library(plyr)
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file="tidydata.txt",row.name=FALSE)
##








