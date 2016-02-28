###Loading neccesary packages
install.packages("dplyr")
library(dplyr)

install.packages("data.table")
library(data.table)

install.packages("tidyr")
library(tidyr)

install.packages("RCurl")
library(RCurl)


#downloading files
filePath <- "C:/Users/khandizwe/Desktop/Coursera/Getting and Cleaning Data/Week4"
setwd(filePath)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="libcurl")
#dataSet to working directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")



#Creating data tables

NfilePath <- "C:/Users/khandizwe/Desktop/Coursera/Getting and Cleaning Data/Week4/data/UCI HAR Dataset"
##Read subject then  activity then data files
dtSubjectTrain <- tbl_df(read.table(file.path(NfilePath, "train", "subject_train.txt")))
dtSubjectTest  <- tbl_df(read.table(file.path(NfilePath, "test" , "subject_test.txt" )))

### activity 
dtActivityTrain <- tbl_df(read.table(file.path(NfilePath, "train", "Y_train.txt")))
dtActivityTest  <- tbl_df(read.table(file.path(NfilePath, "test" , "Y_test.txt" )))

### data 
dtTrain <- tbl_df(read.table(file.path(NfilePath, "train", "X_train.txt" )))
dtTest  <- tbl_df(read.table(file.path(NfilePath, "test" , "X_test.txt" )))

?file.path()


#Manipulating the resulting data tables Including the aggregation
##all subjects  and data 
allSubject <- rbind(dtSubjectTrain, dtSubjectTest)
allActivity<- rbind(dtActivityTrain, dtActivityTest)

setnames(allSubject, "V1", "subject")
setnames(allActivity, "V1", "activityNum")

##combining the training and test files
alldataTable <- rbind(dtTrain, dtTest)

## renaming according to features 
dtFeatures <- tbl_df(read.table(file.path(NfilePath, "features.txt")))
setnames(dtFeatures, names(dtFeatures), c("featureNum", "featureName"))
colnames(alldataTable) <- dtFeatures$featureName

##Names for activities 
activityLl<- tbl_df(read.table(file.path(NfilePath, "activity_labels.txt")))
setnames(activityLl, names(activityLl), c("activityNum","activityName"))

## Merge 
allSubjAct<- cbind(allSubject, allActivity)
alldataTable <- cbind(allSubjAct, alldataTable)


##Extracting the mean and std from "features.txt"
FeatureSummary <- grep("mean\\(\\)|std\\(\\)",dtFeatures$featureName,value=TRUE) 

##  adding subject and activityNum

FeatureSummary <- union(c("subject","activityNum"), FeatureSummary)
alldataTable<- subset(alldataTable,select=FeatureSummary) 

##############################################################

##name of activity 
alldataTable <- merge(activityLl, alldataTable , by="activityNum", all.x=TRUE)
alldataTable$activityName <- as.character(alldataTable$activityName)

## sort by subject and Activity
alldataTable$activityName <- as.character(alldataTable$activityName)
allAggr<- aggregate(. ~ subject - activityName, data = alldataTable, mean) 
dataTable<- tbl_df(arrange(allAggr,subject,activityName))
################################################################


names(alldataTable)<-gsub("std()", "SD", names(alldataTable))
names(alldataTable)<-gsub("BodyBody", "Body", names(alldataTable))
names(alldataTable)<-gsub("mean()", "MEAN", names(alldataTable))
names(alldataTable)<-gsub("^f", "frequency", names(alldataTable))
names(alldataTable)<-gsub("^t", "time", names(alldataTable))
names(alldataTable)<-gsub("Gyro", "Gyroscope", names(alldataTable))
names(alldataTable)<-gsub("Acc", "Accelerometer", names(alldataTable))
names(alldataTable)<-gsub("Mag", "Magnitude", names(alldataTable))


##writing out CSV
##########################################################
write.table(alldataTable, "Finaldata.txt", row.name=FALSE)
