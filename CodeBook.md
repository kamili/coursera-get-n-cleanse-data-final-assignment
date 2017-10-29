# this code book...

  1. Provides a brief outline of the data contained within the file, independent_tidy_dataset.txt, which resides in this repository.
  2. Provides a list of the variables used in the run_analysis.R script file, which resides in this repository.
  3. The Plyr library was loaded to leverage the features of ddply() for using colMeans().

# the data...

  1. Contains a header row, which has the names of each variable (columns).
  2. Contains data rows, which have the values of each variable for a given row.

# the data variables...

  1.  subject : an integer identifier that identifies the subject of the human recognition activity
  2.  activity : a text identifier that represents 1 of 6 human recognition activities
       A. LAYING
       B. SITTING
       C. STANDING
       D. WALKING
       E. WALKING DOWNSTAIRS
       F. WALKING UPSTAIRS
  3.  remaining variables : are the averaged measurements for the different human recognition activities for each subject

# the R script variables...

  1.  fileUrl : url of the downloaded file
  2.  xTrainData : data from the X_train.txt file
  3.  yTrainData : data from the y_train.txt file
  4.  subjectTrainData : data from the subject_train.txt file
  
  5.  xTestData : data from the X_test.txt file
  6.  yTestData : data from the y_test.txt file
  7.  subjectTestData : data from the subject_test.txt file
  
  8.  xDataset : merged data from the x training and test datasets
  9.  yDataset : merged data from the y training and test datasets
  10. subjectDataset : merged data from the subject training and test datasets
  
  11. featuresData : data from the features.txt file
  12. featuresColumnsMeanStdDev : columns from featuresData that contain the words "mean" or "std" in their names
  13. xDataset : indexed data from featuresColumnsMeanstdDev
  14. activitiesLabels : data from the activity_labels.txt file
  15. yDataset : data of the right activity names based upon activitiesLabels
  
  16. oneBigDataSet : merged data from xDataset, yDataset, subjectdataset 
  17. secondTidyDataset : modified version of oneBigDataSet that contains the averaged data
