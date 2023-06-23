
lay = (get(handles.layer,'string'));
lay=round(str2num(lay));
b=ceil(log(lay)/log(2));
lay=2^b;
s = (get(handles.str,'string'));
len=length(s);
i=1;
while i<len+1
   
    while s(i)~='0' && s(i)~='1' 
    s(i)=[];
    len=len-1;
    if i>=length(s) 
        break;
    end
    end
   
      i=i+1;
    
    
end    
set(handles.str,'String',s);
h=char(s);
axes(handles.axes1)
num=0;
hold off;
bit=[];
