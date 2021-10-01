function data_rec=Demodulate(de_noise_symb,sig_mod,gra)
M=numel(sig_mod);N=numel(de_noise_symb);
[~,data]=min(abs(repmat(de_noise_symb,M,1)-repmat(sig_mod',1,N)),[],1);
data_rec=dec2bin(data-1)';
data_rec=reshape(data_rec,1,size(data_rec,1)*size(data_rec,2));
end