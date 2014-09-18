## [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
## Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
## Hardware-Friendly Support Vector Machine. International Workshop of Ambient
## Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 This dataset
## is distributed AS-IS and no responsibility implied or explicit can be
## addressed to the authors or their institutions for its use or misuse. Any
## commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca
## Oneto, Davide Anguita. November 2012.

#temp <- tempfile()
temp <- 'getdata-projectfiles-UCI HAR Dataset.zip'
#download_date <- date()
#download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', temp)
base_dir <- 'UCI HAR Dataset'
test_dir <- paste(base_dir, 'test', sep='/')
train_dir <- paste(base_dir, 'train', sep='/')

## List of all features
features <- read.csv(unz(temp, paste(base_dir, 'features.txt', sep='/')), header=F, sep=' ', na.strings='NA', stringsAsFactors=F)
features <- features$V2

## Links the class labels with their activity name
activities <- read.csv(unz(temp, paste(base_dir, 'activity_labels.txt', sep='/')), header=F, sep=' ', na.strings='NA', stringsAsFactors=F)
names(activities) <- c('id', 'activity')
activities$activity <- as.factor(activities$activity)

## Test subjects (2:24) & labels (1:6) & set
test_sbj <- read.csv(unz(temp, paste(test_dir, 'subject_test.txt', sep='/')), header=F, sep='', na.strings='NA', stringsAsFactors=F)
names(test_sbj) <- c('subject')
test_lbl_raw <- read.csv(unz(temp, paste(test_dir, 'y_test.txt', sep='/')), header=F, sep='', na.strings='NA', stringsAsFactors=F)
names(test_lbl_raw) <- c('activity_id')
test_lbl <- merge(test_lbl_raw, activities, by.x='activity_id', by.y='id', all=T)[-1]
test_set_raw <- read.csv(unz(temp, paste(test_dir, 'X_test.txt', sep='/')), header=F, sep='', na.strings='NA', stringsAsFactors=F)
names(test_set_raw) <- features
test_set <- test_set_raw[,grepl("mean\\(\\)", names(test_set_raw))]
test_set <- cbind(test_set, test_set_raw[,grepl("std()", names(test_set_raw))])
test_master <- cbind(test_sbj, test_lbl, test_set)

## Training subjects (1:30) & labels (1:6) & set
train_sbj <- read.csv(unz(temp, paste(train_dir, 'subject_train.txt', sep='/')), header=F, sep='', na.strings='NA', stringsAsFactors=F)
names(train_sbj) <- c('subject')
train_lbl_raw <- read.csv(unz(temp, paste(train_dir, 'y_train.txt', sep='/')), header=F, sep='', na.strings='NA', stringsAsFactors=F)
names(train_lbl_raw) <- c('activity_id')
train_lbl <- merge(train_lbl_raw, activities, by.x='activity_id', by.y='id', all=T)[-1]
train_set_raw <- read.csv(unz(temp, paste(train_dir, 'X_train.txt', sep='/')), header=F, sep='', na.strings='NA', stringsAsFactors=F)
names(train_set_raw) <- features
train_set <- train_set_raw[,grepl("mean\\(\\)|std\\(\\)", names(train_set_raw))]
#train_set <- cbind(train_set, train_set_raw[,grepl("std()", names(train_set_raw))])
train_master <- cbind(train_sbj, train_lbl, train_set)

## Create unified tidy data
master <- rbind(test_master, train_master)
#write.table(master, file="HumanActivityRecognition.txt", row.names=F)

## Create new data with avg of each var for each activity and each subject
master_avg <- aggregate(. ~ subject + activity, data=master, FUN=mean)
master_avg <- master_avg[order(master_avg$subject),]
for (i in grep("mean|std", names(master_avg))){
    names(master_avg)[i] <- paste(names(master_avg)[i], "_avg", sep='')
}
write.table(master_avg, file="HumanActivityRecognition_avg.txt", row.names=F)

## Cleanup
rm('base_dir', 'test_dir', 'train_dir', 'features', 'activities')
rm('test_sbj', 'test_lbl_raw', 'test_lbl', 'test_set', 'test_set_raw')
rm('train_sbj', 'train_lbl_raw', 'train_lbl', 'train_set', 'train_set_raw')
rm('test_master', 'train_master', 'i')
#unlink(temp)
