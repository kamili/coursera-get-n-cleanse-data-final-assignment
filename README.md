# coursera get-n-cleanse data final assignment...

The files contained within this repository are for the final assignment of the John Hopkins Coursera Course, Getting and Cleansing Data. Below is a link to the original dataset, which has data measuring human recognition activity in smartphones.

Link = https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# repository contents...

  1.  CodeBook.md : a text file that contains a basic description of the data and variables used in this final assignment
  2.  independent_tidy_dataset.txt : a text file that contains the final averaged output of the human recognition activity data
  3.  run_analysis.R : the R script created to perform the transformations on the data and produce independent_tidy_dataset.txt

# how the script works...

  ## STEP 0.   I started by creating a new directory for the final assignment if it didn't already exist
              !file.exists(), dir.create()
              Then I downloaded the human recognition activity zipped file, unzipped it and saved it to the directory
                fileUrl, download.file(), unzip() 
  
  # STEP 1.   I created a single dataset that combined the training and test data
              I read each file's training and testing data into appropriate variables using read.table()
               xTrainData, yTrainData, subjectTrainData
               xTestData, yTestData, subjectTestData
              Then used rbind() to combine/merge them to prep datasets for the next step.
                xDataset, yDataset, subjectDataset
              
  # STEP 2.   I grabbed the mean and standard deviation related human reognition activity metric data
              The function, read.table(), was used to read the features.txt data into featuresData var.
              And then grep() was used to read the contents of featuresData and only chose the 
                column names that contained the words "mean" or "std".
                  featuresColumnsMeanStdDev
              For the xDataset var, I subsetted the columns from featuresColumnsMeanStdDev.
              And fixed the column names
                names( xDataset ) <- featuresData[featuresColumnsmeanStdDev, 2]
  
  # STEP 3.   I named the activities in the dataset with descriptive activity names
              The function, read.table(), was used to read the activity_labels.txt data into activitiesLabels.
                activitiesLabels
              I modified the yDataset var with the right activity names with the activitiesLabels var.
  
  # STEP 4.   I fixed column names in the subjectDataset.
            Then combined/merged the 3 previously modifed datasets into one big dataset using cbind().
              oneBigDataSet <- cbind( xDataset, yDataset, subjectDataset )
  
  # STEP 5.   I created a 2nd independent tidy dataset with the averaged data for each subject and activity.
              I called the Plyr library because I needed to use it's ddply() function with colMeans().
              ddply allowed me to "split" the data, apply the colMeans function to the columns I specified, 
                and I exempted the subject and activity columns from the colMeans function.
                  secondTidyDataset <- ddply( oneBigDataSet, .(subject, activity), function(x) colMeans( x[, 1:66] ) )
              And last, I wrote the contents of the secondTidyDataset var into a newly created file.
                independent_tidy_dataset.txt
                
  # STEP 6.   END
