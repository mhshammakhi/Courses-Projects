#library("ISLR")
C=read.csv("College.csv",header = T)
attach(College)
fix(College)
rownames (college)=college [,1]
fix(college)
college=College[,-1]
fix(College)
summary(College)
pairs(College[,1:10])
plot(Outstate,Private)
Elite=rep("No",nrow(college))
Elite[college$Top10perc >50]=" Yes"
Elite=as.factor(Elite)
college=data.frame(college ,Elite)
summary(college)
plot(Outstate,Elite)

