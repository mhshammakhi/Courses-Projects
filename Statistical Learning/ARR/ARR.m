clear;clc;close all;
mode=1;PCAmode=0;criterion=0;
load('ARR.mat');
format long;
X=arrhythmia;
[m,n]=size(X);

%%
%PCA or Not
if PCAmode==1
[coeff,score,latent] =pca(X);
X=score;
end
%%
%Edit data
mu=repmat(mean(X),size(X,1),1);
sigma2=repmat(var(X),size(X,1),1);sd2=sigma2/(size(X,1)-1);sd=sqrt(sd2);
X=-((mu-sd)>X)+((mu+sd)<X);
clear mu sigma;
%%
if criterion==0
%Mutal Information beetween feature and class
inf_fwc=zeros(1,n);
tic;
for i=1:n
inf_fwc(1,i)=mutualInf_dis_fwc(X(:,i),y);
end
toc;

%%
%Mutal Information beetween feature and feature
tic;
inf_fwf=zeros(n,n);
for i=1:n-1
    for j=i+1:n
        inf_fwf(i,j)=mutualInf_dis_fwf(X(:,i),X(:,j));
        inf_fwf(j,i)=inf_fwf(i,j);
                
    end
end
toc;
%%
%Best Subsets with Mutual Information Criterion
best_fea=cell(2,n);
best_fea{1,1}=find(max(inf_fwc)==inf_fwc,1);
best_fea{2,1}=find(max(inf_fwc)==inf_fwc,1);
best_fea{3,n}=1:n;
for i=2:n
    temp1=(inf_fwc-sum(inf_fwf(best_fea{1,i-1},:),1)/i);
    temp1(best_fea{1,i-1})=-10000;
    temp2=inf_fwc-ismember(1:n,best_fea{2,i-1})*10000;    
    temp3=inf_fwc-sum(inf_fwf(best_fea{1,n-i+2},:),1)/(n-i+2);temp3(setdiff(1:n,[best_fea{3,n-i+2}]))=1000;
    best_fea{1,i}=[best_fea{1,i-1},find(max(temp1)==temp1,1)];
    best_fea{2,i}=[best_fea{2,i-1},find(max(temp2)==temp2,1)];
    best_fea{3,n-i+1}=setdiff(best_fea{3,n-i+2},find(min(temp3)==temp3,1));
    clear temp1 temp2 temp3;
end
clear i j; 

elseif criterion==1
for i=1:n
best_fea{1,i}=1:i;
best_fea{2,i}=1:i;
end
end

%%
%Make X for CV
for i=1:50
[train{1,i},test{1,i}]=kfold(X(:,best_fea{1,i}),y,10);
[train{2,i},test{2,i}]=kfold(X(:,best_fea{2,i}),y,10);
[train{3,i},test{3,i}]=kfold(X(:,best_fea{1,i}),y,10);
end
clear n i;
met={'mRMR','MaxRel'};

%%
if (mode==1)
%Using SVM
for method=1:3
ti(1)=10;
tic;
for i=1:50
    for j=1:10
    model = fitcsvm(train{method,i}{1,j},train{method,i}{2,j});
    z=predict(model,test{method,i}{1,j}); 
    er_ova(i,j)=mean(z~=test{method,i}{2,j});
    end
end
toc;
err_svm{method}=mean(er_ova,2);
%clear i j ti er_ova ti z;
end
plot(1:50,err_svm{1},'LineWidth',2);hold all;
plot(1:50,err_svm{2},'LineWidth',2);xlabel('Number of Features');ylabel('error');legend('mRMR','MaxRel');title('SVM on ARR X');
%clear train test k method;
min(err_svm{1})
min(err_svm{2})
%%
elseif (mode==2)
%Using NB
tic;
for method=1:3
for i=1:50
    for j=1:10
    xtemp=train{method,i}{1,j};
    ytemp=train{method,i}{2,j};
    ind=setdiff(1:size(xtemp,2),find(sum(cov(xtemp))==0));
    model=NaiveBayes.fit(xtemp(:,ind),ytemp);
    xtemp=test{method,i}{1,j};
    label=model.predict(xtemp(:,ind));
    err(i,j)=mean(label~=test{method,i}{2,j});
    end
end
    err_lda{method}=mean(err,2);
%clear w p i j L label temp temp1 m mode method;
end
plot(1:50,err_lda{1},'LineWidth',2);hold all;
plot(1:50,err_lda{2},'LineWidth',2);xlabel('Number of Features');ylabel('error');legend('mRMR','MaxRel');title('NB on ARR X');
toc;
%%
elseif (mode==3)
%Use LDA
tic;
for method=1:3
for i=1:50
    for j=1:10
    xtemp=train{method,i}{1,j};
    ytemp=train{method,i}{2,j};
    ind=setdiff(1:size(xtemp,2),find(sum(cov(xtemp))==0));
    w=LDA(xtemp(:,ind),ytemp);
    if sum(sum(isnan(w)))~=0
        break;
    end
    xtemp=test{method,i}{1,j};
    L = [ones(size(test{method,i}{1,j},1),1),xtemp(:,ind)]*w';
    p = exp(L) ./ repmat(sum(exp(L),2),[1 2]);
    if sum(sum(isnan(p)))~=0
        break;
    end
    [label,temp]=find(repmat(max(p'),2,1)==p');
    temp1=[0;temp];temp=([temp;0]==temp1);label(temp)=[];
    err(i,j)=mean(label~=test{method,i}{2,j});
    end
end
err_lda{method}=mean(err,2);
clear w p i j L label temp temp1 m mode method;
end
plot(1:50,err_lda{1},'LineWidth',2);hold all;
plot(1:50,err_lda{2},'LineWidth',2);xlabel('Number of Features');ylabel('error');legend('mRMR','MaxRel');title('LDA on ARR X');
toc;
end
