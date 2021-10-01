function [train,test]=kfold(xdata,ydata,k)
Indices = crossvalind('Kfold', length(ydata), k);
train=cell(2,k);test=cell(2,k);
for i=1:k
    indtrain=find(Indices~=i);
    train{1,i}=xdata(indtrain,:);train{2,i}=ydata(indtrain);
    indtest=find(Indices==i);
    test{1,i}=xdata(indtest,:);test{2,i}=ydata(indtest);
end

end