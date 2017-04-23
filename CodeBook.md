CodeBook for Course Project of Programming with R

Raw Data

The raw data for this project is accelerometer data collected from the Samsung Galaxy S smartphone.

Data file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
CodeBook: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


There are 3 types of files:

x: rows of feature measurements
y: the activity labels corresponding to each row of X. Encoded as numbers.
subject: the subjects on which each row of X was measured. Encoded as numbers.
In addition, to determine which features are required, we look at the list of features:

features.txt
The encoding from activity labels ids to descriptive names.

activity_labels.txt
Data load

The Y, S and X data is loaded from each of the training and test datasets, directly as their final type.
Only the columns of interest from X are loaded, that is the mean() and sd() columns. We determine the columns by examining the feature names (from features.txt) for patterns “-mean()” or “-std()”.
All of these files are fixed format text files.

Transformation

1.Get list of files
2. Read Activity Files
3. Read Subject Files
4. Read Features Files
5. Rbind the training files and test files
6. Assign names to variables in each file 
7. Create Data Frame "Data"
8. Subset name of features by mean and 
9. Subset Data by selected names "subject" 
10. Read activity names from activity_labels
11. Assign descriptive variable names 
12.Create tidy data set and output
