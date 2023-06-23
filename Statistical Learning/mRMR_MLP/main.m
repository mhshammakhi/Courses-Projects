clc;clear;close all;
%%
%Change Current Folder
temp=which('main.m');temp(end-6:end)=[];cd(temp);
%%
%Data Loading
run Data1.m
%%
cd mRMR
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
clear i j inf_fwc inf_fwf temp;
warning off;
%%
cd ..;
cd MLP;
st=30;fi=45;%size(X_train,2);
profile off;
profile on;
for H=st:fi
tic;
fprintf('H = %d \r',H);
X_train_H=X_train(:,best_fea{1,H});
X_test_H=X_test(:,best_fea{1,H});
[t_score,err_train(H)]=MLP(X_train_H,Y_train+1,X_test_H,50,100);
%%
%Rejection
temp=t_score;
clear t1;
[~,max_ind(1,:)]=max(temp,[],2);max_score(1,:)=max(temp,[],2);temp=temp.*(temp<repmat(max_score(1,:),size(temp,2),1)');
[~,max_ind(2,:)]=max(temp,[],2);max_score(2,:)=max(temp,[],2);max_ind=max_ind-1;
clear temp;
gua=(max_score(1,:)-max_score(2,:))>0.4;
%%
%Choosing best Local SVM
temp=10*max_ind(1,:)+max_ind(2,:);temp=temp(not(gua));
temp=histc(temp,0:99);temp1=100*reshape(temp,10,10);
max1max2_er=100*temp1./repmat(sum(temp1,2),1,10);
clear temp1;
n_local=45;
temp=[0:99;temp];
temp=sortrows(temp',-2)';
temp=temp(1,1:n_local)';
svmcvc_ind=[floor(temp/10),mod(temp,10)]';
for i=0:9
tr_mat{i+1}=X_train_H(Y_train==i,:);
end
%%
numb=1:numel(Y_test);
model_svm=cell(1,n_local);
for i=1:n_local
Xsvm=0+cell2mat([tr_mat(svmcvc_ind(1,i)+1);tr_mat(svmcvc_ind(2,i)+1)]);
Ysvm=[Y_train(Y_train==svmcvc_ind(1,i));Y_train(Y_train==svmcvc_ind(2,i))];
model_svm{i}=fitcsvm(Xsvm,Ysvm,'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
end
clear i Xsvm Ysvm temp1 temp net;
temp=max_ind;
for i=1:n_local
ind{i}=numb(sum(repmat(svmcvc_ind(:,i),1,size(temp,2))==temp,1)==2);
end
label_MLPSVM=[numb;max_ind(1,:)];
clear temp;
for i=1:n_local
temp=X_test_H(ind{i},:);
temp=predict(model_svm{i},temp+0);
label_MLPSVM(2,ind{i})=temp';
end
err_MLPSVM(H)=mean(label_MLPSVM(2,:)~=Y_test');
t1=toc;
fprintf('Time reminding %d minutes\r', ceil(t1*(fi-H)/60));
end
%%
%results
table2=[[0,0:9']',[0:9;max1max2_er]];
plot(st:fi,err_MLPSVM);
xlabel('Feature Number');ylabel('Misclassification Error');
[minimum_err,ind_min]=min(err_MLPSVM);
clear n numb max_score t_score temp X_test_H svmcvc_ind st fi X_train_H X Y tr_mat gua m H i max1max2_err t1 model_svm; 
profile viewer;
%%
%%
%%
%%
%%
H=38;
fprintf('H = %d \r',H);
X_train_H=X_train(:,best_fea{1,H});
X_test_H=X_test(:,best_fea{1,H});
[t_score,err_train(H)]=MLP(X_train_H,Y_train+1,X_test_H,50,300);
%%
%Rejection
temp=t_score;
clear t1;
[~,max_ind(1,:)]=max(temp,[],2);max_score(1,:)=max(temp,[],2);temp=temp.*(temp<repmat(max_score(1,:),size(temp,2),1)');
[~,max_ind(2,:)]=max(temp,[],2);max_score(2,:)=max(temp,[],2);max_ind=max_ind-1;
clear temp;
gua=(max_score(1,:)-max_score(2,:))>0.4;
%%
%Choosing best Local SVM
temp=10*max_ind(1,:)+max_ind(2,:);temp=temp(not(gua));
temp=histc(temp,0:99);temp1=100*reshape(temp,10,10);
max1max2_er=100*temp1./repmat(sum(temp1,2),1,10);
clear temp1;
n_local=45;
temp=[0:99;temp];
temp=sortrows(temp',-2)';
temp=temp(1,1:n_local)';
svmcvc_ind=[floor(temp/10),mod(temp,10)]';
for i=0:9
tr_mat{i+1}=X_train_H(Y_train==i,:);
end
%%
numb=1:numel(Y_test);
model_svm=cell(1,n_local);
for i=1:n_local
Xsvm=0+cell2mat([tr_mat(svmcvc_ind(1,i)+1);tr_mat(svmcvc_ind(2,i)+1)]);
Ysvm=[Y_train(Y_train==svmcvc_ind(1,i));Y_train(Y_train==svmcvc_ind(2,i))];
model_svm{i}=fitcsvm(Xsvm,Ysvm,'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
end
clear i Xsvm Ysvm temp1 temp net;
temp=max_ind;
for i=1:n_local
ind{i}=numb(sum(repmat(svmcvc_ind(:,i),1,size(temp,2))==temp,1)==2);
end
label_MLPSVM=[numb;max_ind(1,:)];
clear temp;
for i=1:n_local
temp=X_test_H(ind{i},:);
temp=predict(model_svm{i},temp+0);
label_MLPSVM(2,ind{i})=temp';
end
err=mean(label_MLPSVM(2,:)~=Y_test');

total_mat=[max_ind(1,:);label_MLPSVM(2,:)];
diffmat=total_mat(:,label_MLPSVM(2,:)~=max_ind(1,:));
