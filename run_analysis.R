library(dplyr)


filename <- "UCI HAR Dataset"


feat <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
act <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)

Sub <- rbind(sub_train, sub_test)
Merged_Data <- cbind(Subject, Y, X)

Clean_Data <- Merged_Data %>% select(sub, code, contains("mean"), contains("std"))
Clean_Data$code <- act[Clean_Data$code, 2]


names(Clean_Data)[2] = "activity"
names(Clean_Data)<-gsub("Acc", "Accelerometer", names(Clean_Data))
names(Clean_Data)<-gsub("Gyro", "Gyroscope", names(Clean_Data))
names(Clean_Data)<-gsub("BodyBody", "Body", names(Clean_Data))
names(Clean_Data)<-gsub("Mag", "Magnitude", names(Clean_Data))
names(Clean_Data)<-gsub("^t", "Time", names(Clean_Data))
names(Clean_Data)<-gsub("^f", "Frequency", names(Clean_Data))
names(Clean_Data)<-gsub("tBody", "TimeBody", names(Clean_Data))
names(Clean_Data)<-gsub("-mean()", "Mean", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-std()", "STD", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-freq()", "Frequency", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("angle", "Angle", names(Clean_Data))
names(Clean_Data)<-gsub("gravity", "Gravity", names(Clean_Data))


Beautiful_Data <- Clean_Data %>%
  group_by(sub, act) %>%
  summarise_all(funs(mean))
write.table(Beautiful_Data, "FinalData.txt", row.name=FALSE)