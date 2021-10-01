function z = mutualInf_dis_fwf(x, y)
% Compute entropy H(x) of a discrete variable x.
% Written by MH Shammakhi (mh.shammakhi@aut.ac.ir).
    assert(numel(x) == numel(y));
    %tic;
    temp(1,1)=sum((x==-1)&(y==-1));temp(1,2)=sum((x==-1)&(y==0));temp(1,3)=sum((x==-1)&(y==1));
    temp(2,1)=sum((x== 0)&(y==-1));temp(2,2)=sum((x== 0)&(y==0));temp(2,3)=sum((x== 0)&(y==1));
    temp(3,1)=sum((x== 1)&(y==-1));temp(3,2)=sum((x== 1)&(y==0));temp(3,3)=sum((x== 1)&(y==1));
    temp=temp/sum(sum(temp));
    py=repmat(sum(temp,1),3,1);px=repmat(sum(temp,2),1,3);
    pxy=temp;
    temp2=pxy.*log2(pxy./(px.*py));
    temp2(temp==0)=0;
    z=sum(sum(temp2));
    %toc;
end