#Getting and Cleaning Data Course Project#

library(dplyr)
library(tidyr)


train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

features <- read.csv("UCI HAR Dataset/features.txt", sep = " ", header = FALSE)
cn <- (features[2])
colnames(train) <- cn$V2
colnames(test) <- cn$V2

head(train[1:6])
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
train$activity = as.numeric(unlist(train_labels))
train_id <- read.table("UCI HAR Dataset/train/subject_train.txt")
train$id = as.numeric(unlist(train_id))
str(tail(train[560:563]))

test_labels <- read.table("UCI HAR Dataset/test/y_test.txt", header= FALSE)
test$activity = as.numeric(unlist(test_labels))
test_id <- read.table("UCI HAR Dataset/test/subject_test.txt")
test$id = as.numeric(unlist(test_id))

data <- rbind(train, test)
head(data[1:6])

data$activity[data$activity == 1] <- "walking"
data$activity[data$activity == 2] <- "walking_upstairs"
data$activity[data$activity == 3] <- "walking_downstairs"
data$activity[data$activity == 4] <- "sitting"
data$activity[data$activity == 5] <- "standing"
data$activity[data$activity == 6] <- "laying"

std_col <- colnames(train)[!is.na(str_extract(colnames(train), "std"))] 
mean_col <- colnames(train)[!is.na(str_extract(colnames(train), "mean"))]

mean_std_data <- data[c("id", "activity", std_col, mean_col)]
colnames(mean_std_data)
head(mean_std_data[1:6])

tidydata <- mean_std_data %>% 
    group_by(id, activity) %>%
    summarise_all("mean")








