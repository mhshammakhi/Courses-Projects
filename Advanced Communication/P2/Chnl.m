function data_ch=Chnl(data_mod,snr_vec,modu_mode,data_pow,data_bit_len)
%% Specifiying SNR

snr_num = length(snr_vec);
data_ch = zeros(length(data_mod),snr_num);
%% Specifying BitsPerSymbol
BPS = 1;
SPS = 1;
switch modu_mode
    case 1
    case 2
        SPS = 17;
    case {5,6}
        BPS=4;
    case 7
        SPS = 8;
    otherwise
        BPS = data_bit_len/length(data_mod);
        
end
%% Configuring AWGN noise and Applying to Modulated Signal
for i=1:snr_num
    hCh = comm.AWGNChannel...
        ('NoiseMethod','Signal to noise ratio (Eb/No)','EbNo',...
        snr_vec(i),'BitsPerSymbol',BPS,'SamplesPerSymbol',SPS,...
        'SignalPower',data_pow);
    % snrttl(i) = sprintf...
    %     (' after noisy channel(SNR=%ddB)',snr_vec(i));
    data_ch(:,i) = step(hCh,data_mod);
end