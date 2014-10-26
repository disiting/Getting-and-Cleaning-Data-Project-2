## step 1
# merge the training and the test sets to create one data set
test.labels <- read.table("test/y_test.txt", col.names="label")
test.subjects <- read.table("test/subject_test.txt", col.names="subject")
test.data <- read.table("test/X_test.txt")
train.labels <- read.table("train/y_train.txt", col.names="label")
train.subjects <- read.table("train/subject_train.txt", col.names="subject")
train.data <- read.table("train/X_train.txt")
dataset <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))

## step 2
# extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]
data.mean.std <- dataset[, c(1, 2, features.mean.std$V1+2)]

## step 3
# use descriptive activity names to name the activities in the data set
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# replace labels in data with label names
data.mean.std$label <- labels[data.mean.std$label, 2]

## step 4
# appropriately label the data set with descriptive variable names.
good.colnames <- c("subject", "label", features.mean.std$V2)
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
colnames(data.mean.std) <- good.colnames

## step 5
# from the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
                       by=list(subject = data.mean.std$subject, 
                               label = data.mean.std$label),
                       mean)

write.table(format(aggr.data, scientific=T), "tidydataset.txt",
            row.names=F, col.names=F, quote=2)