clear;clc;close all;
mode=1;PCAmode=0;criterion=1;
load('HDR.mat');
format long;
X=data;

[m,n]=size(X);
y=reshape(repmat(0:9,200,1),m,1);
clear data;

%%
%PCA or Not
if PCAmode==1
[coeff,score,latent] =pca(X);
X=score;
end
%%
%Edit data
mu=repmat(mean(X),size(X,1),1);
X=-(mu>=X)+((mu)<X);
clear mu;
if criterion==0
%%
%Mutal Information beetween feature and class
inf_fwc=zeros(1,n);
tic;
for i=1:n
inf_fwc(1,i)=mutualInf_dis(X(:,i),y);
end
toc;
%%
%Mutal Information beetween feature and feature
inf_fwf=zeros(n,n);
for i=1:n-1
    i
    for j=i+1:n
        inf_fwf(i,j)=mutualInf_dis(X(:,i),X(:,j));
        inf_fwf(j,i)=inf_fwf(i,j);
        
    end
end
%%
%best subsets
best_fea=cell(2,n);
best_fea{1,1}=find(max(inf_fwc)==inf_fwc,1);
best_fea{2,1}=find(max(inf_fwc)==inf_fwc,1);
for i=2:n
    temp1=(inf_fwc-sum(inf_fwf(:,best_fea{1,i-1}),2)'/(i-1))-ismember(1:n,best_fea{1,i-1})*10000;
    temp2=inf_fwc-ismember(1:n,best_fea{2,i-1})*10000;    
    best_fea{1,i}=[best_fea{1,i-1},find(max(temp1)==temp1,1)];
    best_fea{2,i}=[best_fea{2,i-1},find(max(temp2)==temp2,1)];
    clear temp1 temp2;
end
clear i j;
elseif criterion==1
for i=1:n
best_fea{1,i}=1:i;
best_fea{2,i}=1:i;
end
end
%%
%Make data for CV
for i=1:50
[train{1,i},test{1,i}]=kfold(X(:,best_fea{1,i}),y,10);
[train{2,i},test{2,i}]=kfold(X(:,best_fea{2,i}),y,10);
end
clear n i;
met={'mRMR','MaxRel'};
%%
if (mode==1)
%Using SVM
for method=1:2
ti(1)=10;
for i=1:50
    tic;
    for j=1:10
    z = multisvm(train{method,i}{1,j},train{method,i}{2,j},test{method,i}{1,j});
    er_ova(i,j)=mean(z-1~=test{method,i}{2,j});
    end
    ti(i+1)=toc;ti(i+1)=ceil((ti(i+1)^1.1)*(50-i)/60);
if ti(i+1)<ti(i)
    disp(['time reminding(method:',met{method},'):',num2str(ti(i+1)),' min']);
end
end
err_svm{method}=mean(er_ova,2);
clear i j ti er_ova ti z;
end
plot(1:50,err_svm{1},'LineWidth',2);hold all;
plot(1:50,err_svm{2},'LineWidth',2);xlabel('Number of Features');ylabel('error');legend('mRMR','MaxRel');title('SVM on HDR data');
clear train test k method;

%%
% % elseif (mode==2)
% % %Using NB
% % for i=1:50
% %     for j=1:10
% %     model=fitNaiveBayes(train{i}{1,j},train{i}{2,j});
% %     label=model.predict(test{i}{1,j});
% %     err(i,j)=mean(label-1~=test{i}{2,j});
% %     end
% % end
%%
elseif (mode==3)
%Use LDA
tic;
for method=1:2

for i=1:50
    for j=1:10
    w=LDA(train{method,i}{1,j},train{method,i}{2,j});
    L = [ones(size(test{method,i}{1,j},1),1),test{method,i}{1,j}]*w';
    p = exp(L) ./ repmat(sum(exp(L),2),[1 10]);
    [label,temp]=find(repmat(max(p'),10,1)==p');
    temp1=[0;temp];temp=([temp;0]==temp1);label(temp)=[];
    err(i,j)=mean(label-1~=test{i}{2,j});
    end
end
err_lda{method}=mean(err,2);
clear w p i j L label temp temp1 m mode method;
end
plot(1:50,err_lda{1},'LineWidth',2);hold all;
plot(1:50,err_lda{2},'LineWidth',2);xlabel=('Number of Features');ylabel=('error');legend('mRMR','MaxRel');title('LDA on HDR data');
toc;
end

