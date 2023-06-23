%HUFFMAN
disp('HUFFMAN');
%%
%vorudi gereftan
p=input('Enter probabilities in this way : [x1 x2 x3 x4 ....] : ');
len=length(p);if (len==1) disp('no need to coding'); break; end
%sakhte matrix asli
k=[1:len;p];k=k';
%%
%Check sum of probabilities is 1.
if ((sum(p)-1>0.0001)||(sum(p)-1<-0.0001))
    error('Check Probabilities. Sum of al probabilities should be 1.');
end
%%
%sorting
p=sort(p)';
%%
%sakkhte matrix marahele coding
col=1;
while col~=(len-1) 

    p(1,col+1)=p(1,col)+p(2,col);
    p(2:end,col+1)=[p(3:end,col);1];
    p=sort(p); 
    col=col+1;
end
%%
%coding
code =  cell(len,len-1);
raw=1;
code{raw,col}='0';
code{raw+1,col}='1';
while col~=1

s=p(raw,col-1)+p(raw+1,col-1);
 for i=1:len-col+1   
    if p(i,col)==s
    break;
    end
 end   
 code{1,col-1}=[code{i,col},'0'];
 code{2,col-1}=[code{i,col},'1'];
    
 if((i ~=1)&&(i ~=len-col+1)) 
        code(3:len-col+2,col-1)=[code(1:i-1,col);code(i+1:len-col+1,col)]; 
    elseif(i==1)
        code(3:len-col+2,col-1)=code(2:len-col+1,col);
    elseif(i==len-col+1)
        code(3:len-col+2,col-1)=code(1:len-col,col);
 end
 
col=col-1;
end

%sakhte matrix kolli
code=flipud(code(:,1));
k=sortrows(k,-2);
sy=char(k(:,1)+64);sy=cellstr(sy);
po=num2cell(k(:,2));
code=[sy,po,code];
tul=code(:,3);tul=char(tul);tul=double(tul)-47;
for i=1:numel(tul)
if (tul(i)<= 0) tul(i)=0; 
else
    tul(i)=1;
end
end
tul=sum(tul,2);
code=[code,num2cell(tul)];
name=({'symbol','probability','code','code length'});
code=[name;code];
e=tul';
d=k(:,2)';
%%
%Calculate  
%The average Huffman codeword length after & before coding (n) & (n.)
na=d.*e;
nb=log(len)/log(2);
%the symbol entropy (H)
h=sum(-d.*(log(d)/log(2)));
%mohasebe e , e.
w=h*(log(2)/log(len));
y=h/sum(na);
%afzayesh randeman
val=(y-w)*100;    
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
        
