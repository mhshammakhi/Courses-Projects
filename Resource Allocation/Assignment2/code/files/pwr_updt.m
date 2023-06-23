function [P_matrix,SINR_matrix,last_epoch]=pwr_updt(path_gain,user_power,opc_cons,pmax,sigma_noise)
P_condition=1;
P_new=user_power;
[SINR,Interference]=SINR_calculating(user_power,path_gain,sigma_noise);
max_itr=300;
max_error=1e-5;
P_matrix=P_new;
SINR_matrix=SINR;
epoch=1;
% path_gain=3.8720e-07*ones(1,5);

while  (P_condition && epoch<max_itr)
    P_pre=P_new;
    P_new=(opc_cons./(Interference./path_gain));
%     P_new=min(P_new,1);
    [SINR,Interference]=SINR_calculating(P_new,path_gain,sigma_noise);
    epoch=epoch+1;
    P_matrix(epoch+1,:)=P_new;
    SINR_matrix(epoch+1,:)=SINR;
    last_epoch=epoch;
    P_condition= max(abs(P_new-P_pre)>max_error);
    
end


