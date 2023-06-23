function [SINR,I]=SINR_calculating2D(p,h,sigma_noise)
I=zeros(1,9);
SINR=zeros(1,9);
for i=1:9
    I(i)=((sum(h(i,:).*p)-h(i,i)*p(i))+sigma_noise);
    if (I(i)==0)
        I(i)=eps;
    end
    SINR(i)=(h(i,i)*p(i))/I(i);
end
SINR((SINR)==0)=eps;