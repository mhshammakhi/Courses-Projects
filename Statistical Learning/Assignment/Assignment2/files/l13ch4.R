rm(list=ls())
library(MASS)
attach(Boston)
names(Boston)
ncrim=ifelse(crim<median(crim),0,1)
plot(crim,ncrim)
nBoston=data.frame(ncrim,Boston[-1])
par(mfrow=c(3,5))
cor(ncrim,medv)
boxplot(zn~ncrim, col=8)
boxplot(indus~ncrim, col=2)
boxplot(chas~ncrim, col=3)
boxplot(nox~ncrim, col=4)
boxplot(rm~ncrim, col=5)
boxplot(age~ncrim, col=6)
boxplot(dis~ncrim, col=7)
boxplot(rad~ncrim, col=8)
boxplot(tax~ncrim, col=2)
boxplot(ptratio~ncrim, col=3)
boxplot(black~ncrim, col=4)
boxplot(lstat~ncrim, col=5)
boxplot(medv~ncrim, col=6)
#indus-nox-age-dis-rad-tax
pairs(crim~indus-nox-age-dis-rad-tax,col="brown")
ind=(rm<7);
train=nBoston[ind,]
test=nBoston[!ind,]
##################
#predicting
mod=lda(ncrim~indus+nox+age+dis+rad+tax,data = train)
summary(mod)
pred=predict(mod,test,type = "response")
head(pred$class)
class_pred=pred$class
table(class_pred,ncrim[!ind])
mean(class_pred!=ncrim[!ind])
################
mod=qda(ncrim~indus+nox+age+dis+rad+tax,data = train)
summary(mod)
pred=predict(mod,test,type = "response")
head(pred$class)
class_pred=pred$class
table(class_pred,ncrim[!ind])
mean(class_pred!=ncrim[!ind])
################
mod=glm(ncrim~indus+nox+age+dis+rad+tax,data = train)
summary(mod)
pred=predict(mod,test,type = "response")
pred[pred<=0.5]=0
pred[pred>0.5]=1
table(class_pred,ncrim[!ind])
mean(class_pred!=ncrim[!ind])
################
library(class)
train.Y=ncrim[ind]
test.Y=ncrim[!ind]
set.seed(10)
a={};K=1;
pred=knn(train[,c(3,5,7,9,10)],test[,c(3,5,7,9,10)],ncrim[ind],k=1)
a[1]=mean(test.Y!=pred)
for (i in 2:20)
{pred=knn(train[,c(3,5,7,9,10)],test[,c(3,5,7,9,10)],ncrim[ind],k=i)
a[i]=mean(test.Y!=pred)
K=ifelse(a[i]<min(a[-i]),i,K)
}
par(mfrow=c(1,1))
plot(c(1:20),a)
K
pred=knn(train[,c(3,5,7,9,10)],test[,c(3,5,7,9,10)],ncrim[ind],k=K)
knn_er=mean(test.Y!=pred)
knn_er
