function [data_pow,data_mod,ber_mod,precod,coh]=Trans(data_bit,modu_mode,coh,is_gray)
%% Modulation Selection
precod=0;
switch modu_mode
    case 1
        %BPSK
        M = 2;
        data_m = length(data_bit);
        hMod = comm.PSKModulator('ModulationOrder',...
            M,'PhaseOffset',0,'BitInput',true);
        ber_mod = 'psk';
        
    case 2
        %BFSK
        M = 2;
        hMod = comm.FSKModulator(M,100);
        ber_mod = 'fsk';
        
    case 3
        %BASK
        M = 2;
        hMod = comm.GeneralQAMModulator;
        hMod.Constellation = [0 1];
        ber_mod = 'pam';
        
    case 4
        %16QAM
        mod_m = 16;
        data_m = log2(16)*floor(length(data_bit)/log2(16));
        hMod = comm.RectangularQAMModulator...
            ('ModulationOrder',mod_m,'BitInput',true);
        ber_mod = 'qam';
        
    case 5
        %QPSK
        mod_m = 4;
        hMod = comm.QPSKModulator...
            ('PhaseOffset',0,'BitInput',true);
        ber_mod = 'psk';
        
    case 6
        %OQPSK
        hMod = comm.OQPSKModulator...
            ('BitInput',true);
        ber_mod = 'oqpsk';
    case 7
        %MSK
        data_bit = data_bit;
        if coh
            coh = 'coherent';
            precod = 'off';
        else
            coh = 'noncoherent';
            precod = 'on';
        end
        hMod = comm.MSKModulator('BitInput',true);
        ber_mod = 'msk';
        
end
%% Apllying Modulation
switch modu_mode
    case 50
        data_mod = step(hMod,data_bit(1:data_m));
    otherwise
        data_mod = step(hMod,data_bit);
end
data_num = length(data_mod);
data_pow = data_mod'*data_mod/data_num;


