library("ISLR")
attach(Carseats)
a=lm(Sales~Price+Urban+US,Carseats)
summary(a)
a=lm(Sales~Price+US,Carseats)
summary(a)
confint(a)

