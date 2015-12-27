#I copied all files into my working directory after I unzipped the contents of the dataset.
#It was easier for me that way instead of typing the whole directory string when I went to
#read the files in.

#I am loading the plyr package to make calculating the means easier at the end
library(plyr)

#read test data into workspace
xtest = read.table("X_test.txt")
head(xtest) #did this to check number of columns
ytestlabels = read.table("y_test.txt")
table(ytestlabels)
testsub = read.table("subject_test.txt")

#read training data into workspace
xtrain = read.table("X_train.txt")
head(xtrain) #checking number of columns
ytrainlabels = read.table("y_train.txt")
table(ytrainlabels)
trainsub = read.table("subject_train.txt")

#join test and training tables
allData = rbind(xtest, xtrain)
head(allData) #double check on number of columns

#create activityID label vector
allLabels = rbind(ytestlabels, ytrainlabels)

#create subject vector
allSubs = rbind(testsub, trainsub)

#I am writing this code in RStudio so I can see the dimensions of the objects I'm creating in the Environment pane
#I'm not sure if I should be coding in the dimension checks but since I can see it in the pane I'm not doing it
#I get allData at 10299 by 561, and allLabels and allSubs at 10299 by 1 for both of them so I think I'm on the right track

#Now I want to get the variable names from the features.txt file and add them to the top of the allData dataframe I've already
#created
allDataVars = read.table("features.txt")
DataVars = allDataVars[, 2]
colnames(allData) = DataVars

#Using the grep function to extract only columns that contain mean and std
finalVars = grep("mean\\(\\)|std\\(\\)", allDataVars[, 2])
sortedData = allData[, finalVars]

#Replacing the integer activity IDs with the activity description
actvID = read.table("activity_labels.txt")
actvID[,2] = gsub("_", "", actvID[,2]) #removes the underscore and replaces it with no space
allLabels = actvID[allLabels[,1], 2]

#Joining the mean & std Data, Labels, and Subjects into the final dataframe
fullData = cbind(allSubs, allLabels, sortedData)

#Upon inspecting fullData I see that the subject and activity columns aren't labeled properly
#So I will take care of that now
colnames(fullData)[1] = "SubjectID"
colnames(fullData)[2] = "ActivityID"

#Appropriate descriptive variable names
names(fullData) = gsub("^t", "time", names(fullData))
names(fullData) = gsub("^f", "frequency", names(fullData))
names(fullData) = gsub("Acc", "Accelerometer", names(fullData))
names(fullData) = gsub("Gyro", "Gyroscope", names(fullData))
names(fullData) = gsub("Mag", "Magnitude", names(fullData))
names(fullData) = gsub("\\()", "", names(fullData))

#Using ddplyr function to split the dataframe at Subject ID and Activity ID and then find the average
#of the remaining columns
tidymeans = ddply(fullData, .(SubjectID, ActivityID), function(x) colMeans(x[, 3:68]))

#Write results to a text file with row names = FALSE as specified in submission directions
write.table(tidymeans, "tidy_means.txt", row.names = FALSE)




