%SHANNON
disp('SHANNON');
%%
%vorudi gereftan
p=input('Enter probabilities in this way : [x1 x2 x3 x4 ....] : ');
len=length(p);if (len==1) disp('no need to coding'); break; end
%%
%Check sum of probabilities is 1.
if ((sum(p)-1>0.0001)||(sum(p)-1<-0.0001))
    error('Check Probabilities. Sum of al probabilities should be 1.');
end
%%
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
%%
%Display codes and indices
        str1=['n.= ',num2str(sum(na))];
        str8=['n = ',num2str(nb)];
        str2=['H = ',num2str(h)];
        str3=['e = ',num2str(w)];
        str4=['p = ',num2str(1-w)];
        str5=['e.=H.= ',num2str(y)];
        str6=['p.= ',num2str(1-y)];
        str7=['efficiency increase = ',num2str(val),' %' ];
        disp(code);
        disp('Before Coding:');
        disp(str8);disp(str2);disp(str3);disp(str4);
        disp('After Coding:')
        disp(str1);disp(str5);disp(str6);
        disp('with this coding:')
        disp(str7);