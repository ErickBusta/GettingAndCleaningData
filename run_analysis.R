
################################################################

unzip(file.choose()) ## Here unzip the file that we want. It' necessary to
			   ## choose it in the window that it'll appear

## Read test
X_test<- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test<- read.table("UCI HAR Dataset/test/subject_test.txt")

## Read train
X_train<- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <-read.table("UCI HAR Dataset/train/subject_train.txt")

## Read features and activity
features<- read.table("UCI HAR Dataset/features.txt")
activity_labels<- read.table("UCI HAR Dataset/activity_labels.txt")



################
###### 1 #######
################ 

#Mergin
X<-rbind(X_test, X_train)
Y<-rbind(Y_test, Y_train)
subject<-rbind(subject_test, subject_train)

## DIM
dim(X)
dim(Y)
dim(subject)



################
###### 2 #######
################ 


#Getting indeces which contain "mean" and "std" 
ind<- grep("mean\\(\\)|std\\(\\)", features[,2])

#Length
length(ind) 

# Only variables with mean and stdev

X<-X[,ind]
dim(X) 


################
###### 3 #######
################ 



# replacing numeric values with lookup value from activity.txt; won't reorder Y set

Y[,1]<- activity_labels[Y[,1],2] 
head(Y) 



################
###### 4 #######
################ 

names<- features[ind,2]
# Add names
names(X)<- names 
names(subject)<- "Subject_ID"
names(Y)<- "Activity"
Merd1<- cbind(subject, Y, X)
head(Merd)


################
###### 5 #######
################ 

# Read Merd1
Merd<- data.table(Merd1)

# By Subject and by activity
tidyData <- Merd[, lapply(.SD, mean), by = 'Subject_ID,Activity'] 

write.table(tidyData, file = "tidyData.txt", row.name = FALSE)
