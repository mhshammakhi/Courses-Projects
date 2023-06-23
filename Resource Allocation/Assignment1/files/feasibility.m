function [isfeasible,rho]=feasibility(SINR,H)
A=H.*(1-eye(size(H)))./repmat(diag(H),1,size(H,2))*diag(SINR);
rho=max(abs(eig(A)));
if(sum(rho<1))
    isfeasible=1;
else
    isfeasible=0;
end