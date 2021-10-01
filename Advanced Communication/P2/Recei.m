function [data_demod,hError]=Recei(SNR,modu_mode,data_ch)
snr_num=length(SNR);
hError = comm.ErrorRate;
switch modu_mode
    case 1
        hDemod = comm.PSKDemodulator...
            ('ModulationOrder',2,...
            'PhaseOffset',0,'BitOutput',true);
    case 2
        hDemod = comm.FSKDemodulator(2,100);
    case 3
        hDemod = comm.GeneralQAMDemodulator;
        hDemod.Constellation = [0 1];
    case 4
        hDemod = comm.RectangularQAMDemodulator...
            ('ModulationOrder',16,'BitOutput',true);
    case 5
        hDemod = comm.QPSKDemodulator...
            ('PhaseOffset',0,'BitOutput',true);
    case 6
        hDemod = comm.OQPSKDemodulator...
            ('BitOutput',true);
        hError = comm.ErrorRate('ReceiveDelay',2,'ComputationDelay',8);
    case 7
        hDemod = comm.MSKDemodulator...
            ('BitOutput',true,'TracebackDepth',8);
        hError = comm.ErrorRate('ReceiveDelay',hDemod.TracebackDepth);
end
for i=1:snr_num
    data_demod(:,i) = step(hDemod,data_ch(:,i));
end