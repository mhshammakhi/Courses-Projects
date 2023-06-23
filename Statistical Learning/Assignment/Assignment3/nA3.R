rm(list=ls())
x_train=read.table("C:/Users/MSPRL1/Desktop/A3/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train=read.table("C:/Users/MSPRL1/Desktop/A3/UCI HAR Dataset/train/y_train.txt", quote="\"")
x_test=read.table("C:/Users/MSPRL1/Desktop/A3/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test=read.table("C:/Users/MSPRL1/Desktop/A3/UCI HAR Dataset/test/y_test.txt", quote="\"")
features=read.table("C:/Users/MSPRL1/Desktop/A3/UCI HAR Dataset/features.txt", quote="\"")
name=t(features[,2])
colnames(x_train)=name;colnames(x_test)=name
colnames(y_train)=c("y");colnames(y_test)=c("y")
rm(name)
dat.train=data.frame(y=y_train,x_train)
dat.test=data.frame(y=y_test,x_test)
x.tra=model.matrix(y~.,data=dat.train)[,-1]
y.tra=dat.train$y
x.tes=model.matrix(y~.,data=dat.test)[,-1]
y.tes=dat.test$y
#####################outlier
library(DMwR)
t1=proc.time()
outlier.scores = lofactor(x.tra[,-1], k=5)
proc.time()-t1
nx.tra=x.tra[outlier.scores<1.1,]
ny.tra=y.tra[outlier.scores<1.1]
ndat.train=data.frame(y=ny.tra,nx.tra)
ndat.test=data.frame(y=y.tes,x.tes)

##############laso
library (glmnet)
cv.lasso.fit=cv.glmnet(nx.tra,ny.tra,alpha=1)
best.landa=cv.lasso.fit$lambda.min
lasso.fit=glmnet(nx.tra,ny.tra,alpha=1,lambda=best.landa)
ind=lasso.fit$beta@i
nnx.tra=nx.tra[,ind]
nnx.tes=x.tes[,ind]
ndat.train=data.frame(y=ny.tra,nnx.tra)
ndat.test=data.frame(y=y.tes,nnx.tes)
#####################one vs all
y1=ifelse(ndat.train$y==1,1,0);dat1=data.frame(y=y1,ndat.train[,-1])
y1=ifelse(ndat.train$y==2,1,0);dat2=data.frame(y=y1,ndat.train[,-1])
y1=ifelse(ndat.train$y==3,1,0);dat3=data.frame(y=y1,ndat.train[,-1])
y1=ifelse(ndat.train$y==4,1,0);dat4=data.frame(y=y1,ndat.train[,-1])
y1=ifelse(ndat.train$y==5,1,0);dat5=data.frame(y=y1,ndat.train[,-1])
y1=ifelse(ndat.train$y==6,1,0);dat6=data.frame(y=y1,ndat.train[,-1])
rm(y1)
###############SVM
library(e1071)
t1=proc.time()
svm1=svm(y~.,data=dat1,family=binomial)
svm2=svm(y~.,data=dat2,family=binomial)
svm3=svm(y~.,data=dat3,family=binomial)
svm4=svm(y~.,data=dat4,family=binomial)
svm5=svm(y~.,data=dat5,family=binomial)
svm6=svm(y~.,data=dat6,family=binomial)
svm.pred1=predict(svm1,ndat.test,type="response")
svm.pred2=predict(svm2,ndat.test,type="response")
svm.pred3=predict(svm3,ndat.test,type="response")
svm.pred4=predict(svm4,ndat.test,type="response")
svm.pred5=predict(svm5,ndat.test,type="response")
svm.pred6=predict(svm6,ndat.test,type="response")
proc.time()-t1
svm.mat=data.frame(svm.pred1,svm.pred2,svm.pred3,svm.pred4,svm.pred5,svm.pred6)
svm.class=max.col(svm.mat)
e_svm=mean(svm.class!=y.tes)
table(svm.class,y.tes)
e_svm
# 4.8% error
svm.out=data.frame(svm.class,apply(svm.mat, 1,max)/max(apply(svm.mat, 1,max)))
#############################lda
library(MASS)
t1=proc.time()
lda1=lda(y~.,data=dat1,family=binomial)
lda2=lda(y~.,data=dat2,family=binomial)
lda3=lda(y~.,data=dat3,family=binomial)
lda4=lda(y~.,data=dat4,family=binomial)
lda5=lda(y~.,data=dat5,family=binomial)
lda6=lda(y~.,data=dat6,family=binomial)
lda.pred1=predict(lda1,ndat.test,type="response")
lda.pred2=predict(lda2,ndat.test,type="response")
lda.pred3=predict(lda3,ndat.test,type="response")
lda.pred4=predict(lda4,ndat.test,type="response")
lda.pred5=predict(lda5,ndat.test,type="response")
lda.pred6=predict(lda6,ndat.test,type="response")
proc.time()-t1
lda.mat=data.frame(lda.pred1$posterior[,2],lda.pred2$posterior[,2],lda.pred3$posterior[,2],lda.pred4$posterior[,2],lda.pred5$posterior[,2],lda.pred6$posterior[,2])
lda.class=max.col(lda.mat)
e_lda=mean(lda.class!=y.tes)
table(lda.class,y.tes)
e_lda
# 4.51% error
lda.out=data.frame(lda.class,apply(lda.mat, 1,max))
###################total
total.class=ifelse(lda.out[,2]>svm.out[,2],lda.out[,1],svm.out[,1])
e_total=mean(total.class!=y.tes)
e_total
table(total.class,y.tes)
table(lda.class,y.tes)
proc.time()-t1
# 4.47% error
#############################glm
library(MASS)
t1=proc.time()
glm1=glm(y~.,data=dat1,family=binomial)
glm2=glm(y~.,data=dat2,family=binomial)
glm3=glm(y~.,data=dat3,family=binomial)
glm4=glm(y~.,data=dat4,family=binomial)
glm5=glm(y~.,data=dat5,family=binomial)
glm6=glm(y~.,data=dat6,family=binomial)
glm.pred1=predict(glm1,ndat.test,type="response")
glm.pred2=predict(glm2,ndat.test,type="response")
glm.pred3=predict(glm3,ndat.test,type="response")
glm.pred4=predict(glm4,ndat.test,type="response")
glm.pred5=predict(glm5,ndat.test,type="response")
glm.pred6=predict(glm6,ndat.test,type="response")
proc.time()-t1
glm.mat=data.frame(glm.pred1,glm.pred2,glm.pred3,glm.pred4,glm.pred5,glm.pred6)
glm.class=max.col(glm.mat)
e_glm=mean(glm.class!=y.tes)
table(glm.class,y.tes)
e_glm
# 8% error
glm.out=data.frame(glm.class,apply(glm.mat, 1,max))
