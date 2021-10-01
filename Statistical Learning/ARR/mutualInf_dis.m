function z = mutualInf_dis(x, y)
% Compute entropy H(x) of a discrete variable x.
% Written by MH Shammakhi (mh.shammakhi@aut.ac.ir).
    assert(numel(x) == numel(y));
    %tic;
    temp=crosstab(x,y);
    %toc;
    temp=temp/sum(sum(temp));
    py=repmat(sum(temp,1),numel(unique(x)),1);px=repmat(sum(temp,2),1,numel(unique(y)));
    pxy=temp; 
    z=sum(sum(pxy.*log2(pxy./(px.*py))));    
end