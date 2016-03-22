## CodeBook for Coursera Data Acquisition Week 4 Final Assignment

Get Data from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Copy the following files from the unzipped data set to your appropriate R working folder:

y_train.txt  vector of Activity codes that correspond to X_train  
X_train.txt  Training data, 560 variables  
y_test.txt    vector of Activity codes that correspond to X_test  
X_test.txt    Testing data, 560 variables  
activity_labels.txt  List of activity names corresponding to activity Codes  
features.txt  Lables for 560 variables  
subject_test.txt  vector of subject IDs that correspond to X_test  
subject_train.txt  vector of subject IDs that correspond to X_train  

###Process and **Variables**:

**var_labels**   <-  Read in variable label file (features.txt)  
**activity_labels**  <-  Read in activity label file (activity_labels.txt)  
  Add appropriate Names/header
  
###Training set of Data:  
**Xtrain**  <- Read in training data (X_train.txt)  
**ytrain**  <- Read in training activity vector (y_train.txt)  
**subjecttrain** <-  Read in training subject vector (subject_train.txt)  
  Add appropriate Names/header

**ytrain2**   <-  Merge/transform ytrain with activity_labels, creating vector of Labels, *not* codes  
**training**  <- cbind all three files into one  

**lv** <- Generate logical vector of Columns that are only mean() or std() & Activity & Subject ID columns  
**trainmeanstd** <- extract from **training** with **lv**  


### Testing set of Data
Repeat the above series of steps with the "Test" data, terminating in:  
**testmeanstd**

###Combine test and training data: 

**humanactivitylog** <-  rbind **testmeanstd** & **trainmeanstd**

###Creat summary of Mean of mean() & std() variables from **humanactivitylog** per Subect/Activity pair


 

