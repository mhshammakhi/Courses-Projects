%Author: H.Rezai,MH.Shammakhi,M.Mardanshahi,H.Ghavami
%Last Modified by 30-Mar-2014 19:22
%%
clc;
clear;
cf1=pwd;
cf2=which ('runner');cf2=[cf2(1:end-8),'data'];
cd(cf2);
mo= input('mode: 1.shannon or 2.shannon-fano or 3.huffman? ' , 's');
x1='shannon'; x2='shannon-fano'; x3='huffman';
s1= strcmp(mo,x1)|strcmp(mo,'1');
s2= strcmp(mo,x2)|strcmp(mo,'2');
s3= strcmp(mo,x3)|strcmp(mo,'3');
if (s1)
shannon
elseif (s2)
shannonfano
elseif (s3)
huffman    
end
cd(cf1);