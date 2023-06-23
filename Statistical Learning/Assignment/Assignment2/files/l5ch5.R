rm(list=ls())
library(ISLR)
attach(Default)
#a
set.seed(1)
ind=sample(1:10000,9000)
train=Default[ind,]
test=Default[-ind,]
mod=glm(default~income+balance,data = Default,family=binomial)
summary(mod)
pred=predict(mod,test,type = "response")
pred[pred<=0.5]="YES"
pred[pred>0.5]="No"
table(pred,default[-ind])
mean(pred!=default[-ind])
#b
mod=glm(default~income+balance,data = train,family=binomial)
summary(mod)
pred=predict(mod,test,type = "response")
pred[pred<=0.5]="YES"
pred[pred>0.5]="No"
table(pred,default[-ind])
mean(pred!=default[-ind])
#c
a={}
for (i in 1:3)
{ind=sample(1:10000,3000*i)
train=Default[ind,]
test=Default[-ind,]
mod=glm(default~income+balance,data = train,family=binomial)
summary(mod)
pred=predict(mod,test,type = "response")
pred[pred<=0.5]="YES"
pred[pred>0.5]="No"
table(pred,default[-ind])
a[i]=mean(pred!=default[-ind])
}
a
#d
set.seed(1)
ind=sample(1:10000,9000)
train=Default[ind,]
test=Default[-ind,]
mod=glm(default~income+balance+student,data = Default,family=binomial)
summary(mod)
pred=predict(mod,test,type = "response")
pred[pred<=0.5]="YES"
pred[pred>0.5]="No"
table(pred,default[-ind])
mean(pred!=default[-ind])
