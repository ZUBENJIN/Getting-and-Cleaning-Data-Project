#load the package
library(dplyr)

#merge the train set
setwd("F:/1/Coursera/Getting and Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")
a<-list.files(pattern=".*.txt")
library(plyr)
train_Data<-do.call(cbind,lapply(a, read.table))

#merge the test set
setwd("F:/1/Coursera/Getting and Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")
b<-list.files(pattern=".*.txt")
test_Data<-do.call(cbind,lapply(b, read.table))

#create a merged data set
dataset<-rbind(train_Data,test_Data)

#Extract only the measurements on the mean and standard deviation for each measurement.
apply(train_Data,1,mean)
apply(train_Data,1,sd)
apply(test_Data,1,mean)
apply(test_Data,1,sd)


#Appropriately labels the data set with descriptive variable names. 
dataset$V1[dataset$V1 == 1]<-"WALKING"
dataset$V1[dataset$V1 == 2]<-"WALKING_UPSTAIRS"
dataset$V1[dataset$V1 == 3]<-"WALKING_DOWNSTAIRS"
dataset$V1[dataset$V1 == 4]<-"SITTING"
dataset$V1[dataset$V1 == 5]<-"STANDING"
dataset$V1[dataset$V1 == 6]<-"LAYING"

#put appropriate names to variables
features<-read.table("F:/1/Coursera/Getting and Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
feature<-rbind(features[,c(1,2)],matrix(c(562,"activity",563,"subject"),nrow=2,byrow=TRUE))
colnames(dataset)<-feature[,2]

#create a second, independent tidy data set with the average of each variable for each activity and each subject.
act_mean<-aggregate(dataset$activity,dataset,mean)
sub_mean<-aggregate(act_mean$subject,act_mean,mean)
new_table<-sub_mean[,c(564,565)]

#create a new tidy data table
write.table(new_table,file="F:/1/Coursera/Getting and Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/new_table.txt", row.name=F,quote=F)

