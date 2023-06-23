%%
%Display codes and indices
      
        str8=['n = ',num2str(nb),char(10), 'H = ',num2str(h),char(10), 'e = ',num2str(w),char(10), 'p = ',num2str(1-w)];
        str1=['n.= ',num2str(sum(na)),char(10), 'e.=H.= ',num2str(y),char(10),'p.= ',num2str(1-y)];
        str7=[num2str(val),' %' ];

        set(handles.uitable4,'Data',code);
        set(handles.BC,'string',str8);
        set(handles.AC,'string',str1);
        set(handles.EF,'string',str7);
                