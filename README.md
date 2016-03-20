# Getting_Cleaning_Data
Project Description

The code collects, cleans, combines and organizes data from fitness sensors. The R code can be found: "run_analysis.R"

Refer to the corresponding code book describing the variables.

The steps involved:

1) Extraxt data from the working directory files
- assign file names to consolidate

2) Merge the data sets
- Organize the data by subject, activity and features
- Ensure the column lables match
- Merge the data sets based on column names

3) Extract the Mean and Standard deviation from the combined data set
- Look for "Mean" and "Std" in columns 

4) Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive names
- Remove parentheses
- Update sensor names to valid names
- Create appropriate labels with descriptive names

5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject
- Output is exported to tidy.txt file
