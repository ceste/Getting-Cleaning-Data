folder <- 'UCI HAR Dataset'
path <- paste(getwd(),'R',folder,'/',sep = '/')

activity_labels <- paste(path,'activity_labels.txt',sep='')
activity_labels <- read.table(activity_labels)[,2]

features <- paste(path,'features.txt',sep='')
features <- read.table(features)[,2]

extract_features <- grepl("mean|std", features)

folder <- 'UCI HAR Dataset/test'
path <- paste(getwd(),'R',folder,'/',sep = '/')

X_test <- paste(path,'X_test.txt',sep='')
X_test <- read.table(X_test)

y_test <- paste(path,'y_test.txt',sep='')
y_test <- read.table(y_test)

subject_test <- paste(path,'subject_test.txt',sep='')
subject_test <- read.table(subject_test)

names(X_test) <- features

X_test <- X_test[,extract_features]

y_test[,2] = activity_labels[y_test[,1]]
names(y_test) <- c('Activity ID','Activity Name')

names(subject_test) = "Subject"

install.packages("data.table")
library(data.table)

data <- cbind(as.data.table(subject_test), y_test, X_test)

folder <- 'UCI HAR Dataset/train'

path <- paste(getwd(),'R',folder,'/',sep = '/')

X_train <- paste(path,'X_train.txt',sep='')
X_train <- read.table(X_train)

y_train <- paste(path,'y_train.txt',sep='')
y_train <- read.table(y_train)

subject_train <- paste(path,'subject_train.txt',sep='')
subject_train <- read.table(subject_train)

names(X_train) <- features

X_train <- X_train[,extract_features]

y_train[,2] <- activity_labels[y_train[,1]]
names(y_train) = c("Activity ID", "Activity Name")
names(subject_train) = "Subject"

data2 <- cbind(as.data.table(subject_train), y_train, X_train)

bind_data = rbind(data, data2)

id_labels   = c("Subject", "Activity ID", "Activity Name")
data_labels = setdiff(colnames(bind_data), id_labels)

install.packages("reshape2")
library('reshape2')

join_data      = melt(bind_data, id = id_labels, measure.vars = data_labels)

folder <- 'UCI HAR Dataset'
path <- paste(getwd(),'R',folder,'/',sep = '/')
path <- paste(path,'data.txt',sep='')

write.table(join_data, file = path)