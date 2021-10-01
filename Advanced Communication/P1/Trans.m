%MPSK, QAM, 16ASK and 32ASK
function [T_inp_sig,sig_mod] = Trans(noe,inp_index,out1,out2)
   switch noe
     case 1
     M=out1;
     find_index=[];
     for i=1:M
     find_index=[find_index;(inp_index==i)];
     end
     sig_mod=exp(1i*2*pi*(0:(M-1))/M);
     T_inp_sig=sig_mod*find_index;
    case 2
    M=out1;        
    [x1,x2]=meshgrid(1:sqrt(M),1:sqrt(M));
    x1=1i*(x1*2-1-sqrt(M));
    x2=(x2*2-1-sqrt(M));
    QAM_Am=x1+x2;
    T_inp_sig  =  QAM_Am(inp_index);
    sig_mod=reshape(QAM_Am,1,M);
    case 3
    landa=out1;
    r2 = 1;
    r1 = r2/landa;    
    ind=1:16;
    amp(ind<5)=r1;
    amp(ind>4)=r2;
    pha(ind<5)=pi/4;
    pha(ind>4)=pi/12;
    ttASK_Am=amp.*exp(1j*(2*pha.*(0:15)+pi/4-floor(sqrt(0:15)/2)*(10)*pi/12));
    T_inp_sig  =  ttASK_Am(inp_index);
    sig_mod=ttASK_Am;
    case 4
    landa1=out1;
    landa2=out2;
    r3 = 1;
    r1 = r3/landa2;    
    r2 = landa1*r1;
    ind=1:32;
    amp(ind)=r1;
    amp(ind>4)=r2;
    amp(ind>16)=r3;
    pha(ind)=pi/4;
    pha(ind>4)=pi/12;
    pha(ind>16)=pi/16;
    ttASK_Am=amp.*exp(1j*(2*pha.*(0:31)+pi/4-floor(sqrt(0:31)/2)*(10)*pi/12-floor(sqrt(0:31)/4)*7*pi/12));
    T_inp_sig  =  ttASK_Am(inp_index);
    sig_mod=ttASK_Am;
   end
   
end