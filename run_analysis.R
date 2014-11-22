#1.Merges the training and the test sets to create one data set.
setwd("/Users/lucatang/Desktop/Coursera/UCI HAR Dataset")
features<-read.table("features.txt",header=FALSE)
activitylable<-read.table("activity_labels.txt",header=FALSE)
subjecttrain<-read.table("train/subject_train.txt",header=FALSE)
xtrain<-read.table("train/X_train.txt",header=FALSE)
ytrain<-read.table("train/y_train.txt",header=FALSE)
subjecttest<-read.table("test/subject_test.txt",header=FALSE)
xtest<-read.table("test/X_test.txt",header=FALSE)
ytest<-read.table("test/y_test.txt",header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])
colnames(activitylable)<-c("activity_id","activity_Type")
colnames(subjecttrain)<-"subject_id"
colnames(ytrain)<-"activity_id"
colnames(xtrain)<-features[, 2]
colnames(subjecttest)<-"subject_id"
colnames(ytest)<-"activity_id"
colnames(xtest)<-features[ ,2]
train<-cbind(ytrain,subjecttrain,xtrain)
test<-cbind(ytest,subjecttest,xtest)
data<-rbind(train,test)
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
colnames<-colnames(data)
select<-(grepl("activity..",colnames)|grepl("subject..",colnames)|grepl("Mean",colnames)|grepl("Std",colnames))
selectdata<-data[select==TRUE]
#3.Uses descriptive activity names to name the activities in the data set & 4.Appropriately labels the data set with descriptive variable names. 
selectdata<-merge(selectdata,activitylable,by="activity_id",all.x=TRUE)
selectdata1<-subset(selectdata,select=-c(activity_id))
finaldata<-selectdata1[,c(1,88,2:87)]
#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(selectdata2,"tidy.txt",row.name=FALSE)
