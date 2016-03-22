## All files must be in current working directory; Named verbatim from source
## Data is scattered across multiple files, as is typical from sadistic engineers.
## There are also two distinct  sets (train and test), that will be combined
## X_(train|test).txt  is N rows of 561 columns of data.
## features.txt  is name of variables for this data
## y_(train|test).txt  is a vector of activity codes, think of it as *row* headers, for each N row
## activity_labels.txt  is mapping from activity code to actual activity (standing, walkign, etc.)
## subject_(train_test).txt is another *row* header vector of subjects (individuals)
##         These do *not* have a mapping (assuming actual username is PII)
##
## Process: Read in variable label file (features.txt)
##          Read in Activity-Code file  (activity_labels.txt)
##    Process Training Set:
##          Read in Data file for Training set.   (X_train.txt)
##          apply names (header) from variable-lable file to this data frame
##          Read in activity-code/row-header file  (y_train.txt)
##           Merge/map activity names to activity code.
##          Read in subjectID/row-header file (subject_train.txt)
##          Column Bind subjectID 'row-header' vector to raw data
##          Column Bind appropriate activiy code 'row-header' vector to raw data
##          Filter out ONLY mean() and std()  variables/columns
##          Repeat for Test set
##           Combine both sets
##
##  First, read in label files, for variables and for activity Titles
var_labels <- read.csv("features.txt",sep="",header=FALSE)
activity_labels <- read.csv("activity_labels.txt",sep="",header=FALSE)
names(activity_labels) <- c("ActivityCode","Activity")

## Process 'training' set first
Xtrain <- read.table("X_train.txt",sep="",header=FALSE)
names(Xtrain) <- var_labels[,2]
ytrain <- read.csv("y_train.txt",header=FALSE)
names(ytrain) <- "ActivityCode"
subjecttrain <- read.csv("subject_train.txt",header=FALSE)
names(subjecttrain) <- "SubjectID"
ytrain2 <- merge(ytrain,activity_labels,by.x="ActivityCode",by.y="ActivityCode")[2]
training <- cbind(ytrain2,subjecttrain,Xtrain)
## Logical vector of variable names that are -std() or -mean()
lv <- grepl("-std\\(|-mean\\(|^Activity|^Subject",names(training))
trainmeanstd <- training[,lv]

## Repeat for 'Test set !
Xtest <- read.table("X_test.txt",sep="",header=FALSE)
names(Xtest) <- var_labels[,2]
ytest <- read.csv("y_test.txt",header=FALSE)
names(ytest) <- "ActivityCode"
subjecttest <- read.csv("subject_test.txt",header=FALSE)
names(subjecttest) <- "SubjectID"
ytest2 <- merge(ytest,activity_labels,by.x="ActivityCode",by.y="ActivityCode")[2]
testing <- cbind(ytest2,subjecttest,Xtest)
testmeanstd <- testing[,lv]

## Lastly, combine both sets of data into one
finaldata <- rbind(trainmeanstd,testmeanstd)

## Make summary, grouped by SubjectID *and* Acticity, average every single variable.
## Use the mojo of Dplyr
library(dplyr)
finalgroup <- group_by(finaldata,SubjectID,Activity)
finalsummary <- summarise_each(fdg,funs(mean))
write.table(finalsummary,file="human_activity_log_summary.txt",row.name=FALSE )
