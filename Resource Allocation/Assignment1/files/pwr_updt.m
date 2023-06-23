function [P_matrix,SINR_matrix,last_epoch]=pwr_updt(path_gain,user_power,target_SINR,sigma_noise,max_pwr_usr)
epoch=0;
P_new=user_power;
[SINR,Interference]=SINR_calculating(user_power,path_gain,sigma_noise);
max_itr=200;
max_error=1e-5;
P_matrix=P_new;
SINR_matrix=SINR;
while (max((SINR-target_SINR))>max_error && (epoch<max_itr))
    u_idx=randi([1 length(user_power)]);
    tmp=(target_SINR(u_idx).*(Interference(u_idx)./path_gain(u_idx)));
    P_new(u_idx)=min(tmp,max_pwr_usr);
    
    [SINR,Interference]=SINR_calculating(P_new,path_gain,sigma_noise);
    epoch=epoch+1;
    P_matrix(epoch+1,:)=P_new;
    SINR_matrix(epoch+1,:)=SINR;
end
last_epoch=epoch;

