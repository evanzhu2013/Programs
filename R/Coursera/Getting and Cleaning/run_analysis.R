# Read datasets
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
X_train<- read.table('./UCI HAR Dataset/train/X_train.txt')
Y_train<- read.table('./UCI HAR Dataset/train/Y_train.txt')
subject_test <- scan('./UCI HAR Dataset/test/subject_test.txt')
X_test<- read.table('./UCI HAR Dataset/test/X_test.txt')
Y_test<- read.table('./UCI HAR Dataset/test/Y_test.txt')
features <- read.table('./UCI HAR Dataset/features.txt')
activity_labels=read.table('./UCI HAR Dataset/activity_labels.txt')

# Rename X_train
names(X_train)=as.character(features[[2]])
names(X_test)=as.character(features[[2]])

# Subset columns
pattern<-grep("(mean|std)",names(X_train),perl=T)
X_train <- X_train[,pattern]

pattern<-grep("(mean|std)",names(X_test),perl=T)
X_test <- X_test[,pattern]

# Combine columns and rename variables

train=cbind(subject_train,X_train,Y_train)
test=cbind(subject_test,X_test,Y_test)
names(train)[1] <- 'subject'
names(test)[1] <- 'subject'

datasets=rbind(train,test)
names(datasets)[81]='Activity'

# Rename values of Activity

datasets$Activity=factor(datasets$Activity,ordered = F,levels=c(1,2,3,4,5,6),labels=c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING'))


# Melt and cast the datasets and calculate

library(reshape)
tidydata=melt(datasets,id.vars = c('subject','Activity'))
tidy=cast(tidydata,subject+Activity~variable,mean)
View(tidy)

write.table(tidy,'tidy.txt',row.names=FALSE)





