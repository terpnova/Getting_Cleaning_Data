Description of variables used in "run_analysis.R"

y_train <- table of "train.txt"
y_test <- table of "y_test.txt"

feature_names <- table of "features.txt"
activity_labels <- table of "activity_labels.txt"

subject_train <- table of "subject_train.txt"
subject_test <- table of "subject_test.txt"

X_train <- table of "X_train.txt"
X_test <- table of "X_test.txt"

subject <- combination of subject_train & subject_test
activity <- combination of y_train & y_test
features <- combination of X_train & X_test

completeData <- combines features,activity,subject. The consolidated data set

sensor_data_mean_std <- Just the mean, standard deviation columns from completeData. Also includes ActivityID and Subject
tidyData <- organizes sensor_data_mean_std by Activty and Subject
