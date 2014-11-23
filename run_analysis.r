#=======================
#Step 1 and 4: read and merge data using descriptive variable names 

#read names of features 
features <- read.table("UCI HAR Dataset\\features.txt")

#some cleanup
features[,2] <- gsub("[\\(\\)]", "", features[,2])
features[,2] <- gsub("[\\,\\-]", "\\.", features[,2])

#read all test data tables
testData <- read.table("UCI HAR Dataset\\test\\X_test.txt", col.names = features[,2])
testActivity <- read.table("UCI HAR Dataset\\test\\y_test.txt", col.names = "Activity")
testSubject <- read.table("UCI HAR Dataset\\test\\subject_test.txt", col.names = "Subject")

#put all test data together
testData <- cbind(testData, testActivity, testSubject)

#read all train data tables 
trainData <- read.table("UCI HAR Dataset\\train\\X_train.txt", col.names = features[,2])
trainActivity <- read.table("UCI HAR Dataset\\train\\y_train.txt", col.names = "Activity")
trainSubject <- read.table("UCI HAR Dataset\\train\\subject_train.txt", col.names = "Subject")

#put all train data together
trainData <- cbind(trainData, trainActivity, trainSubject)

#merge test and train data into a single data set
data <- rbind(testData, trainData)

#=======================
#Step 2: filter data retaining only the measurements on the mean and standard deviation 

filteredIndices <- c(grep("mean|std", features[,2]), 562, 563) #last two indices are for Activity and Subject
data <- data[, filteredIndices]

#=======================
#Step 3: Substitute numeric activity labels with descriptive ones

#read activity labels
activityLabels <- read.table("UCI HAR Dataset\\activity_labels.txt", col.names = c("Activity", "Activity_Label"))
#create a factor from activity column using descriptive activity labels
data$Activity <- factor(data$Activity, labels = activityLabels$Activity_Label)

#=======================
#Step 5: create independent tidy data set with the average of each variable for each activity and each subject

library(reshape2)
meltData <- melt(data, id = c("Activity", "Subject"))
names(meltData)[3] <- "Measurement"

library(plyr)
tidyData <- ddply(meltData, .(Subject, Activity, Measurement), summarize, Average = round(mean(value), 2))

#write date to a file
write.table(tidyData, file="tidy_data.txt", row.name=FALSE)