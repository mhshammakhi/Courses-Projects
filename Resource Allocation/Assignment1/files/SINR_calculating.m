function [SINR,Interference]=SINR_calculating(user_pow,path_gain,noise_pow)
signal=path_gain.*user_pow;
I=sum(path_gain.*user_pow)-signal;
Interference=I+noise_pow;
SINR=signal./(I+noise_pow);
SINR((SINR)==0)=eps;