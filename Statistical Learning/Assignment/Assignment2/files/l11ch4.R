rm(list=ls())
library(ISLR)
attach(Auto)
#a 
mpg01=ifelse(mpg<median(mpg),0,1)
plot(mpg,mpg01)
nAuto=data.frame(mpg01,Auto[-1])
#b
par(mfrow=c(2,4))
boxplot(cylinders~mpg01, col=8)
boxplot(displacement~mpg01, col=2)
boxplot(horsepower~mpg01, col=3)
boxplot(weight~mpg01, col=4)
boxplot(acceleration~mpg01, col=5)
boxplot(year~mpg01, col=6)
boxplot(origin~mpg01, col=7)
#c
ind=(year<80);
train=nAuto[ind,]
test=nAuto[!ind,]
################
#d
library(MASS)
mod=lda(mpg01~cylinders+displacement+horsepower+weight+year,data = train)
summary(mod)
pred=predict(mod,test,type = "response")
head(pred$class)
class_pred=pred$class
table(class_pred,mpg01[!ind])
mean(class_pred!=mpg01[!ind])
################
#e
mod=qda(mpg01~cylinders+displacement+horsepower+weight+year,data = train)
summary(mod)
pred=predict(mod,test,type = "response")
head(pred$class)
class_pred=pred$class
table(class_pred,mpg01[!ind])
mean(class_pred!=mpg01[!ind])
################
#f
mod=glm(mpg01~cylinders+displacement+horsepower+weight+year,data = train)
summary(mod)
pred=predict(mod,test,type = "response")
pred[pred<=0.5]=0
pred[pred>0.5]=1
table(pred,mpg01[!ind])
mean(pred!=mpg01[!ind])
summary(pred)
################
#g
library(class)
train.Y=mpg01[ind]
test.Y=mpg01[!ind]
set.seed(10)
a={};K=1;
pred=knn(train[,-9],test[,-9],mpg01[ind],k=1)
a[1]=mean(test.Y!=pred)
for (i in 2:20)
{pred=knn(train[,-9],test[,-9],mpg01[ind],k=i)
a[i]=mean(test.Y!=pred)
K=ifelse(a[i]<min(a[-i]),i,K)
}
par(mfrow=c(1,1))
plot(c(1:20),a)
K
pred=knn(train[,-9],test[,-9],mpg01[ind],k=K)
knn_er=mean(test.Y!=pred)
knn_er
