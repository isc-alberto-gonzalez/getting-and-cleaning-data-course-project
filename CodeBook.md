---
title: "CodeBook - Getting and Cleaning Data Course Project"
author: "Alberto Gonzalez"
date: "6/2/2021"
output: html_document
---

## Process to get and cleaning the data.

  <p>
    <h4>The files considered for developed this project was :</h4>
       </p>
      1. subject_train.txt
      2. y_train.txt
      3. x_train.txt
      4. subject_test.txt
      5. y_test.txt
      6. x_test.txt
      7. features.txt
  <p>
    <br>
    <h4>To get the data</h4>
    Every file was loaded using the instruction read.table; Each file was saved in a dataframe whose name correspond to the name of the file but excluding its extension.
    <br><br>Before merge data , the columns whose name was 'V1' was renamed to named with a descriptive name (p.e 'subject' or 'activity').<br>To merge data was used the functions rbind and cbind; the order to merge was the next :<br>
    </p>
    
      1. Merged the rows from of the subjects ('subject_train' and 'subject_test') and save in variable 'subject'.
      2. Merged the rows from of the xs ('x_train' and 'x_test') and save in variable 'x'.
      3. Merge the rows from of the ys ('y_train' and 'y_test') and save in variable 'y'.
      4. Merge the columns from 'subject' , 'x' and 'y' and save in variable 'merge'.
  
   <p>
    <br>
    <strong>The columns was renamed</strong> assigning the name to the column considering the index from the feature (the values from the file features.txt) and the original name of the column.
    (p.e if the name of the column was V5 was assigned the feature with the index 5).
    </p>

  <p>
    <strong>The columns</strong> whose name is not 'subject' nor 'activity' and nor contains the value '-mean' or '-dtd' was removed.</strong>
  </p>
  <p>
  <br>
  <h4>To clean the data</h4>
    <strong>Was updated the values from the column 'subject';</strong> The integer value of the column 'subject' was replaced by its description value.<br>
    </p>
      
      1. if the integer value was 1 i update that value for the description 'WALKING'.
      2. if the integer value was 2 i update that value for the description 'WALKING_UPSTAIRS'.
      3. if the integer value was 3 i update that value for the description 'WALKING_DOWNSTAIRS'.
      4. if the integer value was 4 i update that value for the description 'SITTING'.
      5. if the integer value was 5 i update that value for the description 'STANDING'
      6. if the integer value was 6 i update that value for the description 'LAYING'.
  <p>
    <strong>Was Transformed the letters</strong> of the names of the columns in lowercase.<br>    
  </p>    
  <p>
    <strong>Was Removed the characters '-' ,'(' and ')'  and </strong> of the names of the columns.<br>    
  </p>    
  
  <h4>To group and get the average</h4>
  <p>
    Was used the library dplyr to group the dataframe by the columns 'subject' and 'activity' and get the average of all the numeric columns included.
  </p>
  
  
## Variables used in the file run_analysis.R

<p><strong>subject_train</strong>	
  Dataframe who contain the subject who performed the train activity . Its range is from 1 to 30</p>
  
<p><strong>y_train</strong>		
  Dataframe who contain the training labels.</p>
  
<p><strong>x_train</strong>		
  Dataframe who contain the training set.</p>
  
<p><strong>subject_test</strong>		
  Dataframe who contain the subject who performed the test activity . Its range is from 1 to 30</p>
  
<p><strong>y_test</strong>		
  Dataframe who contain the test labels.</p>
  
<p><strong>x_test</strong>		
  Dataframe who contain the test set.</p>
  
<p><strong>subject</strong>		
  Dataframe who contain the subject who performed the training and the test activity.</p>
  
<p><strong>y</strong>		
  Dataframe who contain the training and the test labels.</p>
  
<p><strong>x</strong>		
  Dataframe who contain the training and the test set</p>
  
<p><strong>merge</strong>		
Dataframe who contain all the rows and columns from the dataframe subject , x and y.</p>

<p><strong>features</strong>		
  Dataframe who contain the list of all features.</p>
  
<p><strong>columnToRename</strong>		
  Variable of type character to save the name of the column who will be renamed.</p>
  
<p><strong>feature</strong>		
  Variable of type character to save the name of the function to assign to the column name in dataframe merge.</p>
  
<p><strong>arrayColumnName</strong>		
  Array to save the name of the columns included in the dataframe merge.</p>
  
<p><strong>arrayColumnsToDelete</strong>		
  Array to save the name of the columns who will be removed from the dataframe merge.</p>
  
<p><strong>columnName</strong>		
  Variable of type character used to compare the name of the column and determine if the column will be removed from the dataframe merge.</p>
  
<p><strong>include</strong>		
  variable of type logical that indicates whether or not the column name should be added to the variable arrayColumnsToDelete</p>
  
<p><strong>extract</strong>		
  Dataframe who contain the data from the columns who are named as 'subject' or 'activity' or include the text -mean and -std in its name.</p>
  
<p><strong>extractWithActiveDescriptive</strong>		
  Dataframe who contain the data from the data frame extract, but now the column 'activity' contain descriptive values.</p>
  
<p><strong>extractWithActiveAndNameDescriptive</strong>	
  Dataframe who contain the data from the data frame extract, but now the column 'activity' contain descriptive values and  the name of the columns are descriptives.	</p>
  
<p><strong>special_character</strong>		
  Variable of type character to save the character (.</p>
  
<p><strong>average</strong>		
  Dataframe who contain the average of each numeric variable for each activity and each subject from the dataframe extractWithActiveAndNameDescriptive</p>

