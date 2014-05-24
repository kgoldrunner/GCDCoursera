#Download file and unzip

if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./data/samsung.zip", method = "curl")
datedownloaded <- date()
unzipped.data <- unzip("samsung.zip")

#Merge training and test sets

features <- read.table(unzipped.data[2])
variables <- data.frame(lapply(features$V2, as.character), 
                               stringsAsFactors=FALSE)
training.set <- cbind(read.table(unzipped.data[26]), 
                      read.table(unzipped.data[28]), 
                      read.table(unzipped.data[27]))
test.set <- cbind(read.table(unzipped.data[14]), 
                  read.table(unzipped.data[16]), 
                  read.table(unzipped.data[15]))
mergedData <- rbind(training.set, test.set, all = TRUE)
colnames(mergedData)<- c("Subject", "Activity", variables)

#Subset Standard Deviation and Mean

tidyData1 <- mergedData[, c(1, 2, (grep("mean()", colnames(mergedData), fixed = TRUE)), 
                            (grep("std", colnames(mergedData), fixed = TRUE)))]

#Name activities in the data set

tidyData1$Activity <- gsub("1", "WALKING", tidyData1$Activity)
tidyData1$Activity <- gsub("2", "WALKINGUP", tidyData1$Activity)
tidyData1$Activity <- gsub("3", "WALKINGDOWN", tidyData1$Activity)
tidyData1$Activity <- gsub("4", "SITTING", tidyData1$Activity)
tidyData1$Activity <- gsub("5", "STANDING", tidyData1$Activity)
tidyData1$Activity <- gsub("6", "LAYING", tidyData1$Activity)

#Rename variables to reflect Google R convention

names(tidyData1) <- tolower(names(tidyData1))
names(tidyData1) <- gsub("-", "", names(tidyData1))
names(tidyData1) <- gsub("body", "", names(tidyData1))
names(tidyData1) <- gsub("\\()", "", names(tidyData1))
names(tidyData1) <- gsub("acc", ".acc.", names(tidyData1))
names(tidyData1) <- gsub("mean", "mean.", names(tidyData1))
names(tidyData1) <- gsub("std", "std.", names(tidyData1))
names(tidyData1) <- gsub("gyro", ".gyro.", names(tidyData1))
names(tidyData1) <- gsub("jerk", "jerk.", names(tidyData1))
names(tidyData1) <- gsub("mag", "mag.", names(tidyData1))
names(tidyData1) <- gsub("gravity", ".gravity", names(tidyData1))

#Create second tidy dataset with the average of each variable for each activity and each subject.

tidyData2 <- aggregate(tidyData1[,3:68], by = list(as.factor(tidyData1$subject), 
                                            as.factor(tidyData1$activity)), FUN = mean)
names(tidyData2)[1:2] <- c("subject", "activity")

#Write tidyData2 to file "./data/samsung_data_tidy.csv"

write.csv(tidyData2,  file = "./data/samsung_data_tidy.csv")
