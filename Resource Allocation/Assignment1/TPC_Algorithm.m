%%
%define location
user_loc=(50*rand(2,Nu)-25);
path_gain=Path_gain_coef*sqrt(sum(user_loc.^2,1)).^-3; %estefade az hi=0.09*d-3
h=repmat(path_gain,Nu,1); %Because we have one Base Station
%%
%Check Feasibility
[isfeasible,rho]=feasibility(SINR,h);
pow_usrs=Pinit;
[Power_mat,SINR_mat,last_epoch]=pwr_updt(path_gain,pow_usrs,TSINR,sigma,Pmax);
