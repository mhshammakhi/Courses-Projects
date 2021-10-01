function z = jointEntropy(x, y)
% Compute entropy H(x) of a discrete variable x.
% Written by Mo Chen (mochen80@gmail.com).
    assert(numel(x) == numel(y));
    n = numel(x);
    x = reshape(x,1,n);
    y = reshape(y,1,n);
	[ux,~,labelx] = unique(x);
    [uy,~,labely] = unique(y);
	numelu=max(numel(ux),numel(uy));
	Mx=sparse(1:n,labelx,1,n,numelu,n);
	My=sparse(1:n,labely,1,n,numelu,n);
	p = nonzeros(Mx'*My/n);
    z = -dot(p,log2(p+eps));
end