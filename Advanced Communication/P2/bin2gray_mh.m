function gra=bin2gray_mh(bin)
N=size(bin,1);
for i=1:N
gra(i,:)=mod(bin(i,:)+[0,bin(i,1:(end-1))],2);
end