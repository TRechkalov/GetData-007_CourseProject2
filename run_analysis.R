setwd("C:\\workspaces\\r-workspaces\\getdata-007_courseProject2")

# downloading and unzipping sources
if(!file.exists("smartphonesHumanActivity.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="smartphonesHumanActivity.zip")
  unzip("smartphonesHumanActivity.zip")
}

# reading base data
activityLabelsFile <- "UCI HAR Dataset/activity_labels.txt"
activities <- read.table(activityLabelsFile, sep=" ")

str(activities)
colnames(activities) <- c("id","name")
activities

features <- read.table("UCI HAR Dataset/features.txt", sep=" ")
colnames(features) <- c("id","name")
features

# reading test data
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", sep=" ")
tail(testSubjects)
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt", sep=" ")

testLabels <- activities$name[testLabels$V1]

testData <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(testData) <- features$name
head(testData, 3)

testDF <- data.frame(subjectId = testSubjects, label=testLabels, testData)

# reading train data
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", sep=" ")
tail(trainSubjects)
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt", sep=" ")

trainLabels <- activities$name[trainLabels$V1]

length(trainLabels)

trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(trainData) <- features$name
head(trainData, 3)

trainDF <- data.frame(subjectId = trainSubjects, label=trainLabels, trainData)

# merge datasets
dataset <- rbind(testDF, trainDF)