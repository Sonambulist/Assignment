install.packages("dplyr")
library(dplyr)
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
varnam<-read.table("./UCI HAR Dataset/features.txt")
actlab<-read.table("./UCI HAR Dataset/activity_labels.txt")
X<-rbind(X_train, X_test)
Y<-rbind(Y_train, Y_test)
Subject<-rbind(subject_train,subject_test)
varr<-varnam[grep("mean\\(\\)|std\\(\\)",varnam[,2]),]
X<-X[,varr[,1]]
colnames(Y)<-"activity"
Y$activitylabel<-factor(Y$activity,labels=as.character(actlab[,2]))
actlab<-Y[,-1]
colnames(X)<-varnam[varr[,1],2]
colnames(Subject)<-"subject"
res<-cbind(X,actlab,Subject)
resavg<-res %>% group_by(actlab,subject) %>% summarize_each(funs(mean))
write.table(resavg,file="./UCI HAR Dataset/tidydata.txt",row.names = FALSE,col.names = TRUE)