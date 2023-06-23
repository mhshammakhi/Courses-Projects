function z = mutualInf_dis_fwc(x, y)
% Compute entropy H(x) of a discrete variable x.
% Written by MH Shammakhi (mh.shammakhi@aut.ac.ir).
    assert(numel(x) == numel(y));
    %tic;
    temp(1,1)=sum((x== 0)&(y==0));temp(1,2)=sum((x== 0)&(y==1));temp(1,3)=sum((x== 0)&(y==2));temp(1,4)=sum((x== 0)&(y==3));temp(1,5)=sum((x== 0)&(y==4));temp(1,6)=sum((x== 0)&(y==5));temp(1,7)=sum((x== 0)&(y==6));temp(1,8)=sum((x== 0)&(y==7));temp(1,9)=sum((x== 0)&(y==8));temp(1,10)=sum((x== 0)&(y==9));
	temp(2,1)=sum((x== 1)&(y==0));temp(2,2)=sum((x== 1)&(y==1));temp(2,3)=sum((x== 1)&(y==2));temp(2,4)=sum((x== 1)&(y==3));temp(2,5)=sum((x== 1)&(y==4));temp(2,6)=sum((x== 1)&(y==5));temp(2,7)=sum((x== 1)&(y==6));temp(2,8)=sum((x== 1)&(y==7));temp(2,9)=sum((x== 1)&(y==8));temp(2,10)=sum((x== 1)&(y==9));
    
    temp=temp/sum(sum(temp));
    py=repmat(sum(temp,1),2,1);px=repmat(sum(temp,2),1,10);
    pxy=temp; 
    temp2=pxy.*log2(pxy./(px.*py));temp2(temp==0)=0;
    z=sum(sum(temp2));
    %toc;
end