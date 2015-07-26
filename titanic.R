#titanic.R
#This is an easy demo of missing map/decision tree/mosaic plot in R using Titanic dataset from Kaggle

#Set working directory to desktop
setwd("C:/Users/twntok/Desktop")

#Define our training dataset titanic and check its structure
#Make sure you've downloaded the train.csv from Kaggle
#https://www.kaggle.com/c/titanic/data
titanic <- read.csv("train.csv", na.strings=c("NA", ""))
str(titanic)

#Tranforming Survived/Pclass from int to factor
titanic$Survived <- factor(titanic$Survived)
titanic$Pclass <- factor(titanic$Pclass)
str(titanic)

#Using missing map to get a glance of missings in data
install.packages("Amelia")
library("Amelia")
png(filename="missmap.png", type="cairo")
missmap(titanic, main="Missing Map")
dev.off()

#From previous missmap, we will exclude Cabin and Age since these 2 variables have too many missings
#Modeling with Decision Tree
install.packages("party")
library("party")
Tree = ctree(Survived ~ Pclass + Sex + SibSp + Fare + Parch + Embarked, data=titanic)
png(filename="tree.png", type="cairo",)
plot(Tree, main="Decision Tree of Titanic Dataset")
dev.off()

#Using Mosaic plot to show that how Sex and Pclass influence the opportunity of survival
png(filename="mosaic.png", type="cairo",)
par(mfrow=c(1,2))
mosaicplot(titanic$Pclass ~ titanic$Survived,
           main="Survival by Pclass", color=TRUE,
           xlab="Pclass", ylab="Survived")
mosaicplot(titanic$Sex ~ titanic$Survived,
           main="Survival by Sex", color=TRUE,
           xlab="Sex", ylab="Survived")
dev.off()

#Reference:
#Kaggle.com
#Machine Learning with R Cookbook
#David Chu, who demonstrated titanic in 2015 TW SAS Forum
#Nova Chung, who demonstrated titanic in SAS VA Workshops
#David and Nova are both my colleague in SAS TW