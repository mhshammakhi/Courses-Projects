%%
%define location
t=0;
P_new=Pinit;
PowerMatrix=zeros(1,9);
SinrMatrix=zeros(1,9);
sigma_noise=sigma;
epoch=1;
while(t<30)
x_5=40+t*5;
y_5=50;
pow_usrs=Pinit;
UserLoc=[[30;10],[20;40],[60;35],[70;90],[x_5;y_5],[110;80],[170;20],[200;30],[160;70]];
BsLoc=[[50;50],[150;50]];
distance1=sqrt(sum((UserLoc-repmat(BsLoc(:,1),1,9)).^2,1));
distance2=sqrt(sum((UserLoc-repmat(BsLoc(:,2),1,9)).^2,1));
assign_bs=(distance1>distance2)+1;
assign_bs=repmat(assign_bs,9,1);
pathgain_bs=Path_gain_coef*([distance1;distance2].^-3);
%%
path_gain=Path_gain_coef*sum([(distance1<distance2);(distance1>distance2)].*pathgain_bs,1); %estefade az hi=0.09*d-3
for i=1:9
    h(i,:)=pathgain_bs(assign_bs(i,:),i)';
end
%%
[SINR,Interference]=SINR_calculating2D(pow_usrs,h,sigma_noise);
P_new=(OPC_constant./(Interference./path_gain));
% P_new=min(P_new,1);
epoch=epoch+1;
PowerMatrix(epoch,:)=P_new;
SinrMatrix(epoch,:)=SINR;
last_epoch=epoch;
t=t+1e-3;
end

    

