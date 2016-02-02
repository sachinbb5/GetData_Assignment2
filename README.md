# GetData_Assignment2
Coursera Getting and Cleaning Data Programming Assignment 2


The script downloads the data zip file,unzips the files needed and reads them into tables. 
	The files required are:
	fileUrl is "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

	Y_train.txt, Y_test.txt, X_train.txt, X_test.txt, subject_train.txt, subject_test.txt

Then it mmerges the training data with the Test data. 

Only the required columns (mean, std,subject) are selected inthe data.

Then the column names are replaced with clearer names.
