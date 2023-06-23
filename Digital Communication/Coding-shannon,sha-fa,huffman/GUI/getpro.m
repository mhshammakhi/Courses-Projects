p = (get(handles.input,'string'));   
amg=[];
eh=[];
cer=0;
for i=2:length(p)
    kal=p(i);
    if (double(kal)==32)
        i=i+1;
        amg=[amg,str2num(eh)];
        eh=[];
    end
    if (double(kal)==93)
        amg=[amg,str2num(eh)];
        eh=[];
    end
    eh=[eh,kal];
end
p=amg;
len=length(p);
k=[1:len;p];k=k';
if abs(sum(p)-1)>0.00001
    cer=1;
    str1=['Sum of all probabilities should be 1'];
    set(handles.AC,'string',str1);
    set(handles.BC,'string',str1);
    set(handles.EF,'string',str1);
end