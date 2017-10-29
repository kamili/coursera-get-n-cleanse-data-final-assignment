###
## 0. BEGIN - DOWNLOAD NEEDED DATA
###

if( !file.exists( "./course_assignment" ) ){dir.create( "./course_assignment" )}
# Created a needed directory if it doesn't exist

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file( fileUrl, destfile = "./course_assignment/assignment_data.zip" )
unzip( zipfile = "./course_assignment/assignment_data.zip", exdir = "./course_assignment" )
# Downloaded desired zipped file, saved to previously created directory, and unzipped it to desired directory

###
## 1. CREATE A SINGLE DATASET CONTAINING TRAINING AND TEST DATA
###

xTrainData <- read.table( "./course_assignment/UCI HAR Dataset/train/X_train.txt" )
yTrainData <- read.table( "./course_assignment/UCI HAR Dataset/train/y_train.txt" )
subjectTrainData <- read.table( "./course_assignment/UCI HAR Dataset/train/subject_train.txt" )
# Read training data into appropriate variables to prep them for combining with test data

xTestData <- read.table( "./course_assignment/UCI HAR Dataset/test/X_test.txt" )
yTestData <- read.table( "./course_assignment/UCI HAR Dataset/test/y_test.txt" )
subjectTestData <- read.table( "./course_assignment/UCI HAR Dataset/test/subject_test.txt" )
# Read test data into appropriate variables to prep them for combining with training data

xDataset <- rbind( xTrainData, xTestData )
yDataset <- rbind( yTrainData, yTestData )
subjectDataset <- rbind( subjectTrainData, subjectTestData )
# Combined the training and test data

###
## 2. GRAB THE MEAN AND STD DEV RELATED HUMAN RECOGNITION ACTIVITY METRICS
###

featuresData <- read.table( "./course_assignment/UCI HAR Dataset/features.txt" )
featuresColumnsMeanStdDev <- grep( "-(mean|std)\\(\\)", featuresData[, 2] )
# Read features data into appropriate variable and chose columns with the words mean or std in their names

xDataset <- xDataset[, featuresColumnsMeanStdDev]
# Subsetted the columns chosen from before

names( xDataset ) <- featuresData[featuresColumnsMeanStdDev, 2]
# Fixed those column names

###
## 3. NAME THE ACTIVITIES IN THE DATASET WITH DESCRIPTIVE ACTIVITY NAMES
###

activitiesLabels <- read.table( "./course_assignment/UCI HAR Dataset/activity_labels.txt" )
# Read activty labels data into appropriate variable

yDataset[, 1] <- activitiesLabels[yDataset[, 1], 2]
# Modified the desired dataset with the right activity names

names( yDataset ) <- "activity"

###
## 4. USE DESCRIPTIVE NAMES FOR VARIABLES IN DATASETS
###

names( subjectDataset ) <- "subject"
# Fixed the column names

oneBigDataSet <- cbind( xDataset, yDataset, subjectDataset )
# Combined the previously modified training, test, and subject datasets into one big dataset

###
## 5. CREATE A 2ND INDEPENDENT TIDY DATASET WITH THE AVERAGED DATA FOR EACH SUBJECT AND ACTIVITY
###

library( plyr )
# Called a needed R library, Plyr

secondTidyDataset <- ddply( oneBigDataSet, .(subject, activity), function(x) colMeans( x[, 1:66] ) )
# Splitted the data, applied function to all columns except subject and activity, then combined them in the resulting data frame

write.table( secondTidyDataset, "./course_assignment/independent_tidy_dataset.txt", row.name = FALSE )
# Wrote the 2nd independent tidy dataset of averaged data to a new text file

###
## 6. END
###
