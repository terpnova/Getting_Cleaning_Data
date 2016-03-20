# Set working directory and read file data

setwd("C:\Users\mnovitsky001\Documents\Data & Analytics\Coursera\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset")
y_train <- read.table("train/y_train.txt", header = FALSE)
y_test <- read.table("test/y_test.txt", header = FALSE)

feature_names <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt", header = FALSE)

subject_train <- read.table("train/subject_train.txt", header = FALSE)
subject_test <- read.table("test/subject_test.txt", header = FALSE)

X_train <- read.table("train/X_train.txt", header = FALSE)
X_test <- read.table("test/X_test.txt", header = FALSE)

# 1. Merges the training and the test sets to create one data set

# Combine the data corresponding to subject, activity and features 

subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
features <- rbind(X_train, X_test)

# Label sensor columns to match activity labels

colnames(features) <- t(feature_names[2])

# Merge the data

colnames(activity) <- "ActivityId"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

sensor_data_mean_std <- completeData[,grepl("mean|std|Subject|ActivityId", names(completeData))]

# 3. Uses descriptive activity names to name the activities in the data set

sensor_data_mean_std$ActivityId <- as.character(sensor_data_mean_std$ActivityId)
      for (i in 1:6){
        sensor_data_mean_std$ActivityId[sensor_data_mean_std$ActivityId == i] <- as.character(activity_labels[i,2])
        }
sensor_data_mean_std$ActivityId <- as.factor(sensor_data_mean_std$ActivityId)

# 4. Appropriately labels the data set with descriptive names

# Remove parentheses

names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE)

# Update sensor names to valid names

names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))

# Create appropriate labels with descriptive names

names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Set subject as a factor variable
sensor_data_mean_std$Subject <- as.factor(sensor_data_mean_std$Subject)
sensor_data_mean_std <- data.table(sensor_data_mean_std)

# Combine and create the tidy data set

tidyData <- aggregate(. ~Subject + ActivityId, sensor_data_mean_std, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$ActivityId),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
