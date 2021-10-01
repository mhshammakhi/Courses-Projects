snr_vec=SNR;
snr_num=length(SNR);
intvl = zeros(1,snr_num);
switch modu_mode
    case 6
        for i=1:snr_num
            ber_vec(i) = berawgn(snr_vec(i),ber_mod,'nondiff');
        end
    case {5,1}
        for i=1:snr_num
            ber_vec(i) = berawgn(snr_vec(i),ber_mod,2,'nondiff');
        end
    case {3,4}
        for i=1:snr_num
            ber_vec(i) = berawgn(snr_vec(i),ber_mod,2*(modu_mode>3)+2);
        end
    case 2
        for i=1:snr_num
            ber_vec(i) = berawgn(snr_vec(i),ber_mod,2,'coherent');
        end
    case 7
        for i=1:snr_num
            ber_vec(i) = berawgn(snr_vec(i),ber_mod,precod,coh);
        end
        
end
for i=1:snr_num
    reset(hError);

    ErrStat = step(hError,data_bit,data_demod(: ,i));
    ErrRate(i) = ErrStat(1);
    ErrNum(i) = ErrStat(2);
end
for i=1:snr_num
    [~,interval] = berconfint...
        (ErrNum(i),length(data_demod),0.98);
    intvl(i) = mean(interval);
end