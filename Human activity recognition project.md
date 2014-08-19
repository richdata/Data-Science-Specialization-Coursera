---
title: "Machine Learning Write-Up"
author: "Ted Petrou"
date: "Saturday, June 21, 2014"
output: html_document
---


## Human Activity Recognition

We are given a dataset of individuals performing a dumbbell exercises at varying degrees of correctness. 

The study is described at this link - http://groupware.les.inf.puc-rio.br/har

"Six young health participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E)."

My paper goes through a machine learning analysis that attempts to categorize the movements by class given around 150 features to learn from.

## Pre-Process Data

A large training dataset is loaded along with a small 20 row testing data set that will be turned in.





```r
library(caret)
library(rpart)
```


```r
orig_data = read.csv("c:/users/teddy/dropbox/coursera/r courses/machine learning john hopkins/pml-training.csv")
testing = read.csv("c:/users/teddy/dropbox/coursera/r courses/machine learning john hopkins/pml-testing.csv")
```

Look for NA's and then decided what to do with them





Now take a sample look at all columns that have 1 or more NA.
As seen from the table below, 67 columns have nothing but NA. These must be removed


```r
table(allNA)
```

```
allNA
    0 19216 
   93    67 
```
###### Remove columns with nothing but NA

I remove the columns with solely NA and we are down to 93 columns


```r
noNA = orig_data[, allNA == 0]
dim(noNA)
```

```
[1] 19622    93
```

##### Look at variable classes

A table of the classes of each


```r
table(sapply(noNA, class))
```

```

 factor integer numeric 
     37      29      27 
```

To further simplify the analysis since there still are a large amount of features, factor variables will be removed. The factor variable "classe" is kept since it is the outcome we are predicting


```r
noNA_noFactor = cbind(noNA[,sapply(noNA, class) != "factor"],classe = noNA[,"classe"])
dim(noNA_noFactor)
```

```
[1] 19622    57
```

##### Removing non-exercise variables

From their descriptions the first 4 variables ("X","raw_timestamp_part_1", "raw_timestamp_part_2" "num_window" ) have nothing to do with exercises so these are thrown out


```r
cleaned_data = noNA_noFactor[,-(1:4)]
dim(cleaned_data)
```

```
[1] 19622    53
```

## Prediction 

###### Predicting with a Sample of the Data

Since the dataset is so large a small sample of the data will be used to run some machine learning algorithms. The first prediction method will be "rpart", which is prediction by trees. 


```r
set.seed(1)
f1 = cleaned_data[sample(dim(cleaned_data)[1],2000),]
inTrain = createDataPartition(y = f1$classe, p = .7, list = F)
training = f1[inTrain,]
testing = f1[-inTrain,]
mod = train(classe ~ ., method = "rpart", data = training)
sum(predict(mod, training) == training$classe)/ dim(training)[1]
```

```
[1] 0.5214
```

```r
sum(predict(mod, testing) == testing$classe)/ dim(testing)[1]
```

```
[1] 0.5033
```

The model accuracy is not great at .52 (and .5 for the testing sample), though it does do much better than random chance at .2

###### The out of sample error here would be .5

###### Predictin with Random Forest

To help generate better accuracy the random forest method for prediction will now be used. Since random forest can take a long time with large data, a control for the train function will used to change the default method of training which is bootstrapping to cross validation. The default for cross validation is 10 folds and this will be changed to 4.

The time to finish took about 1 minute.

There was a remarkable 100% accuracy for the training set and a solid 94% accuracy for the training.


```r
trControl = trainControl(method = "cv", number = 4, allowParallel = TRUE)
modRF = train(classe ~ ., method = "rf", data = training, trControl= trControl)
sum(predict(modRF, training) == training$classe) / dim(training)[1]
```

```
[1] 1
```

```r
sum(predict(modRF, testing) == testing$classe) / dim(testing)[1]
```

```
[1] 0.9281
```

## Training with more data

Since the model was trained fairly quickly with a training sample of around 1400, more data will be used to gain accuracy with a sacrifice of time. Around 7000 data points are used for the model below and the accuracy improved to 100% for in sample and 98% for out of sample.

##### This is an out of sample error of 2%


```r
set.seed(1)
f2 = cleaned_data[sample(dim(cleaned_data)[1],10000),]
inTrain = createDataPartition(y = f2$classe, p = .7, list = F)
training = f2[inTrain,]
testing = f2[-inTrain,]
modRF2 = train(classe ~ ., method = "rf", data = training, trControl= trControl)
sum(predict(modRF2, training) == training$classe)/ dim(training)[1]
```

```
[1] 1
```

```r
sum(predict(modRF2, testing) == testing$classe)/ dim(testing)[1]
```

```
[1] 0.9817
```

Cross validation is done through the trainControl function.
