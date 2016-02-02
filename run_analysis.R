#getData
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
#unzip
unzip(zipfile="./data/Dataset.zip",exdir="./data")

fPath <-file.path("./data", "UCI HAR Dataset")
#merge datasets 

dActivityTrain <- read.table(file.path(fPath, "train", "Y_train.txt"),header = FALSE)
dActivityTest  <- read.table(file.path(fPath, "test" , "Y_test.txt" ),header = FALSE)

dSubjectTrain <- read.table(file.path(fPath, "train", "subject_train.txt"),header = FALSE)
dSubjectTest  <- read.table(file.path(fPath, "test" , "subject_test.txt"),header = FALSE)

dFeaturesTrain <- read.table(file.path(fPath, "train", "X_train.txt"),header = FALSE)
dFeaturesTest  <- read.table(file.path(fPath, "test" , "X_test.txt" ),header = FALSE)

#Merge train dataset with test
dSubject <- rbind(dSubjectTrain, dSubjectTest)
dActivity<- rbind(dActivityTrain, dActivityTest)
dFeatures<- rbind(dFeaturesTrain, dFeaturesTest)
#label columns
names(dSubject)<-c("subject")
names(dActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(fPath, "features.txt"),head=FALSE)
names(dFeatures)<- dataFeaturesNames$V2

dCombine <- cbind(dSubject, dActivity)
sensorData <- cbind(dFeatures, dCombine)
# Extract only the mean, std. deviation
sensorDataMeanStd <- sensorData[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]

#label with descriptive names
# Remove parentheses
names(sensorDataMeanStd) <- gsub('\\(|\\)',"",names(sensorDataMeanStd), perl = TRUE)
# Make syntactically valid names
names(sensorDataMeanStd) <- make.names(names(sensorDataMeanStd))
# Make clearer names
names(sensorDataMeanStd) <- gsub('Acc',"Acceleration",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('GyroJerk',"AngularAcceleration",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('Gyro',"AngularSpeed",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('Mag',"Magnitude",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('^t',"TimeDomain.",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('^f',"FrequencyDomain.",names(sensorDataMeanStd))

#output to text file
library(plyr)
sensorData<-aggregate(. ~subject + activity, Data, mean)
write.table(sensorData, file = "tidydata.txt",row.name=FALSE)

library(knitr)
knit2html("codebook.Rmd")