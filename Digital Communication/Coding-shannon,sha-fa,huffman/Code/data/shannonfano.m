%SHANNON-FANO
disp('SHANNON-FANO');
%%
%vorudi gereftan
p=input('Enter probabilities in this way : [x1 x2 x3 x4 ....] : ');
len=length(p); if (len==1) disp('no need to coding'); break; end
%sakhte matrix asli
p=[1:len;p];
%%
%Check sum of probabilities is 1.
ceil(sum(p(2,:)))
if ((sum(p(2,:))-1>0.0001)||(sum(p(2,:))-1<-0.0001))
    error('Check Probabilities. Sum of al probabilities should be 1.');
end
%%
%sorting
c=sortrows(p',-2);
%%
%sakhte matrix code
k=[];
for i=1:len
k=['0';k];
end
cods=cellstr(k);
%sakhte code
ended=0;
while (ended==0)
    %sar
    for i=1:len-1 
        if(strcmp(cods(i),cods(i+1)))
        sar=i;
        break;
        end
    end
    %tah
    for i=sar:len-1
        if(~strcmp(cods(i),cods(i+1)))
        tah=i;
        break;
        end
        if(i==len-1) 
            tah=len; 
        end
    end
    %coding
        %estesna
    if (tah-sar==1)
        na=cods(sar); na=char(na);na=[na,'0'];na=cellstr(na);cods(sar)=na;
        na=cods(tah); na=char(na);na=[na,'1'];na=cellstr(na);cods(tah)=na;
        tah=sar-3;
    end
        %coding omumi
    for i=sar:tah-2
        s1=abs(sum(c(i+1:tah,2))-sum(c(sar:i,2)));
        s2=abs(sum(c(i+2:tah,2))-sum(c(sar:i+1,2)));
        %peyda kardan behtarin adad baraye ijade 2 daste
        if(s1<s2)
            for x=sar:i
              na=cods(x); na=char(na);na=[na,'0'];na=cellstr(na);cods(x)=na;
            end
            for x=i+1:tah
              na=cods(x); na=char(na);na=[na,'1'];na=cellstr(na);cods(x)=na;
            end
            break;   
        end
        if(i==tah-2)
         i=tah-1;
            for x=sar:i
              na=cods(x); na=char(na);na=[na,'0'];na=cellstr(na);cods(x)=na;
            end
              na=cods(tah); na=char(na);na=[na,'1'];na=cellstr(na);cods(tah)=na;
        end    
    end
    %check kardane sharayete cod va tekrari nabudan
    ended=1;
    for i=2:len
        for j=1:i-1
           x=strcmp(cods(i),cods(j));
           if (x)  ended=0; end
        end
    end   
end
%%
%sakhte matrix koli
for i=1:len
na=cods(i);na=char(na);na(1)=[];na=cellstr(na);cods(i)=na;
end
sy=c(:,1);sy=sy+64;sy=char(sy);sy=cellstr(sy);
po=c(:,2);po=num2cell(po);
cods=[sy,po,cods];
tul=cods(:,3);tul=char(tul);tul=double(tul)-47;
for i=1:numel(tul)
if (tul(i)<= 0) tul(i)=0; 
else
    tul(i)=1;
end
end
tul=sum(tul,2);
cods=[cods,num2cell(tul)];
name=({'symbol','probability','code','code length'});
cods=[name;cods];
e=tul';
d=c(:,2)';
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
        disp(cods);
        disp('Before Coding:');
        disp(str8);disp(str2);disp(str3);disp(str4);
        disp('After Coding:')
        disp(str1);disp(str5);disp(str6);
        disp('with this coding:')
        disp(str7);
        
                