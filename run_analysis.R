## function to read a raw data, and get a tidy data
## the data can be found ont https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## the steps are as follows:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

runAnalysis <- function() {
 # read feature names and activity names
  features <- read.table("features.txt")
  featuresName <- features[, 2]
  activityLabels <- read.table("activity_labels.txt")
  activityName <- activityLabels[, 2]
  
  # read train, test values and labels
  trainValue <- read.table("train/X_train.txt")
  trainLabel <- read.table("train/y_train.txt")
  testValue <- read.table("test/X_test.txt")
  testLabel <- read.table("test/y_test.txt")
  
  # make names of value to feature names
  names(trainValue) <- featuresName
  names(testValue) <- featuresName
  
  # filter mean and std feature
  target <- grep("mean|std\\(\\)", featuresName)

  # Uses descriptive activity names to name the activities in the data set
  trainLabels <- factor(trainLabel[, 1], labels = activityName)
  testLabels <- factor(testLabel[, 1], labels = activityName)
  
  # get train and test data based on target feature
  trainData <- cbind(trainLabel, trainValue[, target])
  testData <- cbind(testLable, testValue[, target])
  
  names(trainData)[1] <- "activity"
  names(testData)[1] <- "activity"
  
  tidyData <- rbind(trainData, testData)
  
  write.table(tidyData, "tidyData.txt")
}


