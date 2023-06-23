cd Data
load data_hand.mat;
X_train=tr>8;Y_train=y_train;X_test=te>8;Y_test=y_test;
clear te tr y_train y_test 
cd ../
X=[X_train;X_test]+0;y=[Y_train;Y_test];
[m,n]=size(X);