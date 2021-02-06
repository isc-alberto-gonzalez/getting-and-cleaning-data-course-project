## 0) Downloaded the files

if (!file.exists("data")) {dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "./data/project.zip")

# Unzip Data

unzip(zipfile = "./data/project.zip", exdir = "./data")


## 1) Merges the training and the test sets to create one data set.

##read the files using read.table ; the data are loaded in dataframes
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

x_train <- read.table("./data/UCI HAR Dataset/train/x_train.txt")

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt")

#rename the column 'V1' to 'subject' in dataframe 'subject_train'
colnames(subject_train)[colnames(subject_train) == 'V1'] <- 'subject'
colnames(subject_train)

#rename the column 'V1' to 'subject' in dataframe 'subject_test'
colnames(subject_test)[colnames(subject_test) == 'V1'] <- 'subject'
colnames(subject_test)

#rename the column 'V1' to 'activity' in 'dataframe y_train'
colnames(y_train)[colnames(y_train) == 'V1'] <- 'activity'
colnames(y_train)

#rename the column 'V1' to 'activity' in 'dataframe y_test'
colnames(y_test)[colnames(y_test) == 'V1'] <- 'activity'
colnames(y_test)

#create dataframe who include the rows from 'subject_train' and 'subject_test'
subject <- rbind(subject_train, subject_test)

#create dataframe who include the rows from 'y_train' and 'y_test'
y <- rbind(y_train, y_test)

#create dataframe who include the rows from 'x_train' and 'x_train'
x <- rbind(x_train, x_test)

#create dataframe who include all the rows from and columns from dataframes 'subject' , 'x' and 'y'.
merge <-  cbind(subject , y);
merge <-  cbind(merge , x);

## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

#read the features from the file to assign the name to every column obtained in dataframe 'merge'
features <- read.table("./features.txt")

#iterate the features and assign the name to the corresponding column
for(i in 1:nrow(features))
{
  #built the name of the column
  columnToRename = paste0("V",i);
  
  #get the feature name according to the value from 'i'
  feature = features$V2[i]
  
  #assign the value included in the feature variable 
  colnames(merge)[colnames(merge) == columnToRename] <- feature
}

#identify the columns to remove from the dataframe

#get the name of all the columns included in the dataframe
arrayColumnName <- colnames(merge)

#declare array to save the name of the columns who don't named as 'subject' or 'activity' and not include the text -mean and -std in its name.
arrayColumnsToDelete = c(NULL);

#iterate the array arrayColumnsToDelete
for(i in 1:length(arrayColumnName))
{
  columnName = arrayColumnName[i]
  
  include = FALSE;
  
  #when the name of the column is 'subject' or 'activity' then the column don't will be removed from the dataframe.
  if(columnName == "subject" | columnName == "activity")
  {
    include = TRUE;  
  }
  else
  {
    #when the name of the column contains the value '-mean' or '-dtd' then the column don't will be removed from the dataframe.
    include = grepl("-mean|-std",columnName);
  }
  
  #if the value of the variable 'include' is FALSE , 
  #that means that the name of the column  is not 'subject' nor 'activity' nor contains the value '-mean' or '-dtd' 
  #then the column will be removed from the dataframe.
  
  if(include == FALSE)
  {
    #add the name of the column to the array arrayColumnsToDelete
    arrayColumnsToDelete <- append(arrayColumnsToDelete, columnName)
  }
}

##remove from the dataframe 'merge' the columns whose names are included in the array arrayColumnsToDelete
##the result is assigned to the dataframe 'extract'
extract <- merge[, ! names(merge) %in% arrayColumnsToDelete, drop = F]

##3) Uses descriptive activity names to name the activities in the data set

#assign the value of the variable 'extract' to variable 'extractWithActiveDescriptive'
extractWithActiveDescriptive <- extract

#add a new column into dataframe 'extractWithActiveDescriptive';
# the name of the new column is 'activityname' and its value is assigned depending of the value of the column 'activity'
extractWithActiveDescriptive$activityname <- ifelse(extractWithActiveDescriptive$activity == 1, 'WALKING',
                                                    ifelse(extractWithActiveDescriptive$activity ==2, 'WALKING_UPSTAIRS',
                                                           ifelse(extractWithActiveDescriptive$activity ==3, 'WALKING_DOWNSTAIRS',
                                                                  ifelse(extractWithActiveDescriptive$activity ==4, 'SITTING',
                                                                         ifelse(extractWithActiveDescriptive$activity ==5, 'STANDING',
                                                                                ifelse(extractWithActiveDescriptive$activity ==6, 'LAYING' ,''))))))

#assign the value of the column 'activityname' to the column 'activity' in the dataframe 'extractWithActiveDescriptive'
extractWithActiveDescriptive$activity <- extractWithActiveDescriptive$activityname

#remove the column 'activityname' from the dataframe 'extractWithActiveDescriptive'
extractWithActiveDescriptive <- subset(extractWithActiveDescriptive, select = -activityname)

## 4) Appropriately labels the data set with descriptive variable names. 

#assign the value of the variable 'extract' to variable 'extractWithActiveDescriptive'
extractWithActiveAndNameDescriptive <- extractWithActiveDescriptive

#use function tolower to transform the letters of the names of the columns in lowercase.
names(extractWithActiveAndNameDescriptive) <- tolower(names(extractWithActiveAndNameDescriptive))

#remove character '-' from the name of the columns
names(extractWithActiveAndNameDescriptive) <- gsub("-","",names(extractWithActiveAndNameDescriptive))

##remove character '(' from the name of the columns
special_character = "\\(";
names(extractWithActiveAndNameDescriptive) <- sub(special_character,"",names(extractWithActiveAndNameDescriptive))  

#remove character ')' from the name of the columns
names(extractWithActiveAndNameDescriptive) <- gsub(")","",names(extractWithActiveAndNameDescriptive)) 
names(extractWithActiveAndNameDescriptive)
## 5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#load the library dplyr.
library(dplyr)
#use the library dplyr to group the dataframe 'extractWithActiveAndNameDescriptive' by the columns 'subject' and 'activity' and get the average of all the numeric columns included.
#the result is saved in the variable 'average'
average <-extractWithActiveAndNameDescriptive %>%
  group_by(subject , activity) %>%
  summarise(across(
    .cols = is.numeric, 
    .fns = list(Mean = mean), na.rm = TRUE, 
    .names = "{col}"
  ))


#write the dataframe 'average' in a file
write.table(average,"averagetidydataset.txt" , row.names = FALSE)


