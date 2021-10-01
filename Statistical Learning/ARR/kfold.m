function [train,test]=kfold(xf,yf,n)
Indices = crossvalind('Kfold', size(yf,1), n);
for o=1:n
train{1,o}=xf(Indices~=o,:);
train{2,o}=yf(Indices~=o,:);
test{1,o}=xf(Indices==o,:);
test{2,o}=yf(Indices==o,:);
end
end