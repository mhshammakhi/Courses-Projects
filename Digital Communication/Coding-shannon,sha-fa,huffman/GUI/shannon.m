run getpro
if(cer==0)
%tashkile matrise koli
om=[p;1:len];
om=(sortrows(om',-1));
%%
%Sorting
d=sort(p,'descend');
%%
%Code length
tul=ceil(-log(d)/log(2));
%%
%Calculate  
%The average Huffman codeword length after & before coding (n) & (n.)
na=d.*tul;
nb=log(len)/log(2);
%the symbol entropy (H)
h=sum(-d.*(log(d)/log(2)));
%mohasebe e , e.
w=h*(log(2)/log(len));
y=h/sum(na);
%afzayesh randeman
val=(y-w)*100;    
%%
%Coding
 tul=sort(tul)';
code=cell(len,1);       
code{1}=num2str(floor(2*rand(1,tul(1))));
for i=2:len
    ended=1;
    while (ended==1)
    code{i}=num2str(floor(2*rand(1,tul(i))));
    w1=char(code(i));
    ended=0;
    for j=1:i-1
        w2=char(code(j));
        if w1(1:length(w2))==w2 ended=1; end
    end
    end
end
%%
%sakhte matrix koli
code=[num2cell(tul),cellstr(char((om(:,2))+64)),num2cell(om(:,1)),code];
code=[{'Code length','Symbol','Probability','Code'};code];
run display
end